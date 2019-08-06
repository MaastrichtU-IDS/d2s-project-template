#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

label: Data2Services tool generate R2RML config file, Ammar Ammar <ammar257ammar@gmail.com>

baseCommand: echo

requirements:
  - class: ShellCommandRequirement

arguments: ["connectionURL = $(inputs.input_data_jdbc)\nmappingFile = /tmp/$(inputs.r2rml_trig_file.basename)\noutputFile = /tmp/rdf_output.nq\nformat = NQUADS", ">", "config.properties"]

inputs:
  
  dataset:
    type: string
  input_data_jdbc:
    type: string
  r2rml_trig_file:
    type: File

outputs:
  
  r2rml_config_file_output:
    type: File
    outputBinding:
      glob: config.properties
