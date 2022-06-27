#!/bin/bash
#SBATCH --partition cpu_dev
#SBATCH --nodes 1
#SBATCH --ntasks-per-node 1
#SBATCH --cpus-per-task 2
#SBATCH --mem 16G
#SBATCH --time 00-03:00:00
module load fastqc
#change the $readPaht and $sample to your desired folder and the fastq file names
readPath="../data"
sample='sample'
fastqc -o ../fastQC -t 2 \
        $readPath/${sample}_R1.fastq.gz \
        $readPath/${sample}_R2.fastq.gz