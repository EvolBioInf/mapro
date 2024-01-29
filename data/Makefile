ncbi=ftp.ncbi.nlm.nih.gov
genomes=$(ncbi)/genomes/GENOME_REPORTS

all: neidb ecl.db
neidb:
	wget https://owncloud.gwdg.de/index.php/s/G2MFEWf0Q1TUbxO/download
	mv download neidb

ecl.db:
	wget https://owncloud.gwdg.de/index.php/s/Fs1K9kZJlY7BDmb/download
	mv download ecl.tgz
	tar -xvzf ecl.tgz
	rm ecl.tgz
newNeidb: taxdump.tar.gz prokaryotes.txt eukaryotes.txt viruses.txt
	makeNeiDb
taxdump.tar.gz:
	wget $(ncbi)/pub/taxonomy/taxdump.tar.gz
	tar -xvzf taxdump.tar.gz
prokaryotes.txt:
	wget $(genomes)/prokaryotes.txt
eukaryotes.txt:
	wget $(genomes)/eukaryotes.txt
viruses.txt:
	wget $(genomes)/viruses.txt
clean:
	rm -f neidb ecl.* *.dmp eukaryotes.txt gc.prt prokaryotes.txt readme.txt taxdump.tar.gz viruses.txt
