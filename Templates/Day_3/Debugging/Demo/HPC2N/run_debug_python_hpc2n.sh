#!/bin/bash
#SBATCH -t 00:20:00
#SBATCH -n 4
#SBATCH -N 1
#SBATCH -A SNIC2022-22-890
#SBATCH --reservation=mpi-course-day3

#SBATCH -o result_mpihello_%j.out
#SBATCH -e result_mpihello_%j.out

cat $0

ml purge
ml foss/2021b
ml Python/3.9.6
ml SciPy-bundle/2021.10 
ml Forge/22.0.1-linux-x86_64

ddt --connect mpirun python3 %allinea_python_debug%  hello_mpi.py

