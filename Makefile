scripts =  anam driver genomes markers primers
packs = fur biobox neighbors prim

all: scripts/findMarker.awk
	test -d analysis || mkdir analysis; cp scripts/ex* analysis
	for script in $(scripts); do \
		make -C $$script; \
		cp $$script/$$script.sh scripts; \
	done
scripts/findMarker.awk: anam/anam.org
	make -C anam
	cp anam/findMarker.awk scripts/
.PHONY: doc data newNeidb
doc:
	make -C doc
ecl.db:
	make ecl.db -C data
neidb:
	make neidb -C data
newNeidb:
	make newNeidb -C data
results:
	make results -C data

clean:
	make clean -C doc
	make clean -C data
	for script in $(scripts); do \
		make clean -C $$script; \
	done
	for packs in $(packs); do\
		rm -rf $$packs; \
	done
	rm -rf phylonium
	rm -rf bin
	rm README_DOCKER.md

docker:
	for pack in $(packs); do \
		test -d $$pack || git clone git@github.com:EvolBioInf/$$pack; \
		cd $$pack && git pull && make && cd ../; \
	done
	mkdir -p bin
	cp fur/bin/cleanSeq fur/bin/fur fur/bin/makeFurDb bin
	cp biobox/bin/getSeq biobox/bin/cutSeq biobox/bin/midRoot biobox/bin/nj \
	biobox/bin/cres biobox/bin/keyMat biobox/bin/upgma bin
	cp neighbors/bin/* bin
	cp prim/bin/* bin
	cp Docker/README.md README_DOCKER.md
	docker build -f Docker/Dockerfile -t mapro .