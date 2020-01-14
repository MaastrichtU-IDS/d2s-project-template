#!/bin/bash

########## Download files

## SIMPLE DOWNLOAD only if file as changed
wget -N https://github.com/MaastrichtU-IDS/d2s-download/raw/master/datasets/stitch-sample/9606.protein_chemical.links.detailed.v5.0.tsv.gz


## FTP DOWNLOAD recursively all files in ftp that have the given extension
wget -N -r -A gz -nH ftp://ftp.ncbi.nlm.nih.gov/pubchem/


## PROPERLY NAME RECURSIVE DIR created during download
wget -N -r -A ttl.gz -R reject_this -nH --cut-dirs=3 -P compound ftp://ftp.ncbi.nlm.nih.gov/pubchem/RDF/compound/general
# -nH to remove `ftp.ncbi.nlm.nih.gov`
# --cut-dirs=3 to remove `pubchem/RDF/compound`
# -P to store in the compound dir


## HTML EXTRACT URL to an array
# Download simple HTML page and name it as index.html
wget -O index.html http://data.wikipathways.org/current/rdf/
# Extract URLs from the HTML document to an array. Feel free to change the regex
array=( $(cat index.html | sed -r -n 's/.*((http|ftp)[^"]*?(\.zip|\.gz|\.csv|\.tsv|\.tar)).*/\1/p') )
for var in "${array[@]}"
do
  # Download each URL
  wget -N ${var}
done


## Manipulate array
# Remove file finishing by test.ttl from the array
array=( ${array[@]//*test.ttl/} )
# Display array
( IFS=$'\n'; echo "${array[*]}" )


########## Uncompress

# ZIP
# Recursive in subdir
find . -name "*.zip" | while read filename; do unzip -o -d "`dirname "$filename"`/${filename%.*}" "$filename"; done;
# All in same dir
unzip -o \*.zip


#GZIP recusive in subdir
find . -name "*.gz" -exec gzip -d  {} + >


# UNTAR recursively all files in actual dir
find . -name "*.tar.gz" -exec tar -xzvf {} \;
find . -name "*.tgz" -exec tar -xzvf {} \;


# Bz2
find . -name "*.bz2" | while read filename; do bzip2 -f -d "$filename"; done;


########## Prepare files

## RENAME EXTENSION (e.g.: txt in tsv)
rename s/\.txt/.tsv/ *.txt

## REMOVE 4 FIRST LINES
sed -i -e '1,4d' my_file.txt

## ADD COLUMNS NAME
# CSV
sed -i '1s/^/column1,column2,column3\n/' *.csv
# TSV
sed -i '1s/^/column1\tcolumn2\tcolumn3\n/' *.tsv