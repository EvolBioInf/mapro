#!/usr/bin/bash
usage="$(basename $0) [-h -c -b <blastDb>] -n <neighborsDb>
Design and check primers for a list of targets.
Example making primers:   bash driver.sh -n neidb < list.txt
Example checking primers: bash driver.sh -n neidb -c"
usage="$usage -b <blastDb> < list.txt"
while getopts "hcb:n:" opt; do
    case $opt in
          h) echo "$usage"
             exit;;
          c) check=1;;
          b) bdb=$OPTARG;;
          n) ndb=$OPTARG;;
          \?) exit 1;;
    esac
done
if [[ $ndb ]]; then
    if [[ ! -f "$ndb" ]]; then
          echo "Can't find $ndb."
          exit 1
    fi
else
    echo "Please provide a Neighbors database."
    exit 1
fi
if [[ $check ]]; then
    if [[ $bdb ]]; then
        if [[ ! -f "$bdb.ndb" ]]; then
              echo "Can't find $bdb."
              exit 1
        fi
    else
        echo "Please provide a Blast database."
        exit 1
    fi
fi
while read dir acc type; do
    if [[ $dir =~ ^"#" ]]; then
          continue
    fi
    echo "Analyzing $dir $type"
    if [[ ! $check ]]; then
        if [[ -d $dir ]]; then
            rm -r $dir
        fi
        bash ../scripts/genomes.sh -t "$type" -d $dir -n $ndb
        nt=$(ls $dir/targets/ | wc -l)
        nn=$(ls $dir/neighbors | wc -l)
        if [[ $nt -eq 0 || $nn -eq 0 ]]; then
            continue
        fi
        bash ../scripts/markers.sh -d $dir
        for a in $dir/all/*; do
            grep '^>' $a > $dir/tmp
            mv $dir/tmp $a
        done
        rm -r $dir/all.db
        rm -r $dir/tdata* $dir/ndata*
        if [[ ! -s $dir/markers.fasta ]]; then
            continue
        fi
        bash ../scripts/primers.sh -d $dir
    else
        if [[ ! -s $dir/primers.fasta ]]; then
            continue
        fi
        bash ../scripts/primers.sh -c -d $dir -b $bdb -t "$type" \
             -a $acc -n "$ndb"
    fi
done
