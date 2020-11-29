#!/bin/bash
#SBATCH -t 00:05:00
#SBATCH -n 4
#SBATCH -A YOUR_PROJECT
#SBATCH --reservation=snic_mpi

ml purge
ml foss/2019b

ml Python/3.7.4
ml SciPy-bundle/2019.10-Python-3.7.4

mpirun python3 hello_mpi.py
