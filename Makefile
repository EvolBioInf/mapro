scripts =  driver genomes markers primers
all: 
	test -d analysis || mkdir analysis; cp scripts/ex* analysis
	for script in $(scripts); do \
		make -C $$script; \
		cp $$script/$$script.sh scripts; \
	done
.PHONY: doc data newNeiDb
doc:
	make -C doc
ecl.db:
	make -C ecl.db
neidb:
	make -C neidb
newNeiDb:
	make -C newNeiDb

clean:
	make clean -C doc
	for script in $(scripts); do \
		make clean -C $$script; \
	done
	make clean -C data
