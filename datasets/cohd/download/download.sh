#!/bin/bash

## Download sample COHD files from GitHub (about 15M)

wget -N https://raw.githubusercontent.com/MaastrichtU-IDS/d2s-scripts-repository/master/resources/cohd-sample/concepts.tsv
wget -N https://raw.githubusercontent.com/MaastrichtU-IDS/d2s-scripts-repository/master/resources/cohd-sample/paired_concept_counts_associations.tsv
wget -N https://raw.githubusercontent.com/MaastrichtU-IDS/d2s-scripts-repository/master/resources/cohd-sample/dataset.tsv
wget -N https://raw.githubusercontent.com/MaastrichtU-IDS/d2s-scripts-repository/master/resources/cohd-sample/domain_concept_counts.tsv
wget -N https://raw.githubusercontent.com/MaastrichtU-IDS/d2s-scripts-repository/master/resources/cohd-sample/domain_pair_concept_counts.tsv
wget -N https://raw.githubusercontent.com/MaastrichtU-IDS/d2s-scripts-repository/master/resources/cohd-sample/patient_count.tsv
wget -N https://raw.githubusercontent.com/MaastrichtU-IDS/d2s-scripts-repository/master/resources/cohd-sample/single_concept_counts.tsv

## Download full COHD data (about 7G compressed)
# wget -N https://filedn.com/ll1efYfBhLaV67ONaCyMlKh/cohd-v2.tar.gz


# UNTAR recursively all files in actual dir
# find . -name "*.tar.gz" -exec tar -xzvf {} \;

## RENAME EXTENSION (e.g.: txt in tsv)
# rename s/\.txt/.tsv/ *.txt

# Convert 27G file from TSV to CSV for RML Streamer
sed -e 's/"/\\"/g' -e 's/\t/","/g' -e 's/^/"/' -e 's/$/"/'  -e 's/\r//' paired_concept_counts_associations.tsv > paired_concept_counts_associations.csv
# rm paired_concept_counts_associations.tsv

# Make sure right permissions are set properly
chmod 777 *