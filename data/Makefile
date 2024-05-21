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
results:
	wget https://owncloud.gwdg.de/index.php/s/rPphYKKUz0Uluvy/download
	mv download results.zip
	unzip results.zip
newNeidb: taxdump.tar.gz prokaryotes.txt eukaryotes.txt viruses.txt
	test ! -f neidb || rm neidb
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
	rm -rf neidb ecl.* *.dmp eukaryotes.txt gc.prt prokaryotes.txt readme.txt results results.zip taxdump.tar.gz viruses.txt
