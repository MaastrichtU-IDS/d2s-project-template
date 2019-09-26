#!/bin/bash

# Stitch: http://stitch.embl.de/cgi/download.pl

# Chemical-chemical links
wget -N https://github.com/MaastrichtU-IDS/d2s-download/raw/master/datasets/stitch-sample/chemical_chemical.links.v5.0.tsv.gz


# Protein-chemical links. Taking only for human specie at the moment to make it lighter (too big otherwise)
wget -N https://github.com/MaastrichtU-IDS/d2s-download/raw/master/datasets/stitch-sample/9606.protein_chemical.links.detailed.v5.0.tsv.gz


find . -name "*.gz" -exec gzip -d  {} +