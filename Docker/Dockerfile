#Get docker 
FROM debian:stable-slim

LABEL authors="Beatriz Vieira Mourato"

#Set working directory
WORKDIR /home/mapro 

#Add user
RUN useradd -m -p NbqDBxZy0F.tE -s /bin/bash mapro && usermod -aG sudo mapro

#Copy mapro folder to docker
RUN mkdir /home/mapro/Shared

#Move dependencies to usr/local bin
#and import data, analysis, scripts and README.md
COPY . /home/mapro/

#Get blastn, primer3, libdivsufsort and phylonium
RUN apt-get update -y && \
    apt-get -y upgrade && \
    apt-get install --no-install-recommends -y zip \
    unzip \
    ncbi-blast+\
    primer3 \
    libgsl-dev\
    libdivsufsort-dev \
    libdivsufsort3 \
    phylonium &&\
    apt-get clean &&\
    apt-get autoremove -y

# Get curl and install datasets and dataformat

RUN apt-get install -y curl && \
    curl -o datasets 'https://ftp.ncbi.nlm.nih.gov/pub/datasets/command-line/v2/linux-amd64/datasets' && \
    curl -o dataformat 'https://ftp.ncbi.nlm.nih.gov/pub/datasets/command-line/v2/linux-amd64/dataformat' && \
    chmod +x datasets dataformat && \
    mv datasets /usr/local/bin/ &&\
    mv dataformat /usr/local/bin/ &&\
    apt-get remove -y curl && \
    apt-get autoremove -y
    
#Get wget and obtain mapro datasets data
    
RUN apt-get install --no-install-recommends -y wget && \
    wget https://owncloud.gwdg.de/index.php/s/G2MFEWf0Q1TUbxO/download && \
    mv download neidb && \
    mv neidb /home/mapro/data && \
    wget https://owncloud.gwdg.de/index.php/s/Fs1K9kZJlY7BDmb/download && \
    mv download ecl.tgz && \
    tar -xvzf ecl.tgz && \
    rm ecl.tgz && \
    mv ecl.n* /home/mapro/data  &&\
    mv README_DOCKER.md README.md && \
    mv bin/* /usr/local/bin &&\
    rm -r bin
    #apt-get remove -y wget && \
    #apt-get autoremove -y 


#Get make and Give permissions 
RUN apt-get install --no-install-recommends -y make sudo && \
    chown root:root /usr/bin/sudo && \
    chmod 4755 /usr/bin/sudo && \
    chown -R mapro /home/mapro/ && \
    chgrp -R mapro /home/mapro/ &&\
    rm -rf /var/lib/apt/lists/*

USER mapro

ENV HOME /home/mapro