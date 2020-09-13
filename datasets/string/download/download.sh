#!/bin/bash

## Download sample TSV files from GitHub (OMOP CDM mappings, about 15M)
wget -N https://stringdb-static.org/download/protein.actions.v11.0.txt.gz


# UNTAR recursively all .tar.gz files in current dir
find . -name "*.tar.gz" -exec tar -xzvf {} \;

## RENAME EXTENSION (e.g.: txt in tsv)
rename s/\.txt/.tsv/ *.txt

# Convert TSV to CSV for RMLStreamer
# sed -e 's/"/\\"/g' -e 's/\t/","/g' -e 's/^/"/' -e 's/$/"/'  -e 's/\r//' concepts.tsv > concepts.csv

# Make sure right permissions are set properly
chmod 777 *