#!/bin/bash

# Create Git directory
mkdir -p Git

cd Git

# Get repositories dependencies
## install biobox

git clone https://github.com/EvolBioInf/biobox.git

cd biobox
make

ln -s /home/mapro/Git/biobox/bin/* /usr/local/bin

cd ..

## install neighbors

git clone https://github.com/EvolBioInf/neighbors.git

cd neighbors
make

ln -s /home/mapro/Git/neighbors/bin/* /usr/local/bin

cd ..

## install phylonium

git clone https://github.com/evolbioinf/phylonium

cd phylonium

autoreconf -fi -Im4
./configure
make
make install

ln -s /home/mapro/Git/phylonium/src/phylonium /usr/local/bin

cd ../

## install fur

git clone https://github.com/EvolBioInf/fur.git

cd fur
make

ln -s /home/mapro/Git/fur/bin/* /usr/local/bin

cd ..

## install prim

git clone https://github.com/EvolBioInf/prim.git

cd prim
make

ln -s /home/mapro/Git/prim/bin/* /usr/local/bin


# Get mapro data files

cd /home/mapro

wget https://owncloud.gwdg.de/index.php/s/G2MFEWf0Q1TUbxO/download
mv download neidb
mv neidb /home/mapro/data


wget https://owncloud.gwdg.de/index.php/s/Fs1K9kZJlY7BDmb/download
mv download ecl.tgz

tar -xvzf ecl.tgz
rm ecl.tgz

mv ecl.n* /home/mapro/data

cd /home/mapro
