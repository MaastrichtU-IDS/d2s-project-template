#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

label: Data2Services CWL workflow, Ammar Ammar <ammar257ammar@gmail.com> 


baseCommand: [docker, run]

arguments: ["--rm","--link","graphdb:graphdb", "-v" , "$(inputs.working_directory):/data","-v", "$(runtime.outdir):/tmp", "-v", "$(inputs.rq_file.path):/tmp/$(inputs.rq_file.basename)", "rdf-upload"]

inputs:
  
  working_directory:
    type: string
  dataset:
    type: string
  upload_method:
    type: string
    inputBinding:
      position: 1
      prefix: -m
  rq_file:
    type: File
  param_rq_file:
    type: string
    inputBinding:
      position: 2
      prefix: -if
      valueFrom: /tmp/$(inputs.rq_file.basename)
  triplestore_url:
    type: string
    inputBinding:
      position: 3
      prefix: -url
  triplestore_repository:
    type: string
    inputBinding:
      position: 4
      prefix: -rep

stdout: rdf-upload.txt

outputs:
  graphdb_file_output:
    type: stdout
