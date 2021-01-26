#!/bin/bash

## Download sample TSV files from GitHub (OMOP CDM mappings, about 15M)
wget -N ftp://ftp.ebi.ac.uk/pub/databases/genenames/hgnc/tsv/hgnc_complete_set.txt

# Convert TSV to CSV for RML Mapper
sed -e 's/"//g' -e 's/\t/","/g' -e 's/^/"/' -e 's/$/"/' -e 's/\r//' hgnc_complete_set.txt > hgnc.csv

##Example to run quick python scripts:

# pip install pandas
# python3 <<HEREDOC
# import pandas as pd
# csv_table=pd.read_table('hgnc_complete_set.tsv',sep='\t')
# csv_table.applymap
# s = pd.Series(csv_table)
# s.str.strip()
# csv_table.to_csv('hgnc_complete_set.csv',index=False)
# HEREDOC
