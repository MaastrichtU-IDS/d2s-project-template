#!/bin/bash

wget -N http://tatonettilab.org/resources/DATE/date_resource.zip

# Unzip
# All in same dir
unzip -o \*.zip

rm date_resource/Drug_target_reactome_pathway_filtered.tsv
# Should contains 2 tsv
# date_resource/Drug_target_reactome_pathway.tsv
# date_resource/Drug_target_reactome_pathway_filtered.tsv