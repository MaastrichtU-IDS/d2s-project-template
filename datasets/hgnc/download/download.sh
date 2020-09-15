#!/bin/bash

## Download sample TSV files from GitHub (OMOP CDM mappings, about 15M)
# wget -N ftp://ftp.ebi.ac.uk/pub/databases/genenames/hgnc/tsv/hgnc_complete_set.txt

# ## RENAME EXTENSION (e.g.: txt in tsv)
# rename s/\.txt/.tsv/ *.txt


pip install pandas

python3 <<HEREDOC
import pandas as pd
csv_table=pd.read_table('hgnc_complete_set.tsv',sep='\t')
csv_table.applymap
s = pd.Series(csv_table)
s.str.strip()
csv_table.to_csv('hgnc_complete_set.csv',index=False)
HEREDOC

# Use TSV in RML
#sources:
# access: source_1.tsv
# referenceFormulation: csv
# delimiter: \t

# Convert TSV to CSV for RMLStreamer
sed -e 's/"/\\"/g' -e 's/\t/","/g' -e 's/^/"/' -e 's/$/"/'  -e 's/\r//' hgnc_complete_set.tsv > hgnc_complete_set.csv

# Make sure right permissions are set properly
# chmod 777 *