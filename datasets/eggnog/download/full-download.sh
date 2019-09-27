#!/bin/bash

### EggNOG

# http://eggnogdb.embl.de/#/app/downloads

wget -N http://eggnogdb.embl.de/download/latest/data/NOG/NOG.members.tsv.gz

wget -N http://eggnogdb.embl.de/download/latest/data/NOG/NOG.annotations.tsv.gz

#wget -N -a download.log http://eggnogdb.embl.de/download/latest/data/NOG/NOG.trees.tsv.gz


# Only FASTA sequences (.fa or .hmm files)
#wget -N -a download.log http://eggnogdb.embl.de/download/eggnog_4.5/data/NOG/NOG.trimmed_algs.tar.gz
#wget -N -a download.log http://eggnogdb.embl.de/download/eggnog_4.5/data/NOG/NOG.raw_algs.tar.gz
#wget -N -a download.log http://eggnogdb.embl.de/download/eggnog_4.5/data/NOG/NOG.hmm.tar.gz

find . -name "*.gz" -exec gzip -d  {} +

# Add columns name
sed -i '1s/^/TaxonomicLevel\tGroupName\tProteinCount\tSpeciesCount\tCOGFunctionalCategory\tProteinIDs\n/' NOG.members.tsv
sed -i '1s/^/TaxonomicLevel\tGroupName\tProteinCount\tSpeciesCount\tCOGFunctionalCategory\tConsensusFunctionalDescription\n/' NOG.annotations.tsv
