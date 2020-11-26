#!/bin/bash
#SBATCH -t 00:05:00
#SBATCH -n 4
#SBATCH -N 1
#SBATCH -A XXXX
#SBATCH -o result_mpihello_%j.out
#SBATCH -e result_mpihello_%j.out

cat $0

ml purge
ml foss/2019b
ml Python/3.7.4
ml SciPy-bundle/2019.10-Python-3.7.4

mpirun python hello_mpi.py
