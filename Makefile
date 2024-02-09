scripts =  driver genomes markers primers
all: 
	test -d analysis || mkdir analysis; cp scripts/ex* analysis
	for script in $(scripts); do \
		make -C $$script; \
		cp $$script/$$script.sh scripts; \
	done
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
	for script in $(scripts); do \
		make clean -C $$script; \
	done
	make clean -C data
