#!/usr/bin/bash
usage="$(basename $0) [-h] -d <downloadDir>
Use Fur to extract markers from targets and neighbors.
Example: bash markers.sh ecl"
while getopts "hd:" arg; do
    case $arg in
          h) echo "$usage"
             exit;;
          d) dir=$OPTARG;;
          \?) exit 1;;
    esac
done
if [[ ! $dir ]]; then
    echo "Please provide a download directory."
    echo "$usage"
    exit 1
else
    if [[ ! -d $dir ]]; then
          echo "Download directory $dir doesn't exist."
    fi
fi
cd $dir
makeFurDb -t targets -n neighbors -d all.db
fur -d all.db |
    cleanSeq > markers.fasta
