class: CommandLineTool
cwlVersion: v1.0
id: cuffdiff
baseCommand:
  - cuffdiff
inputs:
  - id: transcriptgtf
    type: File
    inputBinding:
      position: 1
  - id: samsorted1 
    type: File
    inputBinding:
      position: 2
  - id: samsorted2 
    type: File
    inputBinding: 
      position: 3

outputs:
  - id: outputDir
    type: Directory
    outputBinding:
      glob: cuffdiff_*
label: cuffdiff
arguments: ["-o", $(runtime.outdir)/cuffdiff_output]
requirements:
  - class: InlineJavascriptRequirement
  - class: DockerRequirement
    dockerPull: bd2kbdds/cuffdiff
