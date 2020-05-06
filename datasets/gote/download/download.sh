#!/bin/bash

BASE_URI="http://tatonettilab.org/resources/GOTE/source_code/results/"

########## Download files

## HTML EXTRACT URL to an array
# Download simple HTML page and name it as index.html
wget -O index.html -a download.log $BASE_URI
# Extract URL fron the HTML document to an array. Feel free to change the regex
array=( $(cat index.html | sed -r -n 's/.*href="([^"]*?\.txt)".*/\1/p') )
for var in "${array[@]}"
do
  # Download each URL
  wget -N -a download.log $BASE_URI${var}
done


## RENAME EXTENSION (e.g.: txt in tsv)
rename s/\.txt/.tsv/ *.txt


## ADD COLUMNS NAME
sed -i '1s/^/TissueName\tGpcrUniprotId\tPathwayNames\tPathwayPValue\tZscoreHighGpcrExpression\tZscoreSpecificExpression\n/' *.tsv

# Convert TSV to CSV for RMLStreamer
# sed -e 's/"/\\"/g' -e 's/\t/","/g' -e 's/^/"/' -e 's/$/"/'  -e 's/\r//' concepts.tsv > concepts.csv

# Make sure right permissions are set properly
chmod 777 *