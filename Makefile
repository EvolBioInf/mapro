scripts =  driver genomes markers primers
all: 
	test -d analysis || mkdir analysis; cp scripts/ex* analysis
	for script in $(scripts); do \
		make -C $$script; \
		cp $$script/$$script.sh scripts; \
	done
.PHONY: doc data
doc:
	make -C doc

data:
	make -C data

clean:
	make clean -C doc
	for script in $(scripts); do \
		make clean -C $$script; \
	done
	make clean -C data
