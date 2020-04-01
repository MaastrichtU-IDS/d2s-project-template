#!/bin/bash

GRAPHDB_TRIPLESTORE="https://graphdb.dumontierlab.com"
GRAPHDB_REPOSITORY="monarch-initiative"

GRAPHDB_USERNAME="import_user"
GRAPHDB_PASSWORD="password"

IMPORT_DIR="/data/graphdb-import"
GRAPHDB_WORKDIR="emonet/monarch"

mkdir -p $IMPORT_DIR/$GRAPHDB_WORKDIR
cd $IMPORT_DIR/$GRAPHDB_WORKDIR

# Download simple HTML page and name it as index.html
wget -O index.html https://archive.monarchinitiative.org/latest/rdf/

# Extract URLs from the HTML document to an array. 
array=( $(cat index.html | sed -r -n 's/.*href="(.*?(\.nt|\.ttl))".*/\1/p') )
for var in "${array[@]}"
do
  # Download each file
  wget -N https://archive.monarchinitiative.org/latest/rdf/${var}

  # Import to GraphDB
  curl -X POST -u $GRAPHDB_USERNAME:$GRAPHDB_PASSWORD --header 'Content-Type: application/json' --header 'Accept: application/json' -d "{
    \"fileNames\": [
      \"$GRAPHDB_WORKDIR/${var}\"
    ],
    \"importSettings\": {
        \"context\": \"https://w3id.org/d2s/dipper/graph/${var}\"
      }
  }" "$GRAPHDB_TRIPLESTORE/rest/data/import/server/$GRAPHDB_REPOSITORY"
done
