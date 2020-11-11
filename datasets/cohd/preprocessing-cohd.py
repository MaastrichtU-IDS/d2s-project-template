import csv

# Set the right BioLink types in col2 domain_id
with open('download/concepts.csv', 'r') as input_file, open('download/concepts_curated.csv','w',newline='') as output_file:
   reader = csv.reader(input_file, delimiter=',')
   writer = csv.writer(output_file, delimiter=',')

   for row in reader:

        row[2] = row[2].replace('Condition','Disease')
        # bl:DiseaseOrPhenotypicFeature ?
        row[2] = row[2].replace('Observation','ActivityAndBehavior') # Not sure
        row[2] = row[2].replace('Measurement','QuantityValue') # Not sure (has_numeric_value, has_unit)
        row[2] = row[2].replace('Procedure','Procedure')
        row[2] = row[2].replace('Device','Device')
        row[2] = row[2].replace('Gender','PopulationOfIndividualOrganisms') # bl:BiologicalSex is an Attribute
        row[2] = row[2].replace('Race','PopulationOfIndividualOrganisms')
        row[2] = row[2].replace('Ethnicity','PopulationOfIndividualOrganisms')
        # TODO: add bl:in_taxon human?
        row[2] = row[2].replace('Relationship','Phenomenon')

        writer.writerow(row)