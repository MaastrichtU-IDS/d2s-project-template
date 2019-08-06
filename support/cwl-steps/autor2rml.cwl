#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

label: Data2Services tool run AutoR2RML to generate mappings, Ammar Ammar <ammar257ammar@gmail.com> 

baseCommand: [docker, run]

arguments: [ "--rm", "--link","drill:drill", "-v" , "$(inputs.working_directory):/data", "-v", "$(runtime.outdir):/tmp", "autor2rml", "-r", "-o", "/tmp/mapping.trig", "-d", "/data/input/$(inputs.dataset)"]

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
    default: jdbc:drill:drillbit=drill:31010
    inputBinding:
      position: 1
      prefix: -j
  tmp_base_uri:
    type: string
    default: https://w3id.org/data2services/
    inputBinding:
      position: 2
      prefix: -b
  tmp_graph_uri:
    type: string
    default: https://w3id.org/data2services/graph/autor2rml
    inputBinding:
      position: 3
      prefix: -g

outputs:
  
  r2rml_trig_file_output:
    type: File
    outputBinding:
      glob: mapping.trig

