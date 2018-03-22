class: CommandLineTool
cwlVersion: v1.0
id: cummerbund
baseCommand:
  - Rscript
inputs:
  - id: Rfile
    type: File
    inputBinding:
      position: 0
  - id: gtfFile
    type: File
    inputBinding:
      position: 1
  - id: genes_fpkm_tracking
    type: File
    inputBinding:
      position: 2
  - id: read_groups_info
    type: File
    inputBinding:
      position: 3
  - id: genes_count_tracking
    type: File
    inputBinding:
      position: 4
  - id: genes_read_group_tracking
    type: File
    inputBinding:
      position: 5
  - id: isoforms_fpkm_tracking
    type: File
    inputBinding:
      position: 6
  - id: isoforms_read_group_tracking
    type: File
    inputBinding:
      position: 7
  - id: isoforms_count_tracking
    type: File
    inputBinding:
      position: 8
  - id: isoform_exp_diff
    type: File
    inputBinding:
      position: 9
  - id: gene_exp_diff
    type: File
    inputBinding:
      position: 10
  - id: cuffdiff_output
    type: Directory
    inputBinding: 
      position: 11
outputs: 
  - id: result
    type: File
    outputBinding:
      glob: 'cuff.txt'
label: cummerbund
requirements:
  - class: InlineJavascriptRequirement
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioconductor-cummerbund:2.16.0--r3.3.2_0
