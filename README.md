# `mapro`: Markers for Prokaryotes
## Authors
Beatriz Vieira Mourato and Bernhard Haubold

## Description

Shell scripts to discover and evaluate candidate marker regions in
[reference
prokaryotes](https://https://ftp.ncbi.nlm.nih.gov/genomes/GENOME_REPORTS/prok_reference_genomes.txt).

## Set Up Analysis

Run

`$ make`  

This constructs three main scripts and one auxiliary script. The three
main scripts are `genomes.sh` for downloading target and neighbor
genomes, `markers.sh` for extracting markers from the genomes, and
`primers.sh` for designing primers from the markers and testing
them. The auxiliary script `driver.sh` is used to run the analysis of
one or more prokaryotes. All scripts are located in the directory
`scripts` and are explained in the documentation.

## Run Toy Analysis

The initial `make` also constructs and prepares the directory
`analysis`. We change into it and run the example script for
generating primers.

`$ cd analysis`

`$ bash examplePrimers.sh`

Two analyses are attempted, the first for *Aquifex aeolicus* fails due
to a lack of genomes. However, the second for *Enterobacter cloacae*
succeeds. The markers for *E. cloacae* are now contained in
`ecl/markers.fasta`, the primers in `ecl/primers.fasta`. To calculate
the sensitivity and specificity of these markers, we run the other
example script.

`$ bash exampleChecking.sh`

The sensitivity and specificity measures based on the taxonomy are now
in `ecl/scop.out`, and the corrected sensitivity and specificity
measures are in `ecl/cops.out`.

## Run Full Analysis

We make markers and primers for all prokaryotes in `list.txt`.  

`$ bash ../scripts/driver.sh -n ../data/neidb < ../data/list.txt`  

To check the primers, we run  

`$ bash ../scripts/driver.sh -n ../data/neidb -b <blastDb> < ../data/list.txt`  

We use `nt` as our database for checking primers. This makes checking
slow, and it might be a good idea to check only primers for organisms
of particular interest.

## Make Documentation

To generate the documentation, run

`$ make doc`  

The documentation is now in `doc/mapro.pdf`.

## Run Docker container
Alternatively, there is also a docker container available.

To get the docker run: \
`$ docker pull beatrizvm/mapro`

It can then be run with:

`$ docker run -it beatrizvm/mapro`


## Dependencies
### Apt Packages

Running `mapro` requires installation of a number of apt packages:

`$ sudo apt install bc phylonium ncbi-blast+ primer3 noweb`

It also requires the NCBI CLI [datasets and dataformat](https://www.ncbi.nlm.nih.gov/datasets/docs/v2/download-and-install/)

For the documentation these extra packages are required:  

`$ sudo apt install texlive-science texlive-pstricks
texlive-latex-extra texlive-fonts-extra`


### Other packages

We also need the packages
[Neighbors](https://github.com/evolbioinf/neighbors),
[Fur](https://github.com/evolbiofinf/fur),
[Prim](https://github.com/evolbioinf/prim), and
[Biobox](https://github.com/evolbioinf/biobox).


