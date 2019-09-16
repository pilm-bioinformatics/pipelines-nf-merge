# pipelines-nf-merge

merge fastq/fastq files into one by sample name


The input file needs to look like this:

```
data/file1.fastq,sample1
data/file2.fastq,sample1
```

In this case the files created would be:

```
sample1.fastq.gz
```

Each file has to be associated to a final sample name. For paired data, it would look like this:

```
data/file1_R1.fastq,sample_R1
data/file2_R1.fastq,sample_R1
data/file1_R2.fastq,sample_R2
data/file2_R2.fastq,sample_R2
```

and the way to run the pipeline is:

`nextflow run pilm-bioinformatics/pipelines-nf-merge --csv file.csv --outdir results`

