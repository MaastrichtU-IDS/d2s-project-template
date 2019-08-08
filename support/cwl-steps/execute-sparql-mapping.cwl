#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

label: Data2Services tool execute SPARQL queries, Ammar Ammar <ammar257ammar@gmail.com> 


baseCommand: [docker, run]

arguments: ["--rm","--link","graphdb:graphdb", "-v" , "$(inputs.working_directory):/data","-v", "$(runtime.outdir):/tmp", "-v", "$(inputs.graphdb_file.path):/tmp/$(inputs.graphdb_file.basename)", 
"vemonet/data2services-sparql-operations"]

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
  sparql_endpoint:
    type: string
    inputBinding:
      position: 2
      prefix: -ep
  sparql_username:
    type: string
    inputBinding:
      position: 3
      prefix: -un
  sparql_password:
    type: string
    inputBinding:
      position: 4
      prefix: -pw
  sparql_input_graph_uri:
    type: string
    inputBinding:
      position: 5
      prefix: --var-inputGraph
  sparql_output_graph_uri:
    type: string
    inputBinding:
      position: 6
      prefix: --var-outputGraph
  sparql_service_url:
    type: string
    inputBinding:
      position: 7
      prefix: --var-serviceUrl
  graphdb_file:
    type: File

stdout: execute-sparql-logs.txt

outputs:
  execute_sparql_logs:
    type: stdout
