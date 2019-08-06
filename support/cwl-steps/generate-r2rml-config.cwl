#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

label: Data2Services tool generate R2RML config file, Ammar Ammar <ammar257ammar@gmail.com>

baseCommand: echo

requirements:
  - class: ShellCommandRequirement

inputs:
  
  dataset:
    type: string
  input_data_jdbc:
    type: string
  r2rml_trig_file:
    type: File
  rq_file_name:
    type: string
  r2rml_config_content:
    type: string
    inputBinding:
      position: 1
      valueFrom: "connectionURL = $(inputs.input_data_jdbc)\nmappingFile = /tmp/$(inputs.r2rml_trig_file.basename)\noutputFile = /tmp/$(inputs.rq_file_name)\nformat = NQUADS"
  spit:
    type: string
    default: ">"
    inputBinding:
      position: 2
  config_file:
    type: string
    default: "config.properties"
    inputBinding:
      position: 3

outputs:
  
  r2rml_config_file_output:
    type: File
    outputBinding:
      glob: $(inputs.config_file)
