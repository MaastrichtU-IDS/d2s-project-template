#!/bin/bash

USERNAME="vincent.emonet@maastrichtuniversity.nl"
PASSWORD="password"

# Download full DrugBank dataset providing user login and password
curl -Lfv -o drugbank.zip -u $USERNAME:$PASSWORD https://www.drugbank.ca/releases/5-1-6/downloads/all-full-database

# Use DrugBank XML sample hosted on GitHub, faster for testing
# wget -N https://github.com/MaastrichtU-IDS/d2s-scripts-repository/raw/master/resources/drugbank-sample/drugbank.zip
# See the uncompressed file here: 
# https://github.com/MaastrichtU-IDS/d2s-scripts-repository/blob/master/resources/drugbank-sample/drugbank.xml

unzip *.zip -d .

mv "full database.xml" "drugbank_database.xml"

chmod 777 *

# Unzip all files in subdir with name of the zip file
# find . -name "*.zip" | while read filename; do unzip -o -d "`dirname "$filename"`/${filename%.*}" "$filename"; done;
echo "content of dir"
ls
#ls drugbank
#mv drugbank/* .
# rmdir drugbank
