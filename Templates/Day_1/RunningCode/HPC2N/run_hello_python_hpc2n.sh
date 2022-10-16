#!/bin/bash

#SBATCH -A Project_ID
#SBATCH --reservation=reserv

#SBATCH -t 00:05:00
#SBATCH -n 4

#SBATCH -o result_mpihello_%j.out
#SBATCH -e result_mpihello_%j.out

cat $0

ml purge
ml foss/2021b
ml Python/3.9.6
ml SciPy-bundle/2021.10

srun python3 hello_mpi.py
