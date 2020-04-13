#!/bin/bash

## Download fixed turtle from IDS servers
wget -N https://covid-download.137.120.31.102.nip.io/files/ugent-covid-kg.zip

unzip -o \*.zip

# Fix MeSH URIs to use HTTP instead of HTTPS (like official MeSH)
find ugent-covid-kg.ttl -type f -exec sed -i "s/https:\/\/id.nlm.nih.gov\/mesh/http:\/\/id.nlm.nih.gov\/mesh/g" {} +