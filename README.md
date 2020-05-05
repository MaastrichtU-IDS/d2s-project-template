## Define CWL workflows for RDF conversion

Click on the **Use this template** button to **create a new repository used by the [d2s Command Line Interface](https://pypi.org/project/d2s/) tool**. 

See **[d2s.semanticscience.org](https://d2s.semanticscience.org/)** for detailed documentation to run CWL workflows to transform structured data to a target RDF knowledge graph and deploy services.

## Requirements

* [Docker](https://docs.docker.com/install/): see the [d2s Docker installation documentation](https://d2s.semanticscience.org/docs/d2s-installation#install-docker) for quick install on various systems.

- `pip` install the [d2s client](https://pypi.org/project/d2s/) and [cwlref-runner](https://github.com/common-workflow-language/cwltool#install) (run workflows of Docker containers) withon Python 3.6+

  ```bash
  sudo apt install d2s cwlref-runner
  ```

## Create  a project

Follow the prompt instructions to create a project in the provided folder:

```bash
d2s init project-folder-name
```

> See the [d2s.semanticscience.org](https://d2s.semanticscience.org/docs/d2s-services) for the complete documentation.

## Edit this template

You might want to edit or modify this template: 

```bash
git clone --recursive https://github.com/MaastrichtU-IDS/d2s-project-template.git
```

## Update submodules

You might want to update the `d2s-core` submodule to get the latest updates for the docker deployments definitions:

```shell
./update_submodules.sh
```

## About

We use the [Common Workflow Language](https://www.commonwl.org/) to describe workflows to transform heterogeneous structured data (CSV, TSV, RDB, XML, JSON) to a target RDF data model ([BioLink](https://biolink.github.io/biolink-model/docs/) in those examples). 

The user can transform the input data as RDF using various solutions:

* RML mappings
* CWL workflows executing [SPARQL queries](https://github.com/MaastrichtU-IDS/d2s-project-template/blob/master/datasets/cohd/mapping/1-concepts.rq) to transform the generic RDF generated depending on the input data structure ([AutoR2RML](https://github.com/MaastrichtU-IDS/AutoR2RML), [xml2rdf](https://github.com/MaastrichtU-IDS/xml2rdf)) to the target model of his choice. See [documentation to run CWL workflows](https://d2s.semanticscience.org/docs/d2s-run)
* [BioThings Studio](https://d2s.semanticscience.org/docs/d2s-biothings) (web UI and API)
* DOCKET multiomics provider (Python notebooks and Nextflow)