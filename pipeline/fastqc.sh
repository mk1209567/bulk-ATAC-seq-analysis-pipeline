#!/bin/bash
#SBATCH --partition cpu_dev
#SBATCH --nodes 1
#SBATCH --ntasks-per-node 1
#SBATCH --cpus-per-task 2
#SBATCH --mem 16G
#SBATCH --time 00-03:00:00
module load fastqc
#QC on paired-end sequencing sample, output summary in fastQC/ folder
fastqc -o fastQC -t 2 \
          sample.R1.fastq.gz \
          sample.R2.fastq.gz
