#!/bin/bash
#SBATCH --partition cpu_dev
#SBATCH --nodes 1
#SBATCH --ntasks-per-node 1
#SBATCH --cpus-per-task 2
#SBATCH --mem 16G
#SBATCH --time 00-03:00:00
module load trimmomatic
#change the $readPaht and $sample to your desired folder and the fastq file names
readPath="../data"
sample='sample'
java -jar /gpfs/share/apps/trimmomatic/0.36/trimmomatic-0.36.jar PE -phred33 \
                    ${readPath}/${sample}_R1.fastq.gz \
                    ${readPath}/${sample}_R2.fastq.gz \
                    ${readPath}/${sample}_R1.paired.fastq.gz ${readPath}/${sample}_R1.unpaired.fastq.gz \
                    ${readPath}/${sample}_R2.paired.fastq.gz ${readPath}/${sample}_R2.unpaired.fastq.gz \
                    ILLUMINACLIP:/gpfs/share/apps/trimmomatic/0.36/adapters/NexteraPE-PE.fa:2:30:10 \
                    LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36 > ../log/trim/${sample}_trim.log 2>&1