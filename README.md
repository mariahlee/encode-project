# Functional Characterization of lncRNAs in T Cell Activation

This repository contains the complete bioinformatics pipeline to identify and characterize the function of **known** long non-coding RNAs (lncRNAs) from public human T cell RNA-seq data. The analysis uses differential expression, co-expression network analysis, and functional enrichment.

The project's primary goal is to generate testable hypotheses about the roles of specific annotated lncRNAs in the human immune response.

***

## Project Workflow

This project is a multi-stage pipeline that uses Nextflow for upstream processing and R for all downstream statistical analysis and functional characterization.

1.  **Upstream RNA-seq Processing**: Raw FASTQ files are processed using the `nf-core/rnaseq` pipeline, which handles QC, alignment (HISAT2), and quantification (Salmon) against a reference annotation. This stage is managed by **Nextflow**.
2.  **Differential Expression Analysis**: The expression of all annotated genes, including known lncRNAs, is compared between activated and resting T cell samples. This analysis identifies genes that change significantly during the immune response and is performed in **R** using `DESeq2` (v1.48.1).
3.  **Co-Expression Network Analysis**: To understand gene relationships, a Weighted Gene Co-expression Network Analysis (WGCNA) (v1.73) is performed. This groups genes into functional modules and identifies highly connected "hub" genes that are likely drivers of biological processes.
4.  **Functional Enrichment Analysis**: The gene modules significantly associated with T cell activation are analyzed to determine their function. Using `clusterProfiler` (v4.16.0), we identify enriched Gene Ontology (GO) terms and KEGG pathways, allowing us to infer the function of co-expressed lncRNAs.

***

## Repository Structure
```
encode-project/
│
├── pipelines/
│   ├── run_nf-core_rnaseq.sh     # Script to launch Nextflow pipeline
│   └── Snakefile                 # Snakemake workflow for lncRNA discovery
│
├── analysis/
│   ├── 01_differential_expression.Rmd
│   ├── 02_co-expression_wgcna.Rmd
│   └── 03_functional_enrichment.Rmd
│
├── data/
│   ├── samplesheet.csv           # Required input for nf-core/rnaseq
│   └── metadata.csv              # Metadata for downstream R analysis
│
├── human_reference/
│   ├── GRCh38.p14.genome.fa      # Human reference genome
│   └── gencode.v48.annotation.gtf  # Human gene annotation
│
└── results/
├── rnaseq/                   # Output from nf-core/rnaseq
├── lncrna_discovery/         # Output from Snakemake
└── downstream_analysis/        # Output from R analyses
```
## System Requirements

* **Nextflow** (`>=21.10.x`)
* **Singularity** or **Docker** (container engine for reproducibility)
* **Conda** / **Mamba** (for managing R environment)
* **R** (`>=4.1.x`)

***

## Installation & Setup

1.  **Clone this repository:**
    ```bash
    git clone [https://github.com/mariahlee/encode-project.git](https://github.com/mariahlee/encode-project.git)
    cd encode-project
    ```

2.  **Prepare the input data:**
    * Place your reference genome (`.fa`) and annotation (`.gtf`) in the `human_reference/` directory.
    * Create a `samplesheet.csv` file in the `data/` directory with paths to your raw FASTQ files, following the `nf-core/rnaseq` format.
    * Create a `metadata.csv` file in the `data/` directory with sample information for the R analyses.

3.  **Run the analysis:**
    * Execute the `nf-core/rnaseq` pipeline using the script in the `pipelines/` directory.
    * Once complete, run the R Markdown scripts (`.Rmd`) in the `analysis/` directory sequentially to perform the DE, WGCNA, and enrichment analyses.

***
