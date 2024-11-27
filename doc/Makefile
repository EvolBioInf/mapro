TEXT = mapro
SRC1 = $(TEXT).tex ../intro/pro.tex ../intro/pro.gp
SRC2 = anam.tex driver.tex genomes.tex intro.tex ../intro/pro.ps markers.tex primers.tex

date = $(shell git log | grep Date | head -n 1 | sed -r 's/Date: +[A-Z][a-z]+ ([A-Z][a-z]+) ([0-9]+) [^ ]+ ([0-9]+) .+/\2_\1_\3/')
version = $(shell git describe)

all: $(TEXT).pdf
$(TEXT).pdf: $(TEXT).tex $(SRC1) $(SRC2)
	echo $(date) | tr '_' ' ' > date.txt
	echo $(version) | tr '-' ' ' | awk '{printf "%s", $$1; if ($$2) printf "-%s", $$2; printf "\n"}' > version.txt
	latex $(TEXT).tex
	bibtex $(TEXT)
	latex $(TEXT).tex
	latex $(TEXT).tex
	dvips $(TEXT) -o -q
	ps2pdf -dALLOWPSTRANSPARENCY $(TEXT).ps
publish: $(TEXT).pdf
	if [ -d /mnt/c/Users/haubold/ownCloud\ -\ haubold@evolbio.mpg.de@owncloud.gwdg.de/docs/ ]; then \
		cp $(TEXT).pdf /mnt/c/Users/haubold/ownCloud\ -\ haubold@evolbio.mpg.de@owncloud.gwdg.de/docs/; \
	fi
%.tex: ../*/%.org $(TEXT).tex
	bash ../scripts/org2nw $< | noweave -n -x > $@
%.tex: ../pro/*/%.org #$(TEXT).txt
	bash ../scripts/org2nw $< | noweave -n -x > $@
../intro/pro.ps: ../intro/pro.gp ../intro/counts.dat
	cd ../intro; gnuplot pro.gp
clean:
	rm -f $(TEXT).pdf $(TEXT).ps $(TEXT).dvi $(TEXT).aux $(TEXT).bbl  $(TEXT).blg  $(TEXT).dvi  $(TEXT).log $(SRC2) version.txt date.txt
