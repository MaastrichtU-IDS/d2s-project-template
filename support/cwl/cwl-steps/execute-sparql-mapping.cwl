#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

label: Data2Services tool to execute SPARQL queries, Ammar Ammar <ammar257ammar@gmail.com> 


baseCommand: [docker, run]

arguments: [ "--rm", "--link","graphdb:graphdb", "-v" , "$(inputs.working_directory):/data", "-v", "$(runtime.outdir):/tmp", 
"-v", "$(inputs.graphdb_file.path):/tmp/$(inputs.graphdb_file.basename)", 
"vemonet/data2services-sparql-operations" ]

inputs:

  working_directory:
    type: string
  dataset:
    type: string
  sparql_queries_path:
    type: string
    inputBinding:
      position: 1
      prefix: -f
  sparql_triplestore_url:
    type: string
    inputBinding:
      position: 2
      prefix: -ep
  sparql_triplestore_repository:
    type: string
    inputBinding:
      position: 3
      prefix: -rep
  sparql_username:
    type: string?
    inputBinding:
      position: 4
      prefix: -un
  sparql_password:
    type: string?
    inputBinding:
      position: 5
      prefix: -pw
  sparql_input_graph_uri:
    type: string?
    inputBinding:
      position: 6
      prefix: --var-inputGraph
  sparql_output_graph_uri:
    type: string?
    inputBinding:
      position: 7
      prefix: --var-outputGraph
  sparql_service_url:
    type: string?
    default: http://localhost:7200/repositories/test
    inputBinding:
      position: 8
      prefix: --var-serviceUrl
  graphdb_file:
    type: File

stdout: execute-sparql-query-logs.txt

outputs:
  execute_sparql_query_logs:
    type: stdout
