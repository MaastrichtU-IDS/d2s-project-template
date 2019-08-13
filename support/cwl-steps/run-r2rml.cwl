#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

label: Data2Services tool run R2RML, Ammar Ammar <ammar257ammar@gmail.com> 


baseCommand: [docker, run]

arguments: ["--rm","--link","drill:drill", "-v" , "$(inputs.working_directory):/data", "-v", "$(runtime.outdir):/tmp", 
"-v", "$(inputs.r2rml_config_file.path):/tmp/$(inputs.r2rml_config_file.basename)", "-v", "$(inputs.r2rml_trig_file.path):/tmp/$(inputs.r2rml_trig_file.basename)", "vemonet/r2rml", "/tmp/$(inputs.r2rml_config_file.basename)"]

inputs:
  
  working_directory:
    type: string
  dataset:
    type: string
  r2rml_config_file:
    type: File
  r2rml_trig_file:
    type: File 

outputs:
  
  nquads_file_output:
    type: File
    outputBinding:
      glob: rdf_output.nq
