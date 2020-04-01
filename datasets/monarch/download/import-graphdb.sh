#!/bin/bash

GRAPHDB_TRIPLESTORE="http://localhost:7200"
GRAPHDB_REPOSITORY="monarch-initiative"
WORKDIR="/data/graphdb-import/emonet/monarch"
# WORKDIR="mkdir -p input/dipper"

mkdir -p $WORKDIR
cd $WORKDIR

# Download simple HTML page and name it as index.html
wget -O index.html https://archive.monarchinitiative.org/latest/rdf/

# Extract URLs from the HTML document to an array. 
array=( $(cat index.html | sed -r -n 's/.*href="(.*?(\.nt|\.ttl))".*/\1/p') )
for var in "${array[@]}"
do
  # Download each file
  wget -N https://archive.monarchinitiative.org/latest/rdf/${var}

  # Import to GraphDB
  curl -X POST -u admin:root --header 'Content-Type: application/json' --header 'Accept: application/json' -d "{
    'fileNames': [
      '$WORKDIR/${var}'
    ],
    'importSettings': {
        'context': 'https://w3id.org/d2s/dipper/graph/${var}'
      }
  }" "$GRAPHDB_TRIPLESTORE/rest/data/import/server/$GRAPHDB_REPOSITORY"
done
