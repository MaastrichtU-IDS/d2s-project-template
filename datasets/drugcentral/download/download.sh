#!/bin/bash

## Download small TSV 800K, no drug ID, only drug name, uniprot id, gene id, source URL (e.g. chembl)
wget -N http://unmtid-shinyapps.net/download/drug.target.interaction.tsv.gz

# Full SQL dump 947M
# wget -n http://unmtid-shinyapps.net/download/drugcentral.dump.08262018.sql.gz


# UNTAR recursively all .tar.gz files in current dir
find . -name "*.tar.gz" -exec tar -xzvf {} \;

# Convert TSV to CSV for RMLStreamer
sed -e 's/"/\\"/g' -e 's/\t/","/g' -e 's/^/"/' -e 's/$/"/'  -e 's/\r//' drug.target.interaction.tsv > drug.target.interaction.csv

# Make sure right permissions are set properly
chmod 777 *