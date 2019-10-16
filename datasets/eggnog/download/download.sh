#!/bin/bash

### EggNOG

# http://eggnogdb.embl.de/#/app/downloads

wget -N https://raw.githubusercontent.com/MaastrichtU-IDS/d2s-transform-template/master/datasets/eggnog/download/NOG.annotations.tsv.gz

wget -N https://raw.githubusercontent.com/MaastrichtU-IDS/d2s-transform-template/master/datasets/eggnog/download/NOG.members.tsv.gz

find . -name "*.gz" -exec gzip -d  {} +

# Add columns name
sed -i '1s/^/TaxonomicLevel\tGroupName\tProteinCount\tSpeciesCount\tCOGFunctionalCategory\tProteinIDs\n/' NOG.members.tsv
sed -i '1s/^/TaxonomicLevel\tGroupName\tProteinCount\tSpeciesCount\tCOGFunctionalCategory\tConsensusFunctionalDescription\n/' NOG.annotations.tsv
