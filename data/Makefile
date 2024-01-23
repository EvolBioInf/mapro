ncbi=ftp.ncbi.nlm.nih.gov
genomes=$(ncbi)/genomes/GENOME_REPORTS
all: neidb ecl.ndb

neidb:
	wget https://owncloud.gwdg.de/index.php/s/G2MFEWf0Q1TUbxO/download
	mv download neidb

ecl.ndb:
	wget https://owncloud.gwdg.de/index.php/s/Fs1K9kZJlY7BDmb/download
	mv download ecl.tgz
	tar -xvzf ecl.tgz
	rm ecl.tgz

clean:
	rm -f neidb ecl.*
