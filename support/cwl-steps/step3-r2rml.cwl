#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

label: Data2Services CWL workflow, Ammar Ammar <ammar257ammar@gmail.com> 


baseCommand: [docker, run]

arguments: ["--rm","--link","drill:drill", "-v" , "$(inputs.abs_path):/data", "-v", "$(runtime.outdir):/tmp", 
"-v", "$(inputs.config_file.path):/tmp/$(inputs.config_file.basename)", "-v", "$(inputs.trig_file.path):/tmp/$(inputs.trig_file.basename)", "r2rml"]

inputs:
  
  abs_path:
    type: string
  dataset:
    type: string
  rq_file:
    type: string
  config_file:
    type: File
  trig_file:
    type: File
  config:
    type: string
    inputBinding:
      position: 1
      valueFrom: /tmp/$(inputs.config_file.basename) 

outputs:
  
  rq_output_file:
    type: File
    outputBinding:
      glob: $(inputs.rq_file)
