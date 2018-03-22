class: CommandLineTool
cwlVersion: v1.0
id: move
baseCommand:
  - sh
inputs:
  - id: script
    type: File
    inputBinding:
      position: 0
  - id: genes
    type: File
    inputBinding:
      position: 1
  - id: isoforms
    type: File
    inputBinding:
      position: 2
  - id: transcripts
    type: File
    inputBinding:
      position: 3
  - id: skipped
    type: File
    inputBinding:
      position: 4
  - id: dir
    type: string
    inputBinding:
      position: 5
outputs:
  - id: out_dir
    type: Directory
    outputBinding:
      glob: cuff_out*
label: move
requirements:
  - class: InlineJavascriptRequirement
