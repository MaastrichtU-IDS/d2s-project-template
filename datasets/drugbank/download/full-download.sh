#!/bin/bash

# Download providing user login and password
curl -Lfv -o drugbank.zip -u $USERNAME:$PASSWORD https://www.drugbank.ca/releases/5-1-1/downloads/all-full-database

# Also directly available as RDF here: http://wifo5-03.informatik.uni-mannheim.de/drugbank/

# Unzip all files in subdir with name of the zip file
find . -name "*.zip" | while read filename; do unzip -o -d "`dirname "$filename"`/${filename%.*}" "$filename"; done;
mv drugbank/* .
rmdir drugbank