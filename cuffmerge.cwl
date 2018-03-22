class: CommandLineTool
cwlVersion: v1.0
id: cuffdiff
baseCommand: sh
inputs:
  - id: script
    type: File 
    inputBinding:
      position: 0
  - id: gtfs
    type: { type: array, items: File} 
    inputBinding:
      position: 1
outputs:
  - id: outputDir
    type: Directory
    outputBinding:
      glob: merged_asm
  - id: gtfList
    type: File
    outputBinding:
      glob: assemblies.txt
label: cuffmerge
requirements:
  - class: InlineJavascriptRequirement
  - class: DockerRequirement
    dockerPull: bd2kbdds/cuffmerge:latest
