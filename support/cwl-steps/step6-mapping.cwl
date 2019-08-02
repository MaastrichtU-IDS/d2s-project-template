#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

label: Data2Services CWL workflow, Ammar Ammar <ammar257ammar@gmail.com> 


baseCommand: [docker, run]

arguments: ["--rm","--link","graphdb:graphdb", "-v" , "$(inputs.abs_path):/data","-v", "$(runtime.outdir):/tmp", "-v", "$(inputs.graphdb_file.path):/tmp/$(inputs.graphdb_file.basename)", 
"vemonet/data2services-sparql-operations"]

inputs:

  abs_path:
    type: string
  dataset:
    type: string
  sparql:
    type: string
    inputBinding:
      position: 1
      prefix: -f
  endpoint:
    type: string
    inputBinding:
      position: 2
      prefix: -ep
  username:
    type: string
    inputBinding:
      position: 3
      prefix: -un
  password:
    type: string
    inputBinding:
      position: 4
      prefix: -pw
  output_graph:
    type: string
    inputBinding:
      position: 5
      prefix: -var
  graphdb_file:
    type: File

outputs:
  eow:
    type: stdout
