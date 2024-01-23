#!/bin/bash

# Install linux dependencies
apt-get update

apt-get -y upgrade

apt-get -y install apt-utils sudo curl wget git make cmake autoconf build-essential noweb pkg-config golang

apt-get -y install zip unzip

#install biobox & phylonium dependencies
apt-get -y install gnuplot graphviz libgsl-dev make noweb libdivsufsort-dev libdivsufsort3


apt-get clean

# Get external dependencies

## install blastn
apt-get install ncbi-blast+

##install primer3

apt-get install primer3


## install datasets
cd Bin

curl -o datasets 'https://ftp.ncbi.nlm.nih.gov/pub/datasets/command-line/v2/linux-amd64/datasets'

curl -o dataformat 'https://ftp.ncbi.nlm.nih.gov/pub/datasets/command-line/v2/linux-amd64/dataformat'

chmod +x datasets dataformat

ln -s /home/mapro/Bin/* /usr/local/bin

cd /home/mapro
