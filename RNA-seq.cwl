class: Workflow
class: Workflow
cwlVersion: v1.0
id: _r_n_a_seq
label: RNA_seq
inputs:
  - id: dta_in
    type: boolean
  - id: dta_cuff_in
    type: boolean
  - id: fq1
    type: File
  - id: fq2
    type: File
  - id: indexBase
    type: File
  - id: samName
    type: string
  - id: fq3
    type: File
  - id: fq4
    type: File
  - id: indexBase_2
    type: File
  - id: samName_2
    type: string
  - id: samSortedName_2
    type: string
  - id: samSortedName
    type: string
  - id: move_script
    type: File
  - id: dir1
    type: string
  - id: dir2
    type: string
  - id: merge_script
    type: File
  - id: merged_gtf
    type: File
  - id: c_Rfile
    type: File
  - id: c_gtfFile
    type: File
  - id: c_genes_fpkm_tracking
    type: File
  - id: c_read_groups_info
    type: File
  - id: c_genes_count_tracking
    type: File
  - id: c_genes_read_group_tracking
    type: File
  - id: c_isoforms_fpkm_tracking
    type: File
  - id: c_isoforms_read_group_tracking
    type: File
  - id: c_isoforms_count_tracking
    type: File
  - id: c_isoform_exp_diff
    type: File
  - id: c_gene_exp_diff
    type: File
  - id: c_cuffdiff_output
    type: Directory
outputs: 
  - id: out1
    type: Directory
    outputSource: move/out_dir
  - id: out2
    type: Directory
    outputSource: move_2/out_dir
  - id: merge_out
    type: Directory
    outputSource: merge/outputDir
  - id: cuffdiff_out
    type: Directory
    outputSource: cuffdiff/outputDir
  - id: result
    type: File
    outputSource: cummeRbund/result
steps:
  - id: hisat2_pe
    in:
      dta: dta_in
      dta_cufflinks: dta_cuff_in 
      m1: fq1
      m2: fq2
      index-base: indexBase
      hit: samName
    out: [hisat2_sam]
    run: hisat2-pe.cwl
    label: hisat2-pe
  - id: cufflinks_sort
    in: 
      unsorted_sam: hisat2_pe/hisat2_sam
      output_name: samSortedName
    out: [output]
    run: cufflinks_sort.cwl
    label: cufflinks_sort
  - id: cufflinks
    in: 
      bam: cufflinks_sort/output
      annotation: indexBase
    out: 
      - skipped_gtf
      - transcripts_gtf
      - isoforms
      - genes
    run: cufflinks.cwl
    label: cufflink
  - id: move
    in: 
      script: move_script
      isoforms: cufflinks/isoforms
      genes: cufflinks/genes
      skipped: cufflinks/skipped_gtf
      transcripts: cufflinks/transcripts_gtf
      dir: dir1
    out:
      - out_dir 
    run: move.cwl
    label: move
  - id: hisat2_pe_2
    in:
      dta: dta_in
      dta_cufflinks: dta_cuff_in
      m1: fq3
      m2: fq4
      index-base: indexBase_2
      hit: samName_2
    out: [hisat2_sam]
    run: hisat2-pe.cwl
    label: hisat2-pe_2
  - id: cufflinks_sort_2
    in:
      unsorted_sam: hisat2_pe_2/hisat2_sam
      output_name: samSortedName_2
    out: [output]
    run: cufflinks_sort.cwl
    label: cufflinks_sort_2
  - id: cufflinks_2
    in:
      bam: cufflinks_sort_2/output
      annotation: indexBase_2
    out:
      - skipped_gtf
      - transcripts_gtf
      - isoforms
      - genes
    run: cufflinks.cwl
    label: cufflink_2
  - id: move_2
    in:
      script: move_script
      isoforms: cufflinks_2/isoforms
      genes: cufflinks_2/genes
      skipped: cufflinks_2/skipped_gtf
      transcripts: cufflinks_2/transcripts_gtf
      dir: dir2
    out:
      - out_dir
    run: move.cwl
    label: move_2
  - id: merge
    in:
      script: merge_script
      gtfs: 
        - cufflinks/transcripts_gtf
        - cufflinks_2/transcripts_gtf    
    out:
      - outputDir
    run: cuffmerge.cwl
    label: merge
  - id: cuffdiff
    in:
      transcriptgtf: merged_gtf
      samsorted1: cufflinks_sort/output
      samsorted2: cufflinks_sort_2/output
    out:
      - outputDir
    run: cuffdiff.cwl
    label: cuffdiff
  - id: cummeRbund
    in:
      Rfile: c_Rfile
      gtfFile: c_gtfFile
      genes_fpkm_tracking: c_genes_fpkm_tracking
      read_groups_info: c_read_groups_info
      genes_count_tracking: c_genes_count_tracking
      genes_read_group_tracking: c_genes_read_group_tracking
      isoforms_fpkm_tracking: c_isoforms_fpkm_tracking
      isoforms_read_group_tracking: c_isoforms_read_group_tracking
      isoforms_count_tracking: c_isoforms_count_tracking
      isoform_exp_diff: c_isoform_exp_diff
      gene_exp_diff: c_gene_exp_diff
      cuffdiff_output: c_cuffdiff_output
    out:
      - result
    run: cummeRbund.cwl
    label: cummeRbund
requirements:
  - class: MultipleInputFeatureRequirement
