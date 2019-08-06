#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

label: Data2Services CWL workflow, Vincent Emonet <vincent.emonet@gmail.com> 


inputs: 
  
  working_directory: string 
  dataset: string

  input_data: string
  output_data: string
  tmp_graph_uri: string

  rq_file_name: string

  upload_method: string
  triplestore_url: string
  triplestore_repository: string

  sparql_queries_path: string
  sparql_endpoint: string
  sparql_username: string
  sparql_password: string
  output_graph_uri: string

outputs:
  
  xml2rdf_file_output:
    type: File
    outputSource: step1/xml2rdf_file_output
  rq_file_output:
    type: File
    outputSource: step1/rq_file_output
  graphdb_file_output:
    type: File
    outputSource: step2/graphdb_file_output

steps:

  step1:
    run: cwl-steps/run-xml2rdf.cwl
    in:
      working_directory: working_directory
      dataset: dataset
      rq_file_name: rq_file_name
      tmp_graph_uri: tmp_graph_uri
    out: [xml2rdf_file_output,rq_file_output]

  step2:
    run: cwl-steps/rdf-upload.cwl
    in:
      working_directory: working_directory
      dataset: dataset
      rq_file: step1/rq_file_output
      upload_method: upload_method
      triplestore_url: triplestore_url
      triplestore_repository: triplestore_repository
    out: [graphdb_file_output]

  step3:
    run: cwl-steps/execute-sparql-mapping.cwl
    in:
      working_directory: working_directory
      dataset: dataset
      sparql_queries_path: sparql_queries_path
      sparql_endpoint: sparql_endpoint
      sparql_username: sparql_username
      sparql_password: sparql_password
      output_graph_uri: output_graph_uri
      graphdb_file: step2/graphdb_file_output
    out: [eow]
