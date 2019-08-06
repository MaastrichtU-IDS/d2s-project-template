#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

label: Data2Services tool run xml2rdf to generate RDF, Vincent Emonet <vincent.emonet@gmail.com> 

baseCommand: [docker, run]

arguments: [ "--rm", "-v" , "$(inputs.working_directory):/data", "-v", "$(runtime.outdir):/tmp", "xml2rdf", "-i", "/data/input/$(inputs.dataset)/*.xml", "-o", "/tmp/rdf_output.nq"]

requirements:
  EnvVarRequirement:
    envDef:
      HOME: $(inputs.working_directory)

inputs:
  
  working_directory:
    type: string
  dataset:
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
  nquads_file_output:
    type: File
    outputBinding:
      glob: rdf_output.nq