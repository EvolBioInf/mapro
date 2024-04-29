# `mapro`: Markers for Prokaryotes
## Authors
Beatriz Vieira Mourato and Bernhard Haubold

## Description

This README file is associated with the mapro docker container only. For a more
in-depth description of the mapro repository, please check the main README file
obtained in the git repository.

## Docker dependencies

The distributed docker version is slimmed down to reduce the amount of memory
required. Due to this, only a selected sample of programs and dependencies are
installed.


First, it contains 5 packages necessary for running `mapro`:
[Neighbors](https://github.com/evolbioinf/neighbors),
[Fur](https://github.com/evolbiofinf/fur),
[Biobox](https://github.com/evolbioinf/biobox) and
[phylonium](https://github.com/evolbioinf/prim).

From biobox it contains `nj`, `midroot`, `UPGMA`, `GetSeq`, `CutSeq`, `keyMat` and `cres`.

Should you wish to install any additional package, the default sudo password is
"password".

## Data set

The container is pre-compiled and you can start by running directly the toy
example. In the analysis directory run

`$ bash examplePrimers.sh`

for creating the primers or 

`$ bash exampleChecking.sh`

for calculating the sensitivity and specificity of the primers based on the
given taxonomy version.

Should you wish to update the neighbors database to the latest version, change
to the data directory and run: 

`$ make clean` followed by `$ make newNeiDb`

This will download the latest files on the NCBI taxonomy taxdump (prokaryotes,
eukaryotes and viruses).


## Known issues

When running the docker container with a shared folder (-v) it may occur you do
not have permission to access the Shared folder within the docker.
To solve this run

`$ chown -R mapro /home/mapro/Shared`
`$ chgrp -R mapro /home/mapro/Shared`

The folder permissions are now set to the user (mapro) and you have write
permission.

To exit the docker terminal, use either `ctr-D` or the command
`exit`.