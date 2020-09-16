#!/bin/bash

## Download sample TSV files from GitHub (OMOP CDM mappings, about 15M)
# wget -N https://raw.githubusercontent.com/MaastrichtU-IDS/d2s-scripts-repository/master/resources/cohd-sample/concepts.tsv


# UNTAR recursively all .tar.gz files in current dir
# find . -name "*.tar.gz" -exec tar -xzvf {} \;

# UNZIP files
# unzip -o \*.zip

## RENAME EXTENSION (e.g.: txt in tsv)
# rename s/\.txt/.tsv/ *.txt

# Convert TSV to CSV for RMLStreamer
# sed -e 's/"/\\"/g' -e 's/\t/","/g' -e 's/^/"/' -e 's/$/"/'  -e 's/\r//' concepts.tsv > concepts.csv
