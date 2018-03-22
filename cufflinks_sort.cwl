class: CommandLineTool
cwlVersion: v1.0
id: cufflinks_sort
baseCommand:
  - sort
inputs:
  - id: unsorted_sam
    type: File
    inputBinding:
      position: 1
  - id: output_name
    type: string
    inputBinding:
      position: 2
      prefix: '>'
outputs:
  - id: output
    type: File
    outputBinding:
      glob: $(inputs["output_name"])
label: cufflinks_sort
arguments:
  - position: 0
    prefix: ''
    shellQuote: false
    valueFrom: '-k 3,3 -k 4,4n '
requirements:
  - class: ShellCommandRequirement
  - class: InlineJavascriptRequirement
  - class: DockerRequirement
    dockerPull: 'quay.io/biocontainers/cufflinks:2.2.1--py35_1'
