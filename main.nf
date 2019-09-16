#!/usr/bin/env nextflow

if (!params.csv)  exit 1, "No input file selected. Use --csv to point to a CSV file where column 1 is fastq, column 2 sample id"

Channel
      .fromPath(params.csv, checkIfExists: true)
      .splitCsv(header:false)
      .map { row -> [file(row[0]), row[1]] }
      .ifEmpty { exit 1, "params.csv was empty - no input files supplied" }
      .groupTuple(by: [1])
      .into{reads_ch; print_ch}

process merge {
    publishDir "${params.outdir}", mode: 'copy'

    input:
    set file(reads), val(sample_id) from reads_ch

    output:
    file "*fastq*"

    script:
    cat = "cat"
    if (reads[1].getExtension() ==~ /gz/ ){
        cat = "zcat"
    } 
    """
    $cat $reads | gzip > ${sample_id}.fastq.gz
    """   
}
