#Get docker 
FROM debian:stable-slim

LABEL authors="Beatriz Mourato"

#Set working directory
WORKDIR /home/mapro

#Add user
RUN useradd -m -p NbqDBxZy0F.tE -s /bin/bash mapro
RUN usermod -aG sudo mapro


#RUN mkdir /home/mapro/
RUN mkdir /home/mapro/data
RUN mkdir /home/mapro/Bin

#Copy files to docker

#Get all of mapro dependencies
##Start docker from parental dir

COPY . /home/mapro

COPY Docker/linux_dependencies.sh .

#Install basic linux dependencies
RUN ["chmod", "+x", "./linux_dependencies.sh"]

RUN ./linux_dependencies.sh

#Add go to path
ENV PATH="$PATH:/usr/local/go/bin"


COPY Docker/get_programs.sh .

#Install programs dependencies
RUN ["chmod", "+x", "./get_programs.sh"]

RUN ./get_programs.sh


RUN rm -r linux_dependencies.sh
RUN rm -r get_programs.sh


#Compile mapro
RUN ["make"]

#Give permissions 
RUN chown root:root /usr/bin/sudo && chmod 4755 /usr/bin/sudo
RUN chown -R mapro /home/mapro/
RUN chgrp -R mapro /home/mapro/

USER mapro
ENV HOME /home/mapro
WORKDIR /home/mapro