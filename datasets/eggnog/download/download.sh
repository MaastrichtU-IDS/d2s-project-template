#!/bin/bash

### EggNOG

# http://eggnogdb.embl.de/#/app/downloads

wget -N http://eggnogdb.embl.de/download/latest/data/NOG/NOG.members.tsv.gz
wget -N http://eggnogdb.embl.de/download/latest/data/NOG/NOG.annotations.tsv.gz

gzip -d "*.gz"
# Add columns name

sed -i '1s/^/TaxonomicLevel\tGroupName\tProteinCount\tSpeciesCount\tCOGFunctionalCategory\tProteinIDs\n/' NOG.members.tsv
sed -i '1s/^/TaxonomicLevel\tGroupName\tProteinCount\tSpeciesCount\tCOGFunctionalCategory\tConsensusFunctionalDescription\n/' NOG.annotations.tsv


# Convert TSV to CSV for RML
sed -e 's/"/\\"/g' -e 's/\t/","/g' -e 's/^/"/' -e 's/$/"/'  -e 's/\r//' -e 's/,/|/g' NOG.members.tsv > NOG.members.csv
sed -e 's/"/\\"/g' -e 's/\t/","/g' -e 's/^/"/' -e 's/$/"/'  -e 's/\r//' NOG.annotations.tsv > NOG.annotations.csv
