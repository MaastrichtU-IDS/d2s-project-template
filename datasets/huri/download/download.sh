#!/bin/bash

## Download HuRI TSV file
wget -O huri.tsv http://www.interactome-atlas.org/data/HuRI.tsv

# Convert TSV to CSV for RMLStreamer
sed -e 's/"/\\"/g' -e 's/\t/","/g' -e 's/^/"/' -e 's/$/"/'  -e 's/\r//' huri.tsv > huri.csv
