#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

label: Data2Services CWL workflow to convert CSV/TSV files with statements split, Vincent Emonet <vincent.emonet@gmail.com> 


inputs: 
  
  working_directory: string 
  dataset: string

  input_data_jdbc: string

  tmp_base_uri: string
  tmp_graph_uri: string

  upload_method: string
  sparql_triplestore_url: string
  sparql_triplestore_repository: string

  split_property: string
  split_class: string
  split_delimiter: string
  split_quote: string

  sparql_queries_path: string
  sparql_username: string
  sparql_password: string
  sparql_output_graph_uri: string
  sparql_service_url: string

outputs:
  
  r2rml_trig_file_output:
    type: File
    outputSource: step1/r2rml_trig_file_output
  r2rml_config_file_output:
    type: File
    outputSource: step2/r2rml_config_file_output
  nquads_file_output:
    type: File
    outputSource: step3/nquads_file_output
  rdf_upload_logs:
    type: File
    outputSource: step4/rdf_upload_logs
  execute_split_logs:
    type: File
    outputSource: step5/execute_split_logs
  execute_sparql_logs:
    type: File
    outputSource: step6/execute_sparql_logs

steps:

  step1:
    run: cwl-steps/autor2rml.cwl
    in:
      working_directory: working_directory
      dataset: dataset
      input_data_jdbc: input_data_jdbc
      tmp_base_uri: tmp_base_uri
      tmp_graph_uri: tmp_graph_uri
    out: [r2rml_trig_file_output]

  step2:
    run: cwl-steps/generate-r2rml-config.cwl
    in:
      dataset: dataset
      input_data_jdbc: input_data_jdbc
      r2rml_trig_file: step1/r2rml_trig_file_output
    out: [r2rml_config_file_output]

  step3:
    run: cwl-steps/run-r2rml.cwl
    in:
      working_directory: working_directory
      dataset: dataset
      r2rml_trig_file: step1/r2rml_trig_file_output
      r2rml_config_file: step2/r2rml_config_file_output
    out: [nquads_file_output]


  step4:
    run: cwl-steps/rdf-upload.cwl
    in:
      working_directory: working_directory
      dataset: dataset
      nquads_file: step3/nquads_file_output
      upload_method: upload_method
      sparql_triplestore_url: sparql_triplestore_url
      sparql_triplestore_repository: sparql_triplestore_repository
    out: [rdf_upload_logs]

  step5:
    run: cwl-steps/run-split.cwl
    in:
      working_directory: working_directory
      dataset: dataset
      sparql_queries_path: sparql_queries_path
      sparql_triplestore_url: sparql_triplestore_url
      sparql_triplestore_repository: sparql_triplestore_repository
      sparql_username: sparql_username
      sparql_password: sparql_password
      split_delimiter: split_delimiter
      split_quote: split_quote
      split_class: split_class
      split_property: split_property
      graphdb_file: step4/rdf_upload_logs
    out: [execute_split_logs]

  step6:
    run: cwl-steps/execute-sparql-mapping.cwl
    in:
      working_directory: working_directory
      dataset: dataset
      sparql_queries_path: sparql_queries_path
      sparql_triplestore_url: sparql_triplestore_url
      sparql_triplestore_repository: sparql_triplestore_repository
      sparql_username: sparql_username
      sparql_password: sparql_password
      sparql_input_graph_uri: tmp_graph_uri
      sparql_service_url: sparql_service_url
      sparql_output_graph_uri: sparql_output_graph_uri
      graphdb_file: step5/execute_split_logs
    out: [execute_sparql_logs]
