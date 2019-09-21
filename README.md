# CWL workflows for RDF BioLink conversion

The [Common Workflow Language](https://www.commonwl.org/) is used to describe workflows to transform heterogeneous structured data (CSV, TSV, RDB, XML, JSON) to the [BioLink](https://biolink.github.io/biolink-model/docs/) RDF data model. The user defines [SPARQL queries](https://github.com/MaastrichtU-IDS/data2services-transform-biolink/blob/master/mapping/pharmgkb/insert-pharmgkb.rq) to transform the generic RDF generated depending on the input data structure (AutoR2RML, xml2rdf) to the target BioLink model.

---

## Requirements

- Install [Docker](https://docs.docker.com/install/) to run the modules. Checkout the [Wiki](https://github.com/MaastrichtU-IDS/data2services-pipeline/wiki/Docker-documentation) if you have issues with Docker installation.
- Install [cwltool](https://github.com/common-workflow-language/cwltool#install) to get cwl-runner to run workflows of Docker modules.

```shell
apt-get install cwltool
```

- Those workflows use Data2Services modules, see the [data2services-pipeline](https://github.com/MaastrichtU-IDS/data2services-pipeline) project.
- It is recommended to build the Docker images before running workflows, as the `docker pull` might crash when done through `cwl-runner`.

- Following documentation focuses on Linux & MacOS, as no workflow engine supports Windows.
- Windows documentation to run the docker containers can be found [here](https://github.com/MaastrichtU-IDS/data2services-pipeline/wiki/Run-on-Windows).

---

## Clone

Clone the repository with its submodules

```bash
git clone --recursive https://github.com/MaastrichtU-IDS/data2services-transform-biolink.git
```

---

## Start services

[Apache Drill](https://github.com/amalic/apache-drill) and [GraphDB](https://github.com/MaastrichtU-IDS/graphdb/) services must be running before executing CWL workflows.

GraphDB needs to be built locally, for this:

* Download GraphDB as a stand-alone server free version (zip): https://ontotext.com/products/graphdb/.
* Put the downloaded `.zip` file in the GraphDB repository (cloned from [GitHub](https://github.com/MaastrichtU-IDS/graphdb/)).
* Run `docker build -t graphdb --build-arg version=CHANGE_ME .` in the GraphDB repository.

```bash
# Start Apache Drill sharing volume with this repository.
# Here shared locally at /data/data2services-transform-biolink
docker run -dit --rm -v /data/data2services-transform-biolink:/data:ro -p 8047:8047 -p 31010:31010 --name drill vemonet/apache-drill

# GraphDB needs to be downloaded manually and built. 
# Here shared locally at /data/graphdb and /data/graphdb-import
docker build -t graphdb --build-arg version=8.11.0 .
docker run -d --rm --name graphdb -p 7200:7200 -v /data/graphdb:/opt/graphdb/home -v /data/graphdb-import:/root/graphdb-import graphdb
```

Use `docker-compose`:

```bash
docker-compose -f data2services-cwl-workflows/docker-compose/virtuoso.yaml -f data2services-cwl-workflows/docker-compose/drill.yaml -f data2services-cwl-workflows/docker-compose/postgres.yaml up -d --build --force-recreate

docker-compose -f data2services-cwl-workflows/docker-compose/virtuoso.yaml -f data2services-cwl-workflows/docker-compose/drill.yaml up -d --build --force-recreate
```

---

## Run with [CWL](https://www.commonwl.org/)

* Go to the `data2services-transform-biolink` root folder (the root of the cloned repository)
  * e.g. `/data/data2services-transform-biolink` to run the CWL workflows.

* You will need to put the SPARQL mapping queries in `/mappings/$dataset_name` and provide 3 parameters:
  * `--outdir`: the [output directory](https://github.com/MaastrichtU-IDS/data2services-transform-biolink/tree/master/output/stitch) for files outputted by the workflow (except for the downloaded source files that goes automatically to `/input`). 
    * e.g. `output/$dataset_name`.
  * The `.cwl` [workflow file](https://github.com/MaastrichtU-IDS/data2services-transform-biolink/blob/master/support/cwl/workflow-xml.cwl)
    * e.g. `data2services-cwl-workflows/workflows/workflow-xml.cwl`
  * The `.yml` [configuration file](https://github.com/MaastrichtU-IDS/data2services-transform-biolink/blob/master/support/example-config/config-transform-xml-drugbank.yml) with all parameters required to run the workflow
    * e.g. `support/example-config/config-transform-xml-drugbank.yml`

* 3 types of workflows can be run depending on the input data and the tasks executed:

### Convert XML with [xml2rdf](https://github.com/MaastrichtU-IDS/xml2rdf)

```shell
cwl-runner --outdir output/drugbank-sample data2services-cwl-workflows/workflows/workflow-xml.cwl support/example-config/config-transform-xml-drugbank.yml
```

* See [config file](https://github.com/MaastrichtU-IDS/data2services-transform-biolink/blob/master/support/example-config/config-transform-xml-drugbank.yml).

### Convert CSV/TSV with [AutoR2RML](https://github.com/amalic/autor2rml)

```shell
cwl-runner --outdir output/stitch-sample data2services-cwl-workflows/workflows/workflow-csv.cwl support/example-config/config-transform-csv-stitch.yml
```

* See [config file](https://github.com/MaastrichtU-IDS/data2services-transform-biolink/blob/master/support/example-config/config-transform-csv-stitch.yml).

### Convert CSV/TSV with [AutoR2RML](https://github.com/amalic/autor2rml) and split a property

```shell
cwl-runner --outdir output/eggnog-sample data2services-cwl-workflows/workflows/workflow-csv-split.cwl support/example-config/config-transform-split-eggnog.yml
```

* See [config file](https://github.com/MaastrichtU-IDS/data2services-transform-biolink/blob/master/support/example-config/config-transform-split-eggnog.yml).

### Generate mappings for AutoR2RML

When you don't have set the mappings for R2RML: generates the generic RDF and template SPARQL mapping files, and load the generic RDF.

```shell
cwl-runner --outdir output/stitch-sample data2services-cwl-workflows/workflows/workflow-csv-generate_mapping.cwl support/example-config/config-transform-csv-stitch.yml
```

Same [config file](https://github.com/MaastrichtU-IDS/data2services-transform-biolink/blob/master/support/cwl/config/config-transform-csv-stitch.yml) as the regular CSV workflow.

### Run in the background

And write all terminal output to `nohup.out`.

```shell
nohup cwl-runner --outdir output/drugbank-sample data2services-cwl-workflows/workflows/workflow-xml.cwl support/example-config/config-transform-xml-drugbank.yml &
```



---

# Argo workflows

See [data2services-argo-workflows](https://github.com/MaastrichtU-IDS/data2services-argo-workflows) to run workflows with Argo.