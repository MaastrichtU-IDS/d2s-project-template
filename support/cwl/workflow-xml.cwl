#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

label: Data2Services CWL workflow to convert XML files, Vincent Emonet <vincent.emonet@gmail.com> 


inputs: 
  
  working_directory: string 
  dataset: string

  sparql_tmp_graph_uri: string?

  sparql_triplestore_url: string
  sparql_triplestore_repository: string

  sparql_insert_metadata_path: string
  sparql_transform_queries_path: string

  sparql_username: string
  sparql_password: string
  sparql_output_graph_uri: string
  sparql_service_url: string

outputs:
  
  xml2rdf_file_output:
    type: File
    outputSource: step1-xml2rdf/xml2rdf_file_output
  nquads_file_output:
    type: File
    outputSource: step1-xml2rdf/nquads_file_output
  rdf_upload_logs:
    type: File
    outputSource: step2-rdf-upload/rdf_upload_logs
  execute_sparql_metadata_logs:
    type: File
    outputSource: step3-insert-metadata/execute_sparql_query_logs
  execute_sparql_transform_logs:
    type: File
    outputSource: step4-execute-transform-queries/execute_sparql_query_logs
  execute_sparql_hcls_logs:
    type: File
    outputSource: step5-compute-hcls-stats/execute_sparql_query_logs

steps:

  step1-xml2rdf:
    run: cwl-steps/run-xml2rdf.cwl
    in:
      working_directory: working_directory
      dataset: dataset
      sparql_tmp_graph_uri: sparql_tmp_graph_uri
    out: [xml2rdf_file_output,nquads_file_output]

  step2-rdf-upload:
    run: cwl-steps/rdf-upload.cwl
    in:
      working_directory: working_directory
      dataset: dataset
      nquads_file: step1-xml2rdf/nquads_file_output
      sparql_triplestore_url: sparql_triplestore_url
      sparql_triplestore_repository: sparql_triplestore_repository
    out: [rdf_upload_logs]

  step3-insert-metadata:
    run: cwl-steps/execute-sparql-mapping.cwl
    in:
      working_directory: working_directory
      dataset: dataset
      sparql_queries_path: sparql_insert_metadata_path
      sparql_triplestore_url: sparql_triplestore_url
      sparql_triplestore_repository: sparql_triplestore_repository
      sparql_username: sparql_username
      sparql_password: sparql_password
      sparql_input_graph_uri: sparql_tmp_graph_uri
      sparql_output_graph_uri: sparql_output_graph_uri
      sparql_service_url: sparql_service_url
      graphdb_file: step2-rdf-upload/rdf_upload_logs
    out: [execute_sparql_query_logs]

  step4-execute-transform-queries:
    run: cwl-steps/execute-sparql-mapping.cwl
    in:
      working_directory: working_directory
      dataset: dataset
      sparql_queries_path: sparql_transform_queries_path
      sparql_triplestore_url: sparql_triplestore_url
      sparql_triplestore_repository: sparql_triplestore_repository
      sparql_username: sparql_username
      sparql_password: sparql_password
      sparql_input_graph_uri: sparql_tmp_graph_uri
      sparql_output_graph_uri: sparql_output_graph_uri
      sparql_service_url: sparql_service_url
      graphdb_file: step3-insert-metadata/execute_sparql_query_logs
    out: [execute_sparql_query_logs]

  step5-compute-hcls-stats:
    run: cwl-steps/execute-sparql-mapping.cwl
    in: # No sparql_queries_path, HCLS stats is the default
      working_directory: working_directory
      dataset: dataset
      sparql_triplestore_url: sparql_triplestore_url
      sparql_triplestore_repository: sparql_triplestore_repository
      sparql_username: sparql_username
      sparql_password: sparql_password
      sparql_input_graph_uri: sparql_output_graph_uri
      graphdb_file: step4-execute-transform-queries/execute_sparql_query_logs
    out: [execute_sparql_query_logs]
