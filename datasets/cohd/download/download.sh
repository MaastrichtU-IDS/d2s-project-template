#!/bin/bash

########## Download files

## SIMPLE DOWNLOAD only if file as changed
wget -N https://filedn.com/ll1efYfBhLaV67ONaCyMlKh/cohd-v2.tar.gz


########## Uncompress


# UNTAR recursively all files in actual dir
find . -name "*.tar.gz" -exec tar -xzvf {} \;


########## Prepare files

## RENAME EXTENSION (e.g.: txt in tsv)
rename s/\.txt/.tsv/ *.txt

## ADD COLUMNS NAME
# TSV
# sed -i '1s/^/column1\tcolumn2\tcolumn3\n/' *.tsv