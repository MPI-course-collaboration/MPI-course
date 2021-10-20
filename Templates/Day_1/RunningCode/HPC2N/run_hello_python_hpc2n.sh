#!/bin/bash
#SBATCH -t 00:05:00
#SBATCH -n 4
#SBATCH -A SNIC2021-22-733
#SBATCH --reservation=snic2021-22-733-day1 

#SBATCH -o result_mpihello_%j.out
#SBATCH -e result_mpihello_%j.out

cat $0

ml purge
ml foss/2021a
ml SciPy-bundle/2021.05 

srun python3 hello_mpi.py
