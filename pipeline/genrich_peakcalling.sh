#!/bin/bash
#SBATCH --partition cpu_short,cpu_medium,cpu_long
#SBATCH --nodes 1
#SBATCH --ntasks-per-node 1
#SBATCH --cpus-per-task 8
#SBATCH --mem 64G
#SBATCH --time 00-06:00:00
module purge
module load genrich
sample='sample'
Genrich -t ../output/${sample}.sortn.filtered.bam -o ../output/${sample}.sortn.filtered.narrowPeak \
                                                 -b ../output/${sample}.sortn.filtered.bed \
                                                 -j -y -r -e chrM -v 2> ../log/genrich/${sample}_genrich.log
echo "genrich peakcalling: done"