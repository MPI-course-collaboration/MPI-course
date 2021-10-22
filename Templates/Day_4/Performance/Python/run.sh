#!/bin/bash
#SBATCH -t 00:05:00
#SBATCH -n 2
#SBATCH -A SNIC2021-22-733
#SBATCH --reservation=snic2021-22-733-day4
#SBATCH -o result_%j.out
#SBATCH -e result_%j.out

cat $0

ml purge
ml foss/2021a
ml SciPy-bundle/2021.05

mpirun python3 $* 
