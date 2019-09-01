# CWL workflows for RDF BioLink conversion

The [Common Workflow Language](https://www.commonwl.org/) is used to describe workflows to transform heterogeneous structured data (CSV, TSV, RDB, XML, JSON) to the [BioLink](https://biolink.github.io/biolink-model/docs/) RDF data model. The user defines [SPARQL queries](https://github.com/MaastrichtU-IDS/data2services-transform-biolink/blob/master/mapping/pharmgkb/insert-pharmgkb.rq) to transform the generic RDF generated depending on the input data structure (AutoR2RML, xml2rdf) to the target BioLink model.

* Clone the repository with its submodules

```shell
git clone --recursive https://github.com/MaastrichtU-IDS/data2services-transform-biolink.git
```

* Install [Docker](https://docs.docker.com/install/) to run the modules.
* Install [cwltool](https://github.com/common-workflow-language/cwltool#install) to get cwl-runner to run workflows of Docker modules.

```shell
apt-get install cwltool
```

* Those workflows use Data2Services modules, see the [data2services-pipeline](https://github.com/MaastrichtU-IDS/data2services-pipeline) project.
* It is recommended to build the Docker images before running workflows, as the `docker pull` might crash when done through `cwl-runner`.

---

## Start services

[Apache Drill](https://github.com/amalic/apache-drill) and [GraphDB](https://github.com/MaastrichtU-IDS/graphdb/) services must be running before executing CWL workflows.

GraphDB needs to be built locally, for this:

* Download GraphDB as a stand-alone server free version (zip): https://ontotext.com/products/graphdb/.
* Put the downloaded `.zip` file in the GraphDB repository (cloned from [GitHub](https://github.com/MaastrichtU-IDS/graphdb/)).
* Run `docker build -t graphdb --build-arg version=CHANGE_ME .` in the GraphDB repository.

```shell
# Start Apache Drill sharing volume with this repository.
# Here shared locally at /data/data2services-transform-biolink
docker run -dit --rm -v /data/data2services-transform-biolink:/data:ro -p 8047:8047 -p 31010:31010 --name drill vemonet/apache-drill

# GraphDB needs to be downloaded manually and built. 
# Here shared locally at /data/graphdb and /data/graphdb-import
docker build -t graphdb --build-arg version=8.11.0 .
docker run -d --rm --name graphdb -p 7200:7200 -v /data/graphdb:/opt/graphdb/home -v /data/graphdb-import:/root/graphdb-import graphdb
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
  * The `.yml` [configuration file](https://github.com/MaastrichtU-IDS/data2services-transform-biolink/blob/master/support/cwl/config/config-transform-xml-drugbank.yml) with all parameters required to run the workflow
    * e.g. `support/config/config-transform-xml-drugbank.yml`

* 3 types of workflows can be run depending on the input data:
  * [Convert XML to RDF](https://github.com/MaastrichtU-IDS/data2services-transform-biolink#convert-xml-with-xml2rdf)
  * [Convert CSV to RDF](https://github.com/MaastrichtU-IDS/data2services-transform-biolink#convert-csvtsv-with-autor2rml)
  * [Convert CSV to RDF and split a property](https://github.com/MaastrichtU-IDS/data2services-transform-biolink#convert-csvtsv-with-autor2rml-and-split-a-property)

### Convert XML with [xml2rdf](https://github.com/MaastrichtU-IDS/xml2rdf)

```shell
cwl-runner --outdir output/drugbank data2services-cwl-workflows/workflows/workflow-xml.cwl support/config/config-transform-xml-drugbank.yml
```

See [config file](https://github.com/MaastrichtU-IDS/data2services-transform-biolink/blob/master/support/cwl/config/config-transform-xml-drugbank.yml):

```yaml
working_directory: /data/data2services-transform-biolink
dataset: drugbank-sample

# d2s-download params
download_username: vincent.emonet@maastrichtuniversity.nl
download_password: PASSWORD

# tmp RDF4J server SPARQL endpoint to load generic RDF
sparql_tmp_triplestore_url: http://graphdb:7200
sparql_tmp_triplestore_repository: "test"
sparql_tmp_service_url: "repository:test"
sparql_tmp_triplestore_username: import_user
sparql_tmp_triplestore_password: PASSWORD

sparql_tmp_graph_uri: "https://w3id.org/data2services/graph/xml2rdf/drugbank"

# Final RDF4J server SPARQL endpoint to load the BioLink RDF
sparql_final_triplestore_url: http://graphdb:7200
sparql_final_triplestore_repository: "test"
sparql_final_triplestore_username: import_user
sparql_final_triplestore_password: PASSWORD

sparql_final_graph_uri: https://w3id.org/data2services/graph/biolink/drugbank

sparql_transform_queries_path: /data/mapping/drugbank/transform/1
# Could be https://github.com/MaastrichtU-IDS/data2services-transform-biolink/tree/master/mapping/drugbank/transform/1
sparql_insert_metadata_path: /data/mapping/drugbank/metadata/1
```

### Convert CSV/TSV with [AutoR2RML](https://github.com/amalic/autor2rml)

```shell
cwl-runner --outdir output/stitch data2services-cwl-workflows/workflows/workflow-csv.cwl support/config/config-transform-csv-stitch.yml
```

See [config file](https://github.com/MaastrichtU-IDS/data2services-transform-biolink/blob/master/support/cwl/config/config-transform-csv-stitch.yml):

```yaml
working_directory: /data/data2services-transform-biolink
dataset: stitch

# R2RML params
input_data_jdbc: "jdbc:drill:drillbit=drill:31010"

# tmp RDF4J server SPARQL endpoint to load generic RDF
sparql_tmp_triplestore_url: http://graphdb:7200
sparql_tmp_triplestore_repository: "test"
sparql_tmp_service_url: "repository:test"
sparql_tmp_triplestore_username: import_user
sparql_tmp_triplestore_password: PASSWORD

sparql_tmp_graph_uri: "https://w3id.org/data2services/graph/autor2rml/stitch"

# Final RDF4J server SPARQL endpoint to load the BioLink RDF
sparql_final_triplestore_url: http://graphdb:7200
sparql_final_triplestore_repository: "test"
sparql_final_triplestore_username: import_user
sparql_final_triplestore_password: PASSWORD

sparql_transform_queries_path: /data/mapping/stitch/transform/1
sparql_insert_metadata_path: /data/mapping/stitch/metadata/1
```

### Convert CSV/TSV with [AutoR2RML](https://github.com/amalic/autor2rml) and split a property

```shell
cwl-runner --outdir output/eggnog data2services-cwl-workflows/workflows/workflow-csv-split.cwl support/config/config-transform-split-eggnog.yml
```

See [config file](https://github.com/MaastrichtU-IDS/data2services-transform-biolink/blob/master/support/cwl/config/config-transform-split-eggnog.yml):

```yaml
working_directory: /data/data2services-transform-biolink
dataset: eggnog

# R2RML params
input_data_jdbc: "jdbc:drill:drillbit=drill:31010"
#autor2rml_column_header: "test1,test2,test3,test5"

# Split params
split_property: https://w3id.org/data2services/model/Pmids
split_class: https://w3id.org/data2services/data/input/pharmgkb/relationships_extract101.tsv
split_delimiter: ";"
split_quote: '"'

# tmp RDF4J server SPARQL endpoint to load generic RDF
sparql_tmp_triplestore_url: http://graphdb:7200
sparql_tmp_triplestore_repository: "test"
sparql_tmp_service_url: "repository:test"
sparql_tmp_triplestore_username: import_user
sparql_tmp_triplestore_password: PASSWORD

sparql_tmp_graph_uri: "https://w3id.org/data2services/graph/autor2rml/pharmgkb"

# Final RDF4J server SPARQL endpoint to load the BioLink RDF
sparql_final_triplestore_url: http://graphdb:7200
sparql_final_triplestore_repository: "test"
sparql_final_triplestore_username: import_user
sparql_final_triplestore_password: PASSWORD

sparql_final_graph_uri: https://w3id.org/data2services/graph/biolink/pharmgkb

sparql_transform_queries_path: /data/mapping/eggnog/transform/1
sparql_insert_metadata_path: /data/mapping/eggnog/metadata/1
```

### Generate mappings for AutoR2RML

When you don't have set the mappings for R2RML: generates the generic RDF and template SPARQL mapping files, and load the generic RDF.

```shell
cwl-runner --outdir output/hpo_annotations data2services-cwl-workflows/workflows/workflow-csv-generate_mapping.cwl support/config/config-transform-csv-hpo_annotations.yml
```

Same [config file](https://github.com/MaastrichtU-IDS/data2services-transform-biolink/blob/master/support/cwl/config/config-transform-csv-stitch.yml) as the regular CSV workflow.

### Run in the background

And write all terminal output to `nohup.out`.

```shell
nohup cwl-runner --outdir output/drugbank data2services-cwl-workflows/workflows/workflow-xml.cwl support/config/config-transform-xml-drugbank.yml &
```



---

# Argo workflows

See [data2services-argo-workflows](https://github.com/MaastrichtU-IDS/data2services-argo-workflows) to run workflows with Argo.