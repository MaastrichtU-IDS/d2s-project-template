# data2services-transform-biolink

The [Common Workflow Language](https://www.commonwl.org/) is used to describe workflows to transform heterogeneous structured data (CSV, TSV, RDB, XML, JSON) to the [BioLink](https://biolink.github.io/biolink-model/docs/) RDF data model. The user defines [SPARQL queries](https://github.com/MaastrichtU-IDS/data2services-transform-biolink/blob/master/mapping/pharmgkb/insert-pharmgkb.rq) to transform the generic RDF generated depending on the input data structure (AutoR2RML, xml2rdf) to the target BioLink model.

* Install [cwltool](https://github.com/common-workflow-language/cwltool#install) to get cwl-runner.

* Those workflows use Data2Service modules, install the one you need from [data2services-pipeline](https://github.com/MaastrichtU-IDS/data2services-pipeline) using [Docker](https://docs.docker.com/install/).

## Start services

[Apache Drill](https://github.com/amalic/apache-drill) and [GraphDB](https://github.com/MaastrichtU-IDS/graphdb/) services must be running before executing CWL workflows.

```shell
# Apache Drill with shared volume with this repository. Here in located in /data
docker run -dit --rm -v /data/data2services-transform-biolink:/data:ro -p 8047:8047 -p 31010:31010 --name drill apache-drill

# GraphDB shared on /data
docker run -d --rm --name graphdb -p 7200:7200 -v /data/graphdb:/opt/graphdb/home -v /data/graphdb-import:/root/graphdb-import graphdb
```

## Run with CWL

### CSV AutoR2RML

```shell
cwl-runner support/cwl/workflow-csv.cwl support/cwl/transform-job-stitch.yml

# With defined output directory
cwl-runner --outdir output/stitch support/cwl/workflow-csv.cwl support/cwl/transform-job-stitch.yml
```

### CSV AutoR2RML Split

```shell
cwl-runner --outdir output/eggnog support/cwl/workflow-csv-split.cwl support/cwl/transform-job-eggnog.yml
```

### XML

```shell
cwl-runner --outdir output/drugbank support/cwl/workflow-xml.cwl support/cwl/transform-job-drugbank.yml
```