#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

label: Data2Services CWL workflow, Vincent Emonet <vincent.emonet@gmail.com> 


inputs: 
  
  abs_path: string 
  dataset: string

  step1_jdbc: string
  step1_trig_file: string
  step1_trig: string
  step1_data: string
  step1_baseuri: string
  step1_graph: string

  step2_jdbc: string
  step2_rq_file: string
  step2_text: string

  step3_config: string

  step4_rq: string
  step4_method: string
  step4_url: string
  step4_repo: string

  step6_sparql: string
  step6_endpoint: string
  step6_username: string
  step6_password: string
  step6_output_graph: string

outputs:
  
  trig_output_file:
    type: File
    outputSource: step1/trig_output_file
  config_output_file:
    type: File
    outputSource: step2/config_output_file
  rq_output_file:
    type: File
    outputSource: step3/rq_output_file
  graphdb_output_file:
    type: File
    outputSource: step4/graphdb_output_file

steps:

  step1:
    run: cwl-steps/step1-autor2rml.cwl
    in:
      abs_path: abs_path
      dataset: dataset
      jdbc: step1_jdbc
      trig_file: step1_trig_file
      trig: step1_trig
      data: step1_data
      baseuri: step1_baseuri
      graph: step1_graph
    out: [trig_output_file]

  step2:
    run: workflow/step2-config.cwl
    in:
      dataset: dataset
      jdbc: step2_jdbc
      trig_file: step1/trig_output_file
      rq_file: step2_rq_file
      text: step2_text
    out: [config_output_file]

  step3:
    run: workflow/step3-r2rml.cwl
    in:
      abs_path: abs_path
      dataset: dataset
      rq_file: step2_rq_file
      trig_file: step1/trig_output_file
      config_file: step2/config_output_file
      config: step3_config
    out: [rq_output_file]


  step4:
    run: workflow/step4-upload.cwl
    in:
      abs_path: abs_path
      dataset: dataset
      rq_file: step3/rq_output_file
      rq: step4_rq
      method: step4_method
      url: step4_url
      repo: step4_repo
    out: [graphdb_output_file]

  step6:
    run: workflow/step6-mapping.cwl
    in:
      abs_path: abs_path
      dataset: dataset
      sparql: step6_sparql
      endpoint: step6_endpoint
      username: step6_username
      password: step6_password
      output_graph: step6_output_graph
      graphdb_file: step4/graphdb_output_file
    out: [eow]
