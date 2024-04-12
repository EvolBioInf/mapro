#!/usr/bin/bash
ts="Enterobacter cloacae subsp. cloacae ATCC 13047"
a="CP001918"
usage="$(basename $0) [-h -c -b <blastDb> -t <typeStrain>"
usage="$usage -a <typeAcc> -n <neighborsDb>]"
usage="$usage -d <downloadDir>
Design and check primers.
Example without checking: bash primers.sh -d ecl
Example with checking: bash primers.sh -d ecl -c"
usage="$usage -b /ssd01/Nt/nt -t \"$ts\" -a $a -n neidb"
while getopts "hcb:t:n:d:a:" opt; do
    case $opt in
          h) echo "$usage"
             exit;;
          c) check=1;;
          b) bdb=$OPTARG;;
          t) strain=$OPTARG;;
          n) ndb=$OPTARG;;
          d) dir=$OPTARG;;
          a) typeAcc=$OPTARG;;
          \?) exit 1;;
    esac
done
if [[ $dir ]]; then
    if [[ ! -d $dir ]]; then
          echo "Download directory $dir doesn't exist."
          exit 1
    fi
else
    echo "Please enter a dowload directory."
    echo "$usage"
    exit 1
fi
if [[ $check ]]; then
    if [[ ! -s "$dir/primers.fasta" ]]; then
        echo "Can't find primers in $dir/primers/fasta"
        exit 1
    fi
    if [[ $bdb ]]; then
        if [[ ! -f "$bdb.ndb" ]]; then
              echo "Can't find Blast db $bdb."
              exit 1
        fi
    else
        echo "Please provide a Blast db."
        echo "$usage"
        exit 1
    fi
    if [[ ! $strain ]]; then
        echo "Please set the type strain."
        echo "$options"
        exit 1
    fi
    if [[ $ndb ]]; then
        if [[ ! -f $ndb ]]; then
              echo "Can't find Neighbors database $ndb."
              exit 1
        fi
    else
        echo "Please provide a Neighbors database."
        echo "$options"
        exit 1
    fi
fi
cd $dir
if [[ "$ndb" != "/"* ]]; then
    ndb="../$ndb"
fi
if [[ "$bdb" != "/"* ]]; then
    bdb="../$bdb"
fi
if [[ "$ref" != "/"* ]]; then
    ref="../$ref"
fi
if [[ ! $check ]]; then
    fa2prim markers.fasta |
        primer3_core |
        prim2tab |
        tail -n +2 |
        sort -n |
        head -n 1 |
        while read p f r i; do
              printf ">f penalty: %s\n%s\n>r\n%s\n" \
                     $p $f $r > primers.fasta
              break
        done
else
    tid=$(taxi "$strain" $ndb |
                tail -n +2 |
                awk '{print $2}')
    echo $tid |
        neighbors $ndb |
        grep '^t' |
        awk '{print $2}' > taxa.txt
    scop -d $bdb -t taxa.txt primers.fasta > scop.out
    for a in targets/*; do
        r=$(grep $typeAcc $a)
        if [[ $r != "" ]]; then
              leafLabel=$(basename $a)
              break
        fi
    done
    if [[ $leafLabel != "" ]]; then
         
    targetClade=$(fintac all.nwk |
                        tail -n +2 |
                        head -n 1 |
                        awk '{print $1}')
    t=$(climt $leafLabel all.nwk |
              awk -v v=$targetClade '$2==v{print 2*($3+$4)}')
    threshold=$t
    r=$(grep '^False' scop.out)
    if [[ $r != "" ]]; then
        cops -D -d $bdb -r $typeAcc -t $threshold \
               scop.out > cops.out
    else
        cp scop.out cops.out
    fi
    fi
fi
