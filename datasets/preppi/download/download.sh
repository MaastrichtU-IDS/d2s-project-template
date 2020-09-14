#!/bin/bash

## Download sample TSV files from GitHub (OMOP CDM mappings, about 15M)
wget -O preppi.tsv.tar.gz https://honiglab.c2b2.columbia.edu/PrePPI/ref/preppi_final600.txt.tar.gz

tar -xzvf preppi.tsv.tar.gz preppi.tsv

# Convert TSV to CSV for RMLStreamer
sed -e 's/"/\\"/g' -e 's/\t/","/g' -e 's/^/"/' -e 's/$/"/'  -e 's/\r//' preppi.tsv > preppi.csv

# Make sure right permissions are set properly
chmod 777 *