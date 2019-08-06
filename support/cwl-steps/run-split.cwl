#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool


label: Data2Services tool split RDF statements, Ammar Ammar <vincent.emonet@gmail.com> 


baseCommand: [docker, run]

arguments: ["--rm","--link","graphdb:graphdb", "-v" , "$(inputs.working_directory):/data","-v", "$(runtime.outdir):/tmp", "-v", "$(inputs.graphdb_file.path):/tmp/$(inputs.graphdb_file.basename)", 
"vemonet/data2services-sparql-operations", "-op", "split", "--split-delete"]

inputs:

  working_directory:
    type: string
  dataset:
    type: string
  sparql_endpoint:
    type: string
    inputBinding:
      position: 1
      prefix: -ep
  sparql_repository:
    type: string
    inputBinding:
      position: 2
      prefix: -uep
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
  split_property:
    type: string
    inputBinding:
      position: 5
      prefix: --split-property
  split_class:
    type: string
    inputBinding:
      position: 6
      prefix: --split-class
  split_delimiter:
    type: string
    inputBinding:
      position: 7
      prefix: --split-delimiter
  split_quote:
    type: string
    inputBinding:
      position: 8
      prefix: --split-quote
  graphdb_file:
    type: File

stdout: execute-split-logs.txt

outputs:
  execute_split_logs:
    type: stdout
