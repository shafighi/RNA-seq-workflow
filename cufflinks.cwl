class: CommandLineTool
cwlVersion: v1.0
baseCommand:
  - cufflinks
inputs:
  - id: annotation
    type: File
    inputBinding:
      position: 2
      prefix: '-G'
  - id: bam
    type: File
    inputBinding:
      position: 3
  - id: process
    type: int?
    inputBinding:
      position: 1
      prefix: '-p'
outputs:
  - id: skipped_gtf
    type: File
    outputBinding:
      glob: 'skipped.gtf'
  - id: transcripts_gtf     
    type: File
    outputBinding:
      glob: 'transcripts.gtf'
  - id: isoforms     
    type: File
    outputBinding:
      glob: 'isoforms.fpkm_tracking'
  - id: genes     
    type: File
    outputBinding:
      glob: 'genes.fpkm_tracking'
arguments:
  - prefix: -o
    valueFrom: $(runtime.outdir)
hints:
  - class: DockerRequirement
    dockerPull: 'quay.io/biocontainers/cufflinks:2.2.1--py35_1'
