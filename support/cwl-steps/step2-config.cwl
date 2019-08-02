#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

label: Data2Services CWL workflow, Ammar Ammar <ammar257ammar@gmail.com>

baseCommand: echo

requirements:
  - class: ShellCommandRequirement

inputs:
  
  dataset:
    type: string
  jdbc:
    type: string
  trig_file:
    type: File
  rq_file:
    type: string
  text:
    type: string
    inputBinding:
      position: 1
      valueFrom: "connectionURL = $(inputs.jdbc)\nmappingFile = /tmp/$(inputs.trig_file.basename)\noutputFile = /tmp/$(inputs.rq_file)\nformat = NQUADS"
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
  
  config_output_file:
    type: File
    outputBinding:
      glob: $(inputs.config_file)
