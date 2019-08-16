# CWL workflows for RDF BioLink conversion

The [Common Workflow Language](https://www.commonwl.org/) is used to describe workflows to transform heterogeneous structured data (CSV, TSV, RDB, XML, JSON) to the [BioLink](https://biolink.github.io/biolink-model/docs/) RDF data model. The user defines [SPARQL queries](https://github.com/MaastrichtU-IDS/data2services-transform-biolink/blob/master/mapping/pharmgkb/insert-pharmgkb.rq) to transform the generic RDF generated depending on the input data structure (AutoR2RML, xml2rdf) to the target BioLink model.

* Install [cwltool](https://github.com/common-workflow-language/cwltool#install) to get cwl-runner.

* Those workflows use Data2Service modules, install the one you need from [data2services-pipeline](https://github.com/MaastrichtU-IDS/data2services-pipeline) using [Docker](https://docs.docker.com/install/).

---

## Start services

[Apache Drill](https://github.com/amalic/apache-drill) and [GraphDB](https://github.com/MaastrichtU-IDS/graphdb/) services must be running before executing CWL workflows.

Download GraphDB as a stand-alone server free version (zip): https://ontotext.com/products/graphdb/

```shell
# Apache Drill with shared volume with this repository. Here in located in /data
docker run -dit --rm -v /data/data2services-transform-biolink:/data:ro -p 8047:8047 -p 31010:31010 --name drill vemonet/apache-drill

# GraphDB needs to be downloaded manually and built. Shared on /data
docker build -t graphdb --build-arg version=8.11.0 .
docker run -d --rm --name graphdb -p 7200:7200 -v /data/graphdb:/opt/graphdb/home -v /data/graphdb-import:/root/graphdb-import graphdb
```

---

## Run with [CWL](https://www.commonwl.org/)

* Go to `data2services-transform-biolink` root folder (the root of the cloned repository), e.g. `/data/data2services-transform-biolink` to run the CWL workflows.

* You will need to provide 3 parameters
  * `--outdir`: the output directory for downloaded files (except for downloaded files that go directly to `/input`). Usually `output/$dataset_name`
  * The `.cwl` workflow file, e.g. `support/cwl/workflow-xml.cwl`
  * The `.yml` configuration file with all parameters required to run the workflow, e.g. `support/cwl/config-transform-drugbank.yml`

* 3 types of workflows can be run depending on the input data

### Convert XML with [xml2rdf](https://github.com/MaastrichtU-IDS/xml2rdf)

```shell
cwl-runner --outdir output/drugbank support/cwl/workflow-xml.cwl support/cwl/config-transform-drugbank.yml
```

### Convert CSV/TSV with [AutoR2RML](https://github.com/amalic/autor2rml)

```shell
cwl-runner support/cwl/workflow-csv.cwl support/cwl/config-transform-stitch.yml

# With defined output directory
cwl-runner --outdir output/stitch support/cwl/workflow-csv.cwl support/cconfig-transformjob-stitch.yml
```

### Convert CSV/TSV with [AutoR2RML](https://github.com/amalic/autor2rml) and split a statement

```shell
cwl-runner --outdir output/eggnog support/cwl/workflow-csv-split.cwl support/cwl/config-transform-eggnog.yml
```

