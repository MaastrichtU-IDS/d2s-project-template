#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

label: Data2Services CWL workflow, Ammar Ammar <ammar257ammar@gmail.com> 


baseCommand: [docker, run]

arguments: ["--rm","--link","graphdb:graphdb", "-v" , "$(inputs.abs_path):/data","-v", "$(runtime.outdir):/tmp", "-v", "$(inputs.rq_file.path):/tmp/$(inputs.rq_file.basename)", "rdf-upload"]

inputs:
  
  abs_path:
    type: string
  dataset:
    type: string
  method:
    type: string
    inputBinding:
      position: 1
      prefix: -m
  rq_file:
    type: File
  rq:
    type: string
    inputBinding:
      position: 2
      prefix: -if
      valueFrom: /tmp/$(inputs.rq_file.basename)
  url:
    type: string
    inputBinding:
      position: 3
      prefix: -url
  repo:
    type: string
    inputBinding:
      position: 4
      prefix: -rep

stdout: rdf-upload.txt

outputs:
  graphdb_output_file:
    type: stdout
