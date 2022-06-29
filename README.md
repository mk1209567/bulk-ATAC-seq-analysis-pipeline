# Bulk-ATAC-seq-Analysis-Pipeline
Analysis pipeline for bulk-ATAC-seq assay

## Introduction:
- This is an analysis workflow for processing pair-ended bulk ATAC-seq data. It contains multiple shell scripts that can be run under Slurm managment system. Each script represents a key step in ATACseq analysis workflow. Currently, this pipeline conduct the process step by step, which provide a easy way to understand the analysis. It will continue to improve and incorporate workflow management system like Snakemake in the future.
- I also provide the structure of how I store input, output, and the intermediate data. Those files within are for display purpose only. They are empty files just to show what's the workflow and output going to be like when following this pipeline.

## Requirement
1. [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)
2. [Trimmomatic](https://github.com/usadellab/Trimmomatic)
3. [Samtools](http://www.htslib.org/)
4. [Bowtie 2](http://bowtie-bio.sourceforge.net/bowtie2/manual.shtml)
5. [Genrich](https://github.com/jsh58/Genrich)

If you are using Slurm, you probably could use **module load** to activate these tools, which is included in my scripts.
If not, you could download these tools from their source. After installed, make sure you change the direction of your tools correctly in each script.

## Steps
Following is the step to do ATAC-seq analysis and the corresponding script name. The scripts are all under *pipeline* folder.
### 1. FastQC (fastqc.sh)
- FastQC is a commly used tools to generate quality metrics for your raw sequence data.
### 2. Remove adaptor (trimadapt.sh)
- After FastQC, we will also get a sense of the contamination caused by adaptor. We will use Trimmomatic to remove adaptors. Note, Trimmomatic package comes with different adaptor sequences, you should choose the one match your library prep.
### 3. Alignment (bowtie_align.sh)
- Align reads to the reference genome. To use bowtie2, reference sequence needs to be indexed. We could either do bowtie2-build <genome.fa> to create indexes or we could download indexes for common references (e.g., hg38, hg19, mm10) directly from their [website](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml). 
- The output is a SAM file, which has alignment information for each read. SAM file is big and uncompressed. We would like to use samtools to sort and convert it into binary format (BAM file).
### 4. Data QC (filter_chr.sh)
- After alignment, some reads are aligned to mitochondria chromosome(chrM), unlocalized sequences(chr*_random), and unplaced sequences (chrUn). We would like to remove these before peak calling.
- For further Data QC, we could also use samtools to remove low quality score aligned reads or unpaired reads. We didn't include this, but coudl add in the future.
### 5. Peak-Calling (genrich_peakcalling.sh)
- Peak calling is a metthod used to identify areas in a genome that has been enriched with aligned reads.
- We used Genrich which could help us remove PCR duplicates, remove mitochondrial reads, analyze multumapping reads in one step.
- The output of this step is a bed file and a narrowPeak file. They can be visulized using IGV tools.
### 6. Further analysis (future work)
- Comparing peak files with bedtools: bedtools intersect and bedtools substract.
- Annotation: finding genomic features near the peaks-ChIPseeker.
- Motif finding: HOMER

## Notes:
As an associate Bioinformatician, I do find it useful when reading others step-by-step pipeline instead of using the one-step pipeline. I wish my documentation could also help others better understand the key component of sequencing analysis. Feel free to contact me about any questions or suggestions.

## References:
1. Andrews, S. (2010). FastQC:  A Quality Control Tool for High Throughput Sequence Data
2. Bolger, A. M., Lohse, M., & Usadel, B. (2014). Trimmomatic: A flexible trimmer for Illumina Sequence Data.
3. Langmead B, Salzberg S. Fast gapped-read alignment with Bowtie 2. Nature Methods. 2012, 9:357-359.
4. Danecek, P. et al. (2021). Twelve years of SAMtools and BCFtools. GigaScience, 10(2). https://doi.org/10.1093/gigascience/giab008
5. Gaspar, J. M.(n.d.). GitHub - jsh58/Genrich: Detecting sites of genomic enrichment. GitHub. https://github.com/jsh58/Genrich
6. Gaspar, J. M. (2019, January 18). ATAC-seq Guidelines. Harvard FAS Informatics. https://informatics.fas.harvard.edu/atac-seq-guidelines.html
