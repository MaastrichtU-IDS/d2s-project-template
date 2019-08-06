#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

label: Data2Services CWL workflow to convert CSV/TSV files with statements split, Vincent Emonet <vincent.emonet@gmail.com> 


inputs: 
  
  working_directory: string 
  dataset: string

  input_data_jdbc: string
  r2rml_trig_file_name: string

  base_uri: string
  tmp_graph_uri: string

  rq_file_name: string
  r2rml_config_content: string

  upload_method: string
  triplestore_url: string
  triplestore_repository: string

  split_property: string
  split_class: string
  split_delimiter: string

  sparql_queries_path: string
  sparql_endpoint: string
  sparql_username: string
  sparql_password: string
  output_graph_uri: string

outputs:
  
  trig_file_output:
    type: File
    outputSource: step1/trig_file_output
  r2rml_config_file_output:
    type: File
    outputSource: step2/r2rml_config_file_output
  rq_file_output:
    type: File
    outputSource: step3/rq_file_output
  graphdb_file_output:
    type: File
    outputSource: step4/graphdb_file_output

steps:

  step1:
    run: cwl-steps/autor2rml.cwl
    in:
      working_directory: working_directory
      dataset: dataset
      input_data_jdbc: input_data_jdbc
      r2rml_trig_file_name: r2rml_trig_file_name
      base_uri: base_uri
      tmp_graph_uri: tmp_graph_uri
    out: [trig_file_output]

  step2:
    run: cwl-steps/generate-r2rml-config.cwl
    in:
      dataset: dataset
      input_data_jdbc: input_data_jdbc
      r2rml_trig_file: step1/trig_file_output
      rq_file_name: rq_file_name
      r2rml_config_content: r2rml_config_content
    out: [r2rml_config_file_output]

  step3:
    run: cwl-steps/run-r2rml.cwl
    in:
      working_directory: working_directory
      dataset: dataset
      rq_file_name: rq_file_name
      r2rml_trig_file: step1/trig_file_output
      r2rml_config_file: step2/r2rml_config_file_output
    out: [rq_file_output]


  step4:
    run: cwl-steps/rdf-upload.cwl
    in:
      working_directory: working_directory
      dataset: dataset
      rq_file: step3/rq_file_output
      upload_method: upload_method
      triplestore_url: triplestore_url
      triplestore_repository: triplestore_repository
    out: [graphdb_file_output]

  step5:
    run: cwl-steps/run-split.cwl
    in:
      working_directory: working_directory
      dataset: dataset
      sparql_queries_path: sparql_queries_path
      sparql_endpoint: triplestore_url
      sparql_repository: triplestore_repository
      sparql_username: sparql_username
      sparql_password: sparql_password
      split_delimiter: split_delimiter
      split_class: split_class
      split_property: split_property
      graphdb_file: step4/graphdb_file_output
    out: [eow]

  step6:
    run: cwl-steps/execute-sparql-mapping.cwl
    in:
      working_directory: working_directory
      dataset: dataset
      sparql_queries_path: sparql_queries_path
      sparql_endpoint: sparql_endpoint
      sparql_username: sparql_username
      sparql_password: sparql_password
      output_graph_uri: output_graph_uri
      graphdb_file: step5/eow
    out: [eow]
