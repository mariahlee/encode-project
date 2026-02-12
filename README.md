# Functional Annotation of lncRNAs in Activated CD4+ T-Cells

This project identifies and predicts the biological functions of long non-coding RNAs (lncRNAs) during CD4+ T-cell activation using WGCNA co-expression networks and functional enrichment analysis.

## Workflow Summary
Preprocessing (Nextflow): Standardized pipeline for alignment and quantification using `nf-core/rnaseq`. \
Differential Expression: Identification of activation-responsive genes using DESeq2. \
Co-expression Network Analysis (WGCNA): Grouping genes into modules based on expression patterns. \
Functional Enrichment: GO (BP, MF, CC) and KEGG pathway analysis on module members. \
lncRNA Inference: Integration of DE statistics and network position (kME) to assign predicted functions.

## Preprocessing Command
The raw data was processed using the `nf-core/rnaseq` pipeline (v3.18.0):
```
nextflow run nf-core/rnaseq -r 3.18.0 \
    --input samplesheet.csv \
    --outdir results \
    --fasta human_reference/GRCh38.p14.genome.fa \
    --gtf human_reference/gencode.v48.chr_patch_hapl_scaff.annotation.gtf \
    --aligner hisat2 \
    --pseudo_aligner salmon \
    --remove_ribo_rna \
    -profile singularity \
    -c custom.config \
    -resume
```
## Repository Contents
📂 scripts/ \
DEG_Analysis.Rmd: Differential expression analysis and lncRNA candidate filtering. \
WGCNA.Rmd: System-level network construction and hub gene identification. \
functional_enrichment.Rmd: GO/KEGG enrichment analysis for identified modules.

📂 results/ \
LncRNA_Functional_Annotation_FULL_cd4_naive.csv: Primary output for Naive T-cells. Contains kME scores, DE stats, and inferred functions. \
LncRNA_Functional_Annotation_FULL_cd4_all.csv: Primary output for Global CD4+ population. \
Master_Functional_Enrichment_Results.csv: Compiled enrichment data for all modules across all ontologies.

📂 docs/ \
technical_project_brief.md: Formal project summary and detailed methodology.

## Key Findings
Turquoise Module: Strongly enriched for Cell Cycle and DNA Replication. \
Brown Module: Enriched for T-cell Activation and Calcium Signaling. \
Blue Module: Associated with Metabolic reprogramming and RNA processing.

## Requirements
Nextflow & Singularity \
R >= 4.0 \
Packages: tidyverse, DESeq2, WGCNA, clusterProfiler, biomaRt
