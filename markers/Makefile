SH = markers

all: $(SH).sh

$(SH).sh: $(SH).org
	bash ../scripts/org2nw $(SH).org | notangle -R$(SH).sh > $(SH).sh
clean:
	rm -rf $(SH).sh
