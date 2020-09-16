#!/bin/bash

## Download preppi_final600.txt (30M compressed)
wget -N https://honiglab.c2b2.columbia.edu/PrePPI/ref/preppi_final600.txt.tar.gz

# Unzip
tar -xzvf *.tar.gz

# Rename .txt to .tsv
# Convert commas to | for ddbs column and PubMed publications CURIEs to URIs
sed -e 's/,/|/g' -e 's/pubmed:/https:\/\/identifiers.org\/pubmed:/g' preppi_final600.txt > preppi.tsv

# Convert TSV to CSV for RMLStreamer
sed -e 's/"/\\"/g' -e 's/\t/","/g' -e 's/^/"/' -e 's/$/"/'  -e 's/\r//' preppi.tsv > preppi.csv

# prot1	prot2	str_score	protpep_score	str_max_score	red_score	ort_score	phy_score	coexp_score	go_score	total_score	dbs	pubs	exp_score	final_score
# Q13131	P14625	18.59	6.44772	18.59	4.2492	0.6153	2.416	9.4687	10.8	12008.4				12008.4
# P06400	Q96N96	1.8315	14.3222	14.3222	4.2492	0	2.416	2.1077	10.8	3346.93				3346.93
# Q7Z6V5	Q8NCE0	4.5712	0	4.5712	0	0	1.5978	9.4687	24.11	1667.4				1667.4
# P09661	Q13573	0	0	0	0	3.1392	0	1

# "prot1","prot2","str_score","protpep_score","str_max_score","red_score","ort_score","phy_score","coexp_score","go_score","total_score","dbs","pubs","exp_score","final_score"
# "Q13131","P14625","18.59","6.44772","18.59","4.2492","0.6153","2.416","9.4687","10.8","12008.4","","","","12008.4"
# "Q9Y2X7","Q9NPJ6","0","2.59","2.59","1.0145","0","2.416","1.5818","0","10.0415","BGDB|","pubmed:25281560|pubmed:25281575","957.82","9617.95"
# "Q9Y2X7","Q9NPJ6","0","2.59","2.59","1.0145","0","2.416","1.5818","0","10.0415","BGDB|","pubmed:25281560","957.82","9617.95"