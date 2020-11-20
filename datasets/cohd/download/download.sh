#!/bin/bash

## Download sample COHD files from GitHub (about 15M)

# wget -N https://raw.githubusercontent.com/MaastrichtU-IDS/d2s-scripts-repository/master/resources/cohd-sample/concepts.tsv
# wget -N https://raw.githubusercontent.com/MaastrichtU-IDS/d2s-scripts-repository/master/resources/cohd-sample/paired_concept_counts_associations.tsv
# wget -N https://raw.githubusercontent.com/MaastrichtU-IDS/d2s-scripts-repository/master/resources/cohd-sample/dataset.tsv
# wget -N https://raw.githubusercontent.com/MaastrichtU-IDS/d2s-scripts-repository/master/resources/cohd-sample/domain_concept_counts.tsv
# wget -N https://raw.githubusercontent.com/MaastrichtU-IDS/d2s-scripts-repository/master/resources/cohd-sample/domain_pair_concept_counts.tsv
# wget -N https://raw.githubusercontent.com/MaastrichtU-IDS/d2s-scripts-repository/master/resources/cohd-sample/patient_count.tsv
# wget -N https://raw.githubusercontent.com/MaastrichtU-IDS/d2s-scripts-repository/master/resources/cohd-sample/single_concept_counts.tsv

## Download full COHD data (about 7G compressed)
wget -N https://filedn.com/ll1efYfBhLaV67ONaCyMlKh/cohd-v2.tar.gz


# UNTAR recursively all files in current dir
tar -xzvf *.tar.gz

## RENAME EXTENSION (e.g.: txt in tsv)
# rename s/\.txt/.tsv/ *.txt

# Convert 27G file from TSV to CSV for RML Streamer
sed -e 's/"/\\"/g' -e 's/\t/","/g' -e 's/^/"/' -e 's/$/"/'  -e 's/\r//' paired_concept_counts_associations.txt > paired_concept_counts_associations.csv
# sed -e 's/"/\\"/g' -e 's/\t/","/g' -e 's/^/"/' -e 's/$/"/'  -e 's/\r//' concepts.txt > concepts.csv
# sed -e 's/"/\\"/g' -e 's/\t/","/g' -e 's/^/"/' -e 's/$/"/'  -e 's/\r//' dataset.txt > dataset.csv
# sed -e 's/"/\\"/g' -e 's/\t/","/g' -e 's/^/"/' -e 's/$/"/'  -e 's/\r//' domain_concept_counts.txt > domain_concept_counts.csv
# sed -e 's/"/\\"/g' -e 's/\t/","/g' -e 's/^/"/' -e 's/$/"/'  -e 's/\r//' domain_pair_concept_counts.txt > domain_pair_concept_counts.csv
# sed -e 's/"/\\"/g' -e 's/\t/","/g' -e 's/^/"/' -e 's/$/"/'  -e 's/\r//' patient_count.txt > patient_count.csv
# sed -e 's/"/\\"/g' -e 's/\t/","/g' -e 's/^/"/' -e 's/$/"/'  -e 's/\r//' single_concept_counts.txt > single_concept_counts.csv
# rm paired_concept_counts_associations.tsv

# Make sure right permissions are set properly
# chmod 777 *