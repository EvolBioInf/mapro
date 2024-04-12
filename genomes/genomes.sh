#!/usr/bin/bash
ts="Enterobacter cloacae subsp. cloacae ATCC 13047"
usage="$(basename $0) [-h] -t <typeStrain> -d <downloadDir>"
usage="$usage -n <neighborsDb>
Download target and neighbor genomes for a type strain.
Example: bash genomes.sh -t \"$ts\""
usage="$usage -d ecl -n neidb"
while getopts "ht:d:n:" arg; do
    case $arg in
          h) echo "$usage"
             exit;;
          t) strain=$OPTARG;;
          d) dir=$OPTARG;;
          n) db=$OPTARG;;
          \?) exit 1;;
    esac
done
if [[ ! $strain ]]; then
    echo "Please provide a type strain."
    echo "$usage"
    exit 1
fi
if [[ ! $dir ]]; then
    echo "Please provide a download directory."
    echo "$usage"
    exit 1
else
    if [[ -d $dir ]]; then
          echo "Download directory already exists."
          exit 1
    fi
fi
if [[ ! $db ]]; then
    echo "Please provide a Neighbors database."
    echo "$usage"
    exit 1
else
    if [[ ! -f $db ]]; then
          echo "Database $db doesn't exist."
          exit 1
    fi
fi
mkdir $dir
cd $dir
db="../$db"
tid=$(taxi "$strain" $db |
            tail -n +2 |
            awk '{print $2}')
echo $tid |
    neighbors -l $db > acc.txt
for a in t n; do
    grep ^${a} acc.txt |
          awk '{print $2}' > ${a}acc.txt
done
for a in t n; do
    datasets download genome accession \
               --inputfile ${a}acc.txt \
               --assembly-level complete \
               --exclude-atypical \
               --dehydrated \
               --filename ${a}data.zip
done
for a in t n; do
    if [[ -s ${a}data.zip ]]; then
          unzip ${a}data.zip -d ${a}data
          datasets rehydrate --directory ${a}data
    else
          if [[ -s tdata.zip ]]; then
              rm -r tdata*
          fi
          exit
    fi
done
mkdir all
for p in t n; do
    for a in ${p}data/ncbi_dataset/data/*/*.fna; do
          b=$(basename $a)
          mv $a all/${p}$b
    done
done
n=$(ls all/ | wc -l)
if [[ $n -le 1 ]]; then
    echo "Need at least two genomes to calculate phylogeny."
    exit 1
elif [[ $n -eq 2 ]]; then
    phylonium all/* |
        upgma |
        land > all.nwk
else
      phylonium all/* 2>/dev/null > all.phyl

      while grep -qw "nan" all.phyl
      do
      mkdir -p Rejected
             name=$(awk '{count=0; for(i=2; i<=NF;i++){if($i =="nan") count++}}{print $1, count}' all.phyl |
                        sort -n -k2,2 -r |
                        head -n 1  |
                        awk '{print $1}')
             
             mv all/$name Rejected/

             phylonium all/* 2>/dev/null > all.phyl
      done
      nj all.phyl |
          midRoot |
          land > all.nwk
fi
tc=$(fintac all.nwk |
           tail -n +2 |
           sort -k 6 -n -r |
           head -n 1 |
           awk '{print $1}')
mkdir targets

if [[ $tc =~ ^[0-9]+$ ]]; then

     pickle $tc all.nwk |
        grep -v '^#' |
        while read a; do
              ln -s $(pwd)/all/$a $(pwd)/targets/$a
        done
else

      pickle $tc all.nwk |  
            awk 'NR==2{print $2}'|
            while read a; do
              ln -s $(pwd)/all/$a $(pwd)/targets/$a
            done
fi
mkdir neighbors
pickle -c $tc all.nwk |
    grep -v '^#' |
    while read a; do
          ln -s $(pwd)/all/$a $(pwd)/neighbors/$a
    done
