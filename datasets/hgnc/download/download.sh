#!/bin/bash

## Download sample TSV files from GitHub (OMOP CDM mappings, about 15M)
wget -N ftp://ftp.ebi.ac.uk/pub/databases/genenames/hgnc/tsv/hgnc_complete_set.txt

## RENAME EXTENSION (e.g.: txt in tsv)
rename s/\.txt/.tsv/ *.txt

# Convert TSV to CSV for RMLStreamer
sed -e 's/"/\\"/g' -e 's/\t/","/g' -e 's/^/"/' -e 's/$/"/'  -e 's/\r//' hgnc_complete_set.tsv > hgnc_complete_set.csv

# Make sure right permissions are set properly
chmod 777 *