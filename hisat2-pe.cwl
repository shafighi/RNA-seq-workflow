class: CommandLineTool
cwlVersion: v1.0
baseCommand:
  - hisat2
inputs:
  - id: dta
    type: boolean
    inputBinding:
      position: 2
      prefix: '--dta'
    doc: >-
      Report alignments tailored for transcript assemblers including StringTie.
      With this option, HISAT2 requires longer anchor lengths for de novo
      discovery of splice sites. This leads to fewer alignments with
      short-anchors, which helps transcript assemblers improve significantly in
      computation and memory usage.
  - id: dta_cufflinks
    type: boolean
    inputBinding:
      position: 3
      prefix: '--dta-cufflinks'
    doc: >-
      Report alignments tailored specifically for Cufflinks. In addition to what
      HISAT2 does with the above option (--dta), With this option, HISAT2 looks
      for novel splice sites with three signals (GT/AG, GC/AG, AT/AC), but all
      user-provided splice sites are used irrespective of their signals. HISAT2
      produces an optional field, XS:A:[+-], for every spliced alignment.
  - id: m1
    type: File
    inputBinding:
      position: 4
      prefix: '-1'
    doc: >-
      Comma-separated list of files containing mate 1s (filename usually
      includes _1), e.g. -1 flyA_1.fq,flyB_1.fq. Sequences specified with this
      option must correspond file-for-file and read-for-read with those
      specified in <m2>. Reads may be a mix of different lengths. If - is
      specified, hisat2 will read the mate 1s from the "standard in" or "stdin"
      filehandle.
  - id: m2
    type: File
    inputBinding:
      position: 5
      prefix: '-2'
    doc: >-
      Comma-separated list of files containing mate 2s (filename usually
      includes _2), e.g. -2 flyA_2.fq,flyB_2.fq. Sequences specified with this
      option must correspond file-for-file and read-for-read with those
      specified in <m1>. Reads may be a mix of different lengths. If - is
      specified, hisat2 will read the mate 2s from the "standard in" or "stdin"
      filehandle.
  - id: index-base
    type: File
    inputBinding:
      position: 1
      prefix: '-x'
    doc: >-
      The basename of the index for the reference genome. The basename is the
      name of any of the index files up to but not including the final .1.ht2 /
      etc. hisat2 looks for the specified index first in the current directory,
      then in the directory specified in the HISAT2_INDEXES environment
      variable.
    secondaryFiles:
      - .1.ht2
      - .2.ht2
      - .3.ht2
      - .4.ht2
      - .5.ht2
      - .6.ht2
      - .7.ht2
      - .8.ht2
  - id: hit
    type: string
    inputBinding:
      position: 6
      prefix: '-S'
    doc: >-
      File to write SAM alignments to. By default, alignments are written to the
      "standard out" or "stdout" filehandle (i.e. the console).
  - id: process
    type: int?
    inputBinding:
      position: 7
      prefix: '-p'
    doc: 'Launch NTHREADS parallel build threads (default: 1)'
outputs:
  - id: hisat2_sam
    type: File
    outputBinding:
      glob: $(inputs.hit)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: 'quay.io/biocontainers/hisat2:2.0.4--py35_1'
