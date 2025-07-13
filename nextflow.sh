#!/bin/bash

nextflow run nf-core/rnaseq \
    --input samplesheet.csv \
    --outdir results \
    --fasta human_reference/GRCh38.p14.genome.fa \
    --gtf human_reference/gencode.v48.chr_patch_hapl_scaff.annotation.gtf \
    --aligner hisat2 \
    --pseudo_aligner salmon \
    --remove_ribo_rna \
    --email lee.mc0510@gmail.com \
    -profile singularity \
    -c custom.config \
    -resume
