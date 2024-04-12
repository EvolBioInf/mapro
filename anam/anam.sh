usage="$(basename $0) [-h]
Annotate amplicons for a list of targets.
Example: bash anam.sh < list.txt"
while getopts "h" opt; do
    case $opt in
          h) echo "$usage"
             exit;;
          \?) exit 1;;
    esac
done
while read dir acc type; do
    if [[ -s $dir/primers.fasta ]]; then
          cd $dir
          echo "Annotating $dir $type"
          awk '/^>/{printf ">S%dE\n", ++i}!/^>/' \
              markers.fasta > markers2.fasta
          keyMat -r -p primers.fasta markers2.fasta |
              grep -B 1 '^[0-9]' |
              sed 's/ - Reverse//;s/penalty:.*//' |
              tr '\n' ' ' |
              tr '#' '\n' |
              grep -v '^$' |
              sed 's/^ //' |
              awk '{print $1, $2, $3}' > lines.txt
          dir=$(dirname $0)
          res=$(awk -f ../$dir/findMarker.awk lines.txt)
          read name posF posR <<< $res
          markerStart=$posF
          l=$(getSeq r primers.fasta |
              cres |
              grep '^To' |
              awk '{print $2}')
          ((markerEnd=$posR+$l-1))
          getSeq $name markers2.fasta |
              cutSeq -r $markerStart-$markerEnd > amplicon.fasta
          for a in targets/*; do
              assembly=""
              r=$(grep $acc $a)
              if [[ $r != "" ]]; then
                    assembly=$(basename $a |
                            sed 's/^[tn]//;s/_[A-Z].*//')
                    break
              fi
          done
          if [[ $assembly != "" ]]; then
              continue
          fi
          datasets download genome accession $assembly \
                     --filename assembly.zip
          if [[ -d assembly ]]; then
              rm -r assembly
          fi
          unzip assembly.zip -d assembly
          mv assembly/*/*/*/*.fna assembly.fasta
          bc="blastn -task blastn -query amplicon.fasta"
          bc="$bc -subject assembly.fasta"
          bc="$bc -outfmt 6"
          br=$($bc | head -n 1)
          acc=$(echo $br | awk '{print $2}')
          start=$(echo $br | awk '{print $9}')
          end=$(echo $br | awk '{print $10}')
          datasets download genome accession $assembly \
                     --include gff3 --filename gff.zip
          if [[ -d gff ]]; then
              rm -r gff
          fi
          unzip gff.zip -d gff
          mv gff/*/*/*/genomic.gff .
          echo "#Annotation for interval ($start, $end)" > anam.txt
          awk -v a=$acc -v s=$start -v e=$end '$1==a && $4<=e && $5>=s' \
              genomic.gff |
              grep -v '^#' >> anam.txt
          cd -
    fi
done
