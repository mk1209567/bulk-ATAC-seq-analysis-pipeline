#!/bin/bash
#SBATCH --partition cpu_medium
#SBATCH --nodes 1
#SBATCH --ntasks-per-node 1
#SBATCH --cpus-per-task 8
#SBATCH --mem 64G
#SBATCH --time 00-12:00:00
module load bowtie2 samtools
#decide the refernce genome: hg38
bt2idx="../assemblies/hg38"
sample='sample'
bowtie2 --very-sensitive -p 8 -x $bt2idx/genome -1 ../data/${sample}_R1.paired.fastq.gz \
                                                -2 ../data/${sample}_R2.paired.fastq.gz \
                                                2> ../log/bam/${sample}.bowtie2.log \
                                                | samtools view -u - \
                                                | samtools sort -n -o ../output/${sample}.sortn.bam -
