#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

label: Data2Services CWL workflow, Ammar Ammar <ammar257ammar@gmail.com> 

baseCommand: [docker, run]

arguments: [ "--rm", "--link","drill:drill", "-v" , "$(inputs.abs_path):/data", "-v", "$(runtime.outdir):/tmp", "autor2rml", "-r"]

requirements:
  EnvVarRequirement:
    envDef:
      HOME: $(inputs.abs_path)

inputs:
  
  abs_path:
    type: string
  dataset:
    type: string
  jdbc:
    type: string
    inputBinding:
      position: 1
      prefix: -j
  trig_file:
    type: string
  trig:
    type: string
    inputBinding:
      position: 2
      prefix: -o
      valueFrom: /tmp/$(inputs.trig_file)
  data:
    type: string
    inputBinding:
      position: 3
      prefix: -d
      valueFrom: /data/input/$(inputs.dataset)
  baseuri:
    type: string
    inputBinding:
      position: 4
      prefix: -b
  graph:
    type: string
    inputBinding:
      position: 5
      prefix: -g

outputs:
  
  trig_output_file:
    type: File
    outputBinding:
      glob: $(inputs.trig_file)

