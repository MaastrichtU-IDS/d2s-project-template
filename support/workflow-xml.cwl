#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

label: Data2Services CWL workflow to convert XML files, Vincent Emonet <vincent.emonet@gmail.com> 


inputs: 
  
  working_directory: string 
  dataset: string

  tmp_graph_uri: string

  upload_method: string
  sparql_triplestore_url: string
  sparql_triplestore_repository: string

  sparql_queries_path: string
  sparql_endpoint: string
  sparql_username: string
  sparql_password: string
  sparql_output_graph_uri: string
  sparql_service_url: string

outputs:
  
  xml2rdf_file_output:
    type: File
    outputSource: step1/xml2rdf_file_output
  nquads_file_output:
    type: File
    outputSource: step1/nquads_file_output
  rdf_upload_logs:
    type: File
    outputSource: step2/rdf_upload_logs
  execute_sparql_logs:
    type: File
    outputSource: step3/execute_sparql_logs

steps:

  step1:
    run: cwl-steps/run-xml2rdf.cwl
    in:
      working_directory: working_directory
      dataset: dataset
      tmp_graph_uri: tmp_graph_uri
    out: [xml2rdf_file_output,nquads_file_output]

  step2:
    run: cwl-steps/rdf-upload.cwl
    in:
      working_directory: working_directory
      dataset: dataset
      nquads_file: step1/nquads_file_output
      upload_method: upload_method
      sparql_triplestore_url: sparql_triplestore_url
      sparql_triplestore_repository: sparql_triplestore_repository
    out: [rdf_upload_logs]

  step3:
    run: cwl-steps/execute-sparql-mapping.cwl
    in:
      working_directory: working_directory
      dataset: dataset
      sparql_queries_path: sparql_queries_path
      sparql_endpoint: sparql_endpoint
      sparql_username: sparql_username
      sparql_password: sparql_password
      sparql_input_graph_uri: tmp_graph_uri
      sparql_output_graph_uri: sparql_output_graph_uri
      sparql_service_url: sparql_service_url
      graphdb_file: step2/rdf_upload_logs
    out: [execute_sparql_logs]
