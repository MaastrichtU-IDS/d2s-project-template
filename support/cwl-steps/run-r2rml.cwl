#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

label: Data2Services CWL workflow, Ammar Ammar <ammar257ammar@gmail.com> 


baseCommand: [docker, run]

arguments: ["--rm","--link","drill:drill", "-v" , "$(inputs.working_directory):/data", "-v", "$(runtime.outdir):/tmp", 
"-v", "$(inputs.r2rml_config_file.path):/tmp/$(inputs.r2rml_config_file.basename)", "-v", "$(inputs.r2rml_trig_file.path):/tmp/$(inputs.r2rml_trig_file.basename)", "r2rml", "/tmp/$(inputs.r2rml_config_file.basename)"]

inputs:
  
  working_directory:
    type: string
  dataset:
    type: string
  rq_file_name:
    type: string
  r2rml_config_file:
    type: File
  r2rml_trig_file:
    type: File 

outputs:
  
  rq_file_output:
    type: File
    outputBinding:
      glob: $(inputs.rq_file_name)
