#!/bin/bash

# Install linux dependencies
apt-get update

apt-get -y upgrade

apt-get -y install apt-utils sudo curl wget git make cmake autoconf build-essential noweb pkg-config

apt-get -y install zip unzip


#install golang

wget https://go.dev/dl/go1.21.6.linux-amd64.tar.gz

tar -C /usr/local -xzf go1.21.6.linux-amd64.tar.gz

#echo 'export PATH=$PATH:/usr/local/go/bin' >> /etc/profile


#install biobox & phylonium dependencies
apt-get -y install gnuplot graphviz libgsl-dev make noweb libdivsufsort-dev libdivsufsort3


apt-get clean

# Get external dependencies

## install blastn
apt-get -y install ncbi-blast+

##install primer3

apt-get -y install primer3


## install datasets
cd Bin

curl -o datasets 'https://ftp.ncbi.nlm.nih.gov/pub/datasets/command-line/v2/linux-amd64/datasets'

curl -o dataformat 'https://ftp.ncbi.nlm.nih.gov/pub/datasets/command-line/v2/linux-amd64/dataformat'

chmod +x datasets dataformat

ln -s /home/mapro/Bin/* /usr/local/bin

cd /home/mapro
