#!/bin/bash
docker-compose -f d2s-cwl-workflows/docker-compose.yaml down
rm -rf /data/d2s-workspace/virtuoso
docker-compose -f d2s-cwl-workflows/docker-compose.yaml up -d --build --force-recreate virtuoso drill
sleep 2

echo "Asking password to sudo to change ownership of workspace (chown)"
sudo chown -R ${USER}:${USER} /data/d2s-workspace
cp d2s-cwl-workflows/support/virtuoso/load.sh /data/d2s-workspace/virtuoso
