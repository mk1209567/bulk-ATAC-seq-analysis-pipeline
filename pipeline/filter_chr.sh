#!/bin/bash
#SBATCH --partition cpu_dev,cpu_short,cpu_medium,cpu_long
#SBATCH --nodes 1
#SBATCH --ntasks-per-node 1
#SBATCH --cpus-per-task 4
#SBATCH --mem 32G
#SBATCH --time 00-03:00:00
module load samtools
sample='sample'
samtools view -h ../output/${sample}.sortn.bam \
                | sed '/chrM/d;/chrEBV/d;/random/d;/chrUn/d' \
                | samtools view -Shb - > ../output/${sample}.sortn.filtered.bam
echo "filtering chrM, chr*random, and chrUn: done"