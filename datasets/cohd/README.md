## Convert COHD concepts and datasets

Run preprocessing to convert Concepts types to BioLink types in the CSV before running RML:

```bash
python3 preprocessing-cohd.py
```

> This will generate a `concepts_curated.csv` file (already commited on GitHub, only rerun if changes made)

Run the workflow using GitHub Actions: https://github.com/MaastrichtU-IDS/d2s-project-template/actions?query=workflow%3A%22COHD+Concepts+to+RDF%22

## Convert COHD associations

Large file, require to use the RMLStreamer on the DSRI, checkout the jupyter notebook for more details