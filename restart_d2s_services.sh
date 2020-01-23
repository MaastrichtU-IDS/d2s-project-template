#!/bin/bash

# Stop services and delete virtuoso directory
docker-compose -f d2s-cwl-workflows/docker-compose.yaml down
rm -rf /data/d2s-workspace/virtuoso

# Restart all services
docker-compose -f d2s-cwl-workflows/docker-compose.yaml up -d --build --force-recreate virtuoso drill graphdb browse-local-virtuoso browse-local-graphdb
sleep 2

# Change permissions to current user and group id (tested for Ubuntu and MacOS)
echo "Asking password to sudo to change ownership of workspace (chown)"
sudo chown -R ${UID}:${GID} /data/d2s-workspace

# Copy the load.sh script used for Virtuoso bulk load
cp d2s-cwl-workflows/support/virtuoso/load.sh /data/d2s-workspace/virtuoso
