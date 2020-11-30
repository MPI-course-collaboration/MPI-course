#!/bin/bash
#SBATCH -t 00:05:00
#SBATCH -n 4
#SBATCH -A SNIC2020-9-175
#SBATCH --reservation=SNIC2020-9-175-day1

#SBATCH -o result_mpihello_%j.out
#SBATCH -e result_mpihello_%j.out

cat $0

ml purge
ml foss/2019b
ml Python/3.7.4
ml SciPy-bundle/2019.10-Python-3.7.4

mpirun python3 hello_mpi.py
