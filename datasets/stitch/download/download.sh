#!/bin/bash

# Stitch: http://stitch.embl.de/cgi/download.pl

# Chemical-chemical links
wget -N http://stitch.embl.de/download/chemical_chemical.links.v5.0.tsv.gz


# Protein-chemical links. Taking only for human specie at the moment to make it lighter (too big otherwise)
# wget -N http://stitch.embl.de/download/protein_chemical.links.detailed.v5.0.tsv.gz
# 32G

# Only Human, 100M:
http://stitch.embl.de/download/protein_chemical.links.detailed.v5.0/9606.protein_chemical.links.detailed.v5.0.tsv.gz


find . -name "*.gz" -exec gzip -d  {} +