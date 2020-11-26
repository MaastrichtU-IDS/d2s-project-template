## Convert COHD concepts and datasets

We run the workflow to generate BioLink RDF for concepts and datasets using GitHub Actions:

* See the workflow file: https://github.com/MaastrichtU-IDS/d2s-project-template/blob/master/.github/workflows/rml-map-cohd-concepts.yml

* And the workflow runs: https://github.com/MaastrichtU-IDS/d2s-project-template/actions?query=workflow%3A%22COHD+Concepts+to+RDF%22

This produces a 200M RDF file that can be downloaded from GitHub Actions web UI.

We then unzip this file and load it to https://graphdb.dumontierlab.com in `cohd-dev` repository, in the graph `https://w3id.org/d2s/graph/cohd`

### Rerun the preprocessing

Run preprocessing to convert Concepts types to BioLink types in the CSV before running RML:

```bash
python3 preprocessing-cohd.py
```

> This will generate a `concepts_curated.csv` file (already committed on GitHub, only rerun if changes made)

## Convert COHD associations

Large file, require to use the RMLStreamer on the DSRI Apache Flink cluster.

Go to the Flink manager pod and the persistent volume: 

```bash
oc login
oc rsh flink-jobmanager-7459cc58f7-5hqjb
mkdir /mnt/cohd
cd /mnt/cohd
```

### Download required files

```bash
wget -O cohd-associations.rml.ttl https://raw.githubusercontent.com/MaastrichtU-IDS/d2s-project-template/master/datasets/cohd/mapping/cohd-associations.rml.ttl
wget -O download.sh https://raw.githubusercontent.com/MaastrichtU-IDS/d2s-project-template/master/datasets/cohd/download/download.sh
chmod +x download.sh
```

> Or copy them from local:
>
> ```bash
> oc cp download/download.sh flink-jobmanager-7459cc58f7-5hqjb:/mnt/cohd
> oc cp mapping/cohd-associations.rml.ttl flink-jobmanager-7459cc58f7-5hqjb:/mnt/cohd
> ```

Download the COHD file (take some time, a few GB to download):

```bash
nohup ./download.sh &
```

> Wait for the download to finish, check for `paired_concept_counts_associations` size with 
>
> ```bash
> ls -al /mnt/cohd/paired_concept_counts_associations*
> ```

Download `RMLStreamer.jar`:

```bash
wget -O /mnt/RMLStreamer.jar https://github.com/RMLio/RMLStreamer/releases/download/v2.0.0/RMLStreamer-2.0.0.jar
```

### Run the RMLStreamer

Clean the files:

```bash
rm -rf /mnt/cohd/openshift-rmlstreamer-cohd-associations.nt
```

Re-run with parallelism (using 164 threads):

```bash
nohup /opt/flink/bin/flink run -p 128 -c io.rml.framework.Main /mnt/RMLStreamer.jar toFile -m /mnt/cohd/cohd-associations.rml.ttl -o /mnt/cohd/openshift-rmlstreamer-cohd-associations.nt --job-name "[d2s] RMLStreamer cohd-associations.rml.ttl" &
```

Check if the conversion is running well:

```bash
oc rsh flink-jobmanager-7459cc58f7-5hqjb
tail /mnt/cohd/openshift-rmlstreamer-cohd-associations.nt
ls -alh /mnt/cohd/openshift-rmlstreamer-cohd-associations.nt
```

### Merge and compress

The ntriples files produced by RMLStreamer in parallel:

```bash
cd /mnt/cohd/openshift-rmlstreamer-cohd-associations.nt
nohup cat * >> openshift-rmlstreamer-cohd-associations.nt &

ls -alh /mnt/cohd/openshift-rmlstreamer-cohd-associations.nt/openshift-rmlstreamer-cohd-associations.nt

# Zip the merged output file:
nohup gzip openshift-rmlstreamer-cohd-associations.nt &
```

### Copy to Node2

SSH connect to node2, http_proxy var need to be changed temporary to access DSRI

```bash
export http_proxy=""
export https_proxy=""

# Copy with oc tool:
oc login
oc cp flink-jobmanager-7459cc58f7-cjcqf:/mnt/cohd/openshift-rmlstreamer-cohd-associations.nt/openshift-rmlstreamer-cohd-associations.nt.gz /data/graphdb/import/umids-download &!

# Check (19G total):
ls -alh /data/graphdb/import/umids-download
cp /data/graphdb/import/umids-download/openshift-rmlstreamer-cohd-associations.nt.gz /data/d2s-project-trek/workspace/dumps/rdf/cohd/
gzip -d openshift-rmlstreamer-cohd-associations.nt.gz
```

Reactivate the proxy (`EXPORT http_proxy`)

### Preload in GraphDB

Check the generated COHD file on node2 at:

```bash
cd /data/d2s-project-trek/workspace/dumps/rdf/cohd
```

Replace wrong triples:

```bash
sed -i 's/"-inf"^^<http:\/\/www.w3.org\/2001\/XMLSchema#double>/"-inf"/g' openshift-rmlstreamer-cohd-associations.nt
```

Start preload:

```bash
cd /data/deploy-ids-services/graphdb/preload-cohd
docker-compose up -d
```

The COHD repository will be created in `/data/graphdb-preload/data`, copy it to the main GraphDB:

```bash
mv /data/graphdb-preload/data/repositories/cohd /data/graphdb/data/repositories
```