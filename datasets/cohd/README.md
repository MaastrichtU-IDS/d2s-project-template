## COHD transformation

Download files to convert

```bash
docker run -it -v $PATH_TO_GIT_DIR/d2s-transform-template:/srv \
  -v /data/d2s-workspace:/data \
  umids/d2s-bash-exec:latest \
  /srv/datasets/cohd/download/download.sh input/cohd
```

> Change `$PATH_TO_GIT_DIR` to your git `d2s-transform-template` repository.

> Downloaded files in `/data/d2s-workspace/input/cohd`

Start services (drill, virtuoso, graphdb) and run workflow to convert CSV

```bash
# Start services
./restart_virtuoso.sh

docker-compose -f d2s-cwl-workflows/docker-compose.yaml up \
  -d --build --force-recreate graphdb

# Run workflow
cwl-runner --custom-net d2s-cwl-workflows_network \
  --outdir /data/d2s-workspace/output \
  --tmp-outdir-prefix=/data/d2s-workspace/output/tmp-outdir/ \
  --tmpdir-prefix=/data/d2s-workspace/output/tmp-outdir/tmp- \
  d2s-cwl-workflows/workflows/workflow-csv.cwl \
  datasets/cohd/config-transform-csv-cohd.yml
```