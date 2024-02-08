#Get docker 
FROM debian:stable-slim

LABEL authors="Beatriz Mourato"

#Set working directory
WORKDIR /home/mapro 

#Add user
RUN useradd -m -p NbqDBxZy0F.tE -s /bin/bash mapro && usermod -aG sudo mapro

#Create directories
RUN mkdir /home/mapro/data && \
    mkdir /home/mapro/Bin && \
    mkdir /home/mapro/Extras &&\
    mkdir /home/mapro/Shared

#Get blastn, primer3 and libdivsufsort libraries
RUN apt-get update -y && \
    apt-get -y upgrade && \
    apt-get install --no-install-recommends -y zip \
    unzip \
    ncbi-blast+\
    primer3 \
    libgsl-dev\
    libdivsufsort-dev \
    libdivsufsort3 &&\
    apt-get clean &&\
    apt-get autoremove -y

    # Get curl and install datasets and dataformat

RUN apt-get install -y curl && \
    curl -o datasets 'https://ftp.ncbi.nlm.nih.gov/pub/datasets/command-line/v2/linux-amd64/datasets' && \
    curl -o dataformat 'https://ftp.ncbi.nlm.nih.gov/pub/datasets/command-line/v2/linux-amd64/dataformat' && \
    chmod +x datasets dataformat && \
    mv datasets /home/mapro/Bin &&\
    mv dataformat /home/mapro/Bin &&\
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
    mv ecl.n* /home/mapro/data 
    #apt-get remove -y wget && \
    #apt-get autoremove -y 


#Copy mapro folder to docker
COPY . /home/mapro 

#Move dependencies to Bin and Remove Docker directory
#Get make And compile mapro
RUN mv Docker/Manuals/*  /home/mapro/Extras/ && \
    mv Docker/README.md /home/mapro/README_DOCKER.md &&\
    unzip Docker/programs/dependencies.zip -d /home/mapro/Bin &&\
    rm -r Docker &&\
    ln -s /home/mapro/Bin/* /usr/local/bin &&\
    apt-get install --no-install-recommends -y make noweb && \
    make && \
    apt-get autoremove -y 

#Give permissions 
RUN apt-get install --no-install-recommends -y sudo && \
    chown root:root /usr/bin/sudo && \
    chmod 4755 /usr/bin/sudo && \
    chown -R mapro /home/mapro/ && \
    chgrp -R mapro /home/mapro/ &&\
    rm -rf /var/lib/apt/lists/*

USER mapro

ENV HOME /home/mapro