#!/bin/bash

### See also: Smart-API http://smart-api.info/ui/9fbeaeabd19b334fa0f1932aa111bf35

### Download SQL database
# https://figshare.com/collections/Columbia_Open_Health_Data_a_database_of_EHR_prevalence_and_co-occurrence_of_conditions_drugs_and_procedures/4151252


### Get TSV:

# Concepts (description and IDs). No column name
wget -O concepts.txt https://ndownloader.figshare.com/files/12272921
# No label
# 444258  Abrasion and/or friction burn of neck with infection  Condition SNOMED  Clinical Finding  84278006
# 1319973 24 HR Nisoldipine 17 MG Extended Release Oral Tablet [Sular]  Drug  RxNorm  Quant Branded Drug  763521
# 2001333 Endoscopic excision or destruction of lesion or tissue of lung  Procedure ICD9Proc  4-dig billing code  32.28


# Lifetime_data_set_single_concept_count. No column name
wget -O concept_counts.txt https://ndownloader.figshare.com/files/12272927
# No label
# 8507  2360177 0.4399391140104321
# 8515  32019 0.0059683703770946105
# 8516  208438  0.03885303053377202


# Lifetime_data_set_paired_concept_counts. No columns name
wget -O concept_pair_counts.txt https://ndownloader.figshare.com/files/12272933
# No label
# 8507	8515	12162	0.0022670077306044738
# 8507	8516	88950	0.016580359943863504
# 8507	8522	28285	0.005272349421159969


# Lifetime_dataset_paired-concept_deviations
wget -O Lifetime_dataset_paired-concept_deviations.txt https://ndownloader.figshare.com/files/13154816
# concept_id1	concept_id2	mean	std
# 8507	8515	0.00208027970515285	0.001785257319865198
# 8507	8516	0.015739536039206053	0.004958179506247589


# 5-year_dataset_single_concept_deviations
wget -O 5-year_dataset_single_concept_deviations.txt https://ndownloader.figshare.com/files/13154819
# concept_id	mean	std
# 8507	0.40678146395861414	0.00525764236441662
# 8515	0.015845844258100292	0.0013752132393454904


# Lifetime_dataset_single_concept_deviations
wget -O Lifetime_dataset_single_concept_deviations.txt https://ndownloader.figshare.com/files/13154756
# concept_id  mean  std
# 8507  0.40722269250781007 0.012688023319080767


# 5-year_dataset_paired-concept_deviations
wget -O 5-year_dataset_paired-concept_deviations.txt https://ndownloader.figshare.com/files/13154753
# concept_id1	concept_id2	mean	std
# 8507	8515	0.0054840204848070695	0.0006678481797530802
# 8507	8516	0.023880370720591754	0.0019017405539031244


# 5-year_data_set_single_concept_count. No column name
wget -O 5-year_data_set_single_concept_count.txt https://ndownloader.figshare.com/files/12272930
# No label
# 8507	753863	0.4210511323809742
# 8515	24020	0.013415764137238464


# 5-year_data_set_paired_concept_counts
wget -O 5-year_data_set_paired_concept_counts.txt https://ndownloader.figshare.com/files/12272924
# No label
# 8507	8515	8907	0.004974779815586303
# 8507	8516	43498	0.024294708927626925
# 8507	8522	148	0.00008266166079564082


## RENAME EXTENSION (e.g.: txt in tsv)
#rename s/\.txt/.tsv/ *.txt

## ADD COLUMNS NAME
# TSV
#sed -i '1s/^/column1\tcolumn2\tcolumn3\n/' *.tsv