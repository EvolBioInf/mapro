# `mapro`: Markers for Prokaryotes
## Authors
Beatriz Vieira Mourato and Bernhard Haubold

## Description

This package contains shell scripts to discover and evaluate candidate
marker regions in [reference
prokaryotes](https://https://ftp.ncbi.nlm.nih.gov/genomes/GENOME_REPORTS/prok_reference_genomes.txt).

## Set Up Analysis

Run

`$ make`  

This constructs four scripts: `genomes.sh` for downloading target and
neighbor genomes, `markers.sh` for extracting markers from the
genomes, and `primers.sh` for designing primers from the markers and
testing them. The auxiliary script `driver.sh` drives the analysis of
one or more prokaryotes. These four scripts are located in the
directory `scripts` and are explained in the documentation
`doc/mapro.pdf`.

## Run Toy Analysis
To run the toy analysis we need a small database of *Enterobacter
cloacae* sequences, which we download from the net.

`$ make ecl.db`

We also need a Neighbors database, which we also get ready-made from
the net.

`$ make neidb`

This database allows us to reproduce the analysis of bacterial taxa
described in our forthcoming publication. Alternatively, you can
construct the Neighbors database from scratch using the [current
database
dump](https://ftp.ncbi.nlm.nih.gov/pub/taxonomy/taxdump.tar.gz) and
[genome files](https://ftp.ncbi.nlm.nih.gov/genomes/GENOME_REPORTS).

`$ make newNeidb`

We change into the directory `analysis` constructed with
the initial `make`, and run the example script for
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

We can use hashes, `#`, to comment out lines in `list.txt`. To check
the primers, we run

`$ bash ../scripts/driver.sh -n ../data/neidb -c -b <blastDb> < ../data/list.txt`

We use `nt` as our database for checking primers. This makes checking
slow, and it might be a good idea to check only primers for organisms
of particular interest.

## Get Results of Full Analysis
Rather than running the full analysis, the markers can be downloaded
from inside the `mapro` directory by running

`$ make results`

The maker sequences for the 68 successful analyses are now contained
in `data/results/`*tag*`.fasta`, where *tag* refers to strain names
that can be resolved using the entries in `list.txt`.

## Make Documentation

To generate the documentation, run

`$ make doc`  

The documentation is now in `doc/mapro.pdf`.

## Run Docker container
Alternatively, there is also a docker container available. To get the
docker run:

`$ docker pull beatrizvm/mapro`

It can then be run iteratively with:

`$ docker run -h docker -it beatrizvm/mapro`

Where

`-h` changes container's host name for easier readability (in this
case to docker),  
`-it` runs the container in a CLI interactive mode

If you want to create a link between the docker container and your own terminal,
you can add a mount flag (-v). This will create and link a newly made directory
("Shared_mapro") in your home directory and the directory "Shared" within the
container. Files placed within this shared directory can be accessed
within/outside the docker.

For example:

 `$ docker run -v ~/Shared_mapro:/home/mapro/Shared -h docker -it beatrizvm/mapro`

The shared directory makes it possible to access files from outside the docker
or results from the analysis saved to this directory. 

For practical purposes, only a small subset of `nt` is actually contained within
the docker. It would then be possible, for example, to share the directory with
a local `nt` database, and access it from within the docker. This would remove
the need to download the `nt` database directly within the docker.

To exit the docker terminal, use either `ctr-D` or the command `exit`.

The directory "Extras" contains the documentation for the installed packages
(neighbors, fur, prim, biobox and
[phylonium](https://github.com/evolbioinf/prim)).

## Dependencies
### Apt Packages

Running `mapro` requires installation of a number of apt packages:

`$ sudo apt install bc phylonium ncbi-blast+ primer3 noweb`

It also requires the command line tool [`datasets`](https://www.ncbi.nlm.nih.gov/datasets/docs/v2/download-and-install/)

For the documentation these extra packages are required:  

`$ sudo apt install texlive-science texlive-pstricks
texlive-latex-extra texlive-fonts-extra`


### Other packages

We also need the packages
[Neighbors](https://github.com/evolbioinf/neighbors),
[Fur](https://github.com/evolbioinf/fur),
[Prim](https://github.com/evolbioinf/prim), and
[Biobox](https://github.com/evolbioinf/biobox).

## License
[GNU General Public License](https://www.gnu.org/licenses/gpl.html)
