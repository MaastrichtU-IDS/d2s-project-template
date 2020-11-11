import csv

preprocess_files = [{'name': 'domain_pair_concept_counts', 'col': [1,2]},
                { 'name': 'domain_concept_counts', 'col': [1] },
                { 'name': 'concepts', 'col': [2] } ]

for file in preprocess_files:
    # Set the right BioLink types in col2 domain_id
    with open('download/' + file['name'] + '.csv', 'r') as input_file, open('download/' + file['name'] + '_curated.csv','w',newline='') as output_file:
        reader = csv.reader(input_file, delimiter=',')
        writer = csv.writer(output_file, delimiter=',')

        for row in reader:
            for col in file['col']:
                row[col] = row[col].replace('Condition','Disease')
                # bl:DiseaseOrPhenotypicFeature ?
                row[col] = row[col].replace('Observation','ActivityAndBehavior') # Not sure
                row[col] = row[col].replace('Measurement','QuantityValue') # Not sure (has_numeric_value, has_unit)
                row[col] = row[col].replace('Procedure','Procedure')
                row[col] = row[col].replace('Device','Device')
                row[col] = row[col].replace('Gender','PopulationOfIndividualOrganisms') # bl:BiologicalSex is an Attribute
                row[col] = row[col].replace('Race','PopulationOfIndividualOrganisms')
                row[col] = row[col].replace('Ethnicity','PopulationOfIndividualOrganisms')
                # TODO: add bl:in_taxon human?
                row[col] = row[col].replace('Relationship','Phenomenon')

            writer.writerow(row)