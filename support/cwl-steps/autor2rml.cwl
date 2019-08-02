#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

label: Data2Services CWL workflow, Ammar Ammar <ammar257ammar@gmail.com> 

baseCommand: [docker, run]

arguments: [ "--rm", "--link","drill:drill", "-v" , "$(inputs.working_directory):/data", "-v", "$(runtime.outdir):/tmp", "autor2rml", "-r"]

requirements:
  EnvVarRequirement:
    envDef:
      HOME: $(inputs.working_directory)

inputs:
  
  working_directory:
    type: string
  dataset:
    type: string
  input_data_jdbc:
    type: string
    inputBinding:
      position: 1
      prefix: -j
  r2rml_trig_file_name:
    type: string
  r2rml_trig_file:
    type: string
    inputBinding:
      position: 2
      prefix: -o
      valueFrom: /tmp/$(inputs.r2rml_trig_file_name)
  input_data:
    type: string
    inputBinding:
      position: 3
      prefix: -d
      valueFrom: /data/input/$(inputs.dataset)
  base_uri:
    type: string
    inputBinding:
      position: 4
      prefix: -b
  tmp_graph_uri:
    type: string
    inputBinding:
      position: 5
      prefix: -g

outputs:
  
  trig_file_output:
    type: File
    outputBinding:
      glob: $(inputs.r2rml_trig_file_name)

