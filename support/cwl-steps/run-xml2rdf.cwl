#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

label: Data2Services CWL workflow, Ammar Ammar <ammar257ammar@gmail.com> 

baseCommand: [docker, run]

arguments: [ "--rm", "-v" , "$(inputs.working_directory):/data", "-v", "$(runtime.outdir):/tmp", "xml2rdf", "-i", "/data/input/$(inputs.dataset)/*.xml", "-o", "/tmp/$(inputs.rq_file_name)"]

requirements:
  EnvVarRequirement:
    envDef:
      HOME: $(inputs.working_directory)

inputs:
  
  working_directory:
    type: string
  dataset:
    type: string
  rq_file_name:
    type: string
  tmp_graph_uri:
    type: string
    inputBinding:
      position: 3
      prefix: -g

stdout: xml2rdf_file_structure.txt

outputs:
  xml2rdf_file_output:
    type: stdout
  rq_file_output:
    type: File
    outputBinding:
      glob: $(inputs.rq_file_name)