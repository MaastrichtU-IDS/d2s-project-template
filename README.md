# data2services-transform-biolink

Services must be running before running the CWL workflows

```shell
# Apache Drill with shared volume with this repository. Here in /data
docker run -dit --rm -p 8047:8047 -p 31010:31010 --name drill \ 
  -v /data/data2services-transform-biolink/:/data:ro \
  apache-drill
  
# GraphDB shared on /data
docker run -d --rm --name graphdb -p 7200:7200 \
  -v /data/graphdb:/opt/graphdb/home \
  -v /data/graphdb-import:/root/graphdb-import \
  graphdb
```

## AutoR2RML

```shell
cwl-runner support/workflow-csv.cwl support/transform-job-stitch.yml

# With defined output directory
cwl-runner --outdir output/stitch support/workflow-csv.cwl support/transform-job-stitch.yml
```

## AutoR2RML Split

```shell
cwl-runner --outdir output/eggnog support/workflow-csv-split.cwl support/transform-job-eggnog.yml
```

## XML

```shell
cwl-runner --outdir output/drugbank support/workflow-xml.cwl support/transform-job-drugbank.yml
```
