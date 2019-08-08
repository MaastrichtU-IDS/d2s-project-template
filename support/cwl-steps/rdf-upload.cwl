#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

label: Data2Services tool Upload RDF, Ammar Ammar <ammar257ammar@gmail.com> 


baseCommand: [docker, run]

arguments: ["--rm","--link","graphdb:graphdb", "-v" , "$(inputs.working_directory):/data","-v", "$(runtime.outdir):/tmp", "-v", "$(inputs.nquads_file.path):/tmp/$(inputs.nquads_file.basename)", "rdf-upload", "-if", "/tmp/$(inputs.nquads_file.basename)"]

inputs:
  
  working_directory:
    type: string
  dataset:
    type: string
  upload_method:
    type: string?
    default: HTTP
    inputBinding:
      position: 1
      prefix: -m
  nquads_file:
    type: File
  sparql_triplestore_url:
    type: string
    inputBinding:
      position: 2
      prefix: -url
  sparql_triplestore_repository:
    type: string
    inputBinding:
      position: 3
      prefix: -rep

stdout: rdf-upload.txt

outputs:
  rdf_upload_logs:
    type: stdout
