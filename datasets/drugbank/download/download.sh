#!/bin/bash

# Use sample hosted on GitHub, faster for testing
wget -N https://github.com/MaastrichtU-IDS/data2services-download/raw/master/datasets/drugbank-sample/drugbank.zip

# Download full DrugBank dataset providing user login and password
#curl -Lfv -o drugbank.zip -u $USERNAME:$PASSWORD https://www.drugbank.ca/releases/5-1-5/downloads/all-full-database

# Example:
#curl -Lfv -o drugbank.zip -u vincent.emonet@maastrichtuniversity.nl:my_password https://www.drugbank.ca/releases/5-1-5/downloads/all-full-database

unzip *.zip -d .

# Unzip all files in subdir with name of the zip file
# find . -name "*.zip" | while read filename; do unzip -o -d "`dirname "$filename"`/${filename%.*}" "$filename"; done;
echo "content of dir"
ls
#ls drugbank
#mv drugbank/* .
# rmdir drugbank