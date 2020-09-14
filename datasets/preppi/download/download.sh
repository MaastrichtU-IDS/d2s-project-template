#!/bin/bash

## Download preppi_final600.txt
wget -N https://honiglab.c2b2.columbia.edu/PrePPI/ref/preppi_final600.txt.tar.gz

tar -xzvf *.tar.gz

rename s/\.txt/.tsv/ *.txt

# Convert TSV to CSV for RMLStreamer
sed -e 's/"/\\"/g' -e 's/\t/","/g' -e 's/^/"/' -e 's/$/"/'  -e 's/\r//' preppi_final600.tsv > preppi.csv

# Make sure right permissions are set properly
chmod 777 *