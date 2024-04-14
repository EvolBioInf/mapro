SH = anam

all: $(SH).sh findMarker.awk

$(SH).sh: $(SH).org
	bash ../scripts/org2nw $(SH).org | notangle -R$(SH).sh > $(SH).sh
findMarker.awk: $(SH).org
	bash ../scripts/org2nw $(SH).org | notangle -RfindMarker.awk > findMarker.awk
clean:
	rm -rf $(SH).sh findMarker.awk
