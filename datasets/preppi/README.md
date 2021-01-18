## Convert preppi with the RML mapper

Check the DSRI:

* VSCode: https://vscode-d2s-rmlmapper-test-vincent.app.dsri.unimaas.nl/
* JupyterLab: https://jupyterlab-d2s-rmlmapper-test-vincent.app.dsri.unimaas.nl/

```bash
cd d2s-project-template/datasets/preppi
```

### Use RMLmapper locally

Download required files:

```bash
wget -O map-preppi.rml.ttl https://raw.githubusercontent.com/MaastrichtU-IDS/d2s-project-template/master/datasets/preppi/mapping/map-preppi.rml.ttl
wget -O download.sh https://raw.githubusercontent.com/MaastrichtU-IDS/d2s-project-template/master/datasets/preppi/download/download.sh
chmod +x download.sh
wget https://github.com/RMLio/rmlmapper-java/releases/download/v4.9.0/rmlmapper.jar
```

Download the preppi file and convert it to CSV (36MB to download):

```bash
./download.sh
```

Run the RMLmapper:

```bash
nohup java -Xmx20g -jar rmlmapper.jar -m mapping/map-preppi.rml.ttl -o preppi.nt &
```

> Took about 2h30min on the DSRI and produces a 16G `.nt` file

Check the RMLmapper running:

```bash
ps aux | grep rmlmapper
```

### Import RDF data to node2

Compress the data:

```bash
nohup gzip -k preppi.nt &
```

SSH connect to node2, http_proxy var need to be changed temporary to access DSRI

```bash
export http_proxy=""
export https_proxy=""

# Copy with oc tool:
oc login
oc cp flink-jobmanager-7459cc58f7-cjcqf:/notebooks/d2s-project-template/datasets/preppi/preppi.nt.gz /data/graphdb/import/umids-download &!

# Check (16G total):
ls -alh /data/graphdb/import/umids-download
cp /data/graphdb/import/umids-download/openshift-rmlstreamer-preppi-associations.nt.gz /data/d2s-project-trek/workspace/dumps/rdf/preppi/
gzip -d preppi.nt.gz
```

Reactivate the proxy (`EXPORT http_proxy`)

> You can now import the file in GraphDB!

### GitHub Actions workflow

We run the workflow to generate BioLink RDF for concepts and datasets using GitHub Actions:

* See the workflow file: https://github.com/MaastrichtU-IDS/d2s-project-template/blob/master/.github/workflows/rml-map-preppi-concepts.yml

* And the workflow runs: https://github.com/MaastrichtU-IDS/d2s-project-template/actions?query=workflow%3A%22preppi+Concepts+to+RDF%22

This produces a ???M RDF file that can be downloaded from GitHub Actions web UI.

We then unzip this file and load it to https://graphdb.dumontierlab.com in `preppi-dev` repository, in the graph `https://w3id.org/d2s/graph/preppi`

### Rerun the preprocessing

Run preprocessing to convert Concepts types to BioLink types in the CSV before running RML:

```bash
python3 preprocessing-preppi.py
```

> This will generate a `concepts_curated.csv` file (already committed on GitHub, only rerun if changes made)

## Use RMLStreamer

Large file, require to use the RMLStreamer on the DSRI Apache Flink cluster.

Go to the Flink manager pod and the persistent volume: 

```bash
oc login
oc rsh flink-jobmanager-7459cc58f7-5hqjb
mkdir /mnt/preppi
cd /mnt/preppi
```

### Download required files

```bash
wget -O preppi-associations.rml.ttl https://raw.githubusercontent.com/MaastrichtU-IDS/d2s-project-template/master/datasets/preppi/mapping/preppi-associations.rml.ttl
wget -O download.sh https://raw.githubusercontent.com/MaastrichtU-IDS/d2s-project-template/master/datasets/preppi/download/download.sh
chmod +x download.sh
```

> Or copy them from local:
>
> ```bash
> oc cp download/download.sh flink-jobmanager-7459cc58f7-5hqjb:/mnt/preppi
> oc cp mapping/preppi-associations.rml.ttl flink-jobmanager-7459cc58f7-5hqjb:/mnt/preppi
> ```

Download the preppi file and convert it to CSV (take some time, a 36MB to download):

```bash
./download.sh
```

> Wait for the download to finish, check for `paired_concept_counts_associations` size with 
>
> ```bash
> ls -al /mnt/preppi/paired_concept_counts_associations*
> ```

Download `RMLStreamer.jar`:

```bash
wget -O /mnt/RMLStreamer.jar https://github.com/RMLio/RMLStreamer/releases/download/v2.0.0/RMLStreamer-2.0.0.jar
```

### Run the RMLStreamer

Clean the files:

```bash
rm -rf /mnt/preppi/openshift-rmlstreamer-preppi-associations.nt
```

Re-run with parallelism (using 164 threads):

```bash
nohup /opt/flink/bin/flink run -p 128 -c io.rml.framework.Main /mnt/RMLStreamer.jar toFile -m /mnt/preppi/preppi-associations.rml.ttl -o /mnt/preppi/openshift-rmlstreamer-preppi-associations.nt --job-name "[d2s] RMLStreamer preppi-associations.rml.ttl" &
```

Check if the conversion is running well:

```bash
oc rsh flink-jobmanager-7459cc58f7-5hqjb
tail /mnt/preppi/openshift-rmlstreamer-preppi-associations.nt
ls -alh /mnt/preppi/openshift-rmlstreamer-preppi-associations.nt
```

### Merge and compress

The ntriples files produced by RMLStreamer in parallel:

```bash
cd /mnt/preppi/openshift-rmlstreamer-preppi-associations.nt
nohup cat * >> openshift-rmlstreamer-preppi-associations.nt &

ls -alh /mnt/preppi/openshift-rmlstreamer-preppi-associations.nt/openshift-rmlstreamer-preppi-associations.nt

# Zip the merged output file:
nohup gzip openshift-rmlstreamer-preppi-associations.nt &
```

### Copy to Node2

SSH connect to node2, http_proxy var need to be changed temporary to access DSRI

```bash
export http_proxy=""
export https_proxy=""

# Copy with oc tool:
oc login
oc cp flink-jobmanager-7459cc58f7-cjcqf:/mnt/preppi/openshift-rmlstreamer-preppi-associations.nt/openshift-rmlstreamer-preppi-associations.nt.gz /data/graphdb/import/umids-download &!

# Check (16G total):
ls -alh /data/graphdb/import/umids-download
cp /data/graphdb/import/umids-download/openshift-rmlstreamer-preppi-associations.nt.gz /data/d2s-project-trek/workspace/dumps/rdf/preppi/
gzip -d openshift-rmlstreamer-preppi-associations.nt.gz
```

Reactivate the proxy (`EXPORT http_proxy`)

### Preload in GraphDB

Check the generated preppi file on node2 at:

```bash
cd /data/d2s-project-trek/workspace/dumps/rdf/preppi
```

Replace wrong triples:

```bash
sed -i 's/"-inf"^^<http:\/\/www.w3.org\/2001\/XMLSchema#double>/"-inf"/g' openshift-rmlstreamer-preppi-associations.nt
```

Start preload:

```bash
cd /data/deploy-ids-services/graphdb/preload-preppi
docker-compose up -d
```

The preppi repository will be created in `/data/graphdb-preload/data`, copy it to the main GraphDB:

```bash
mv /data/graphdb-preload/data/repositories/preppi /data/graphdb/data/repositories
```