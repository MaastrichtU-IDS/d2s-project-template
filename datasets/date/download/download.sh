#!/bin/bash

wget -N -a download.log http://tatonettilab.org/resources/DATE/date_resource.zip


########## UNCOMPRESS

# ZIP
# All in same dir
unzip -o \*.zip

# Should contains 2 tsv
# date_resource/Drug_target_reactome_pathway.tsv
# date_resource/Drug_target_reactome_pathway_filtered.tsv