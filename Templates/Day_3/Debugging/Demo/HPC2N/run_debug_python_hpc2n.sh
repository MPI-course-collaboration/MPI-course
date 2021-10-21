#!/bin/bash
#SBATCH -t 00:20:00
#SBATCH -n 4
#SBATCH -N 1
#SBATCH -A SNIC2021-22-733
#SBATCH --reservation=snic2021-22-733-day3

#SBATCH -o result_mpihello_%j.out
#SBATCH -e result_mpihello_%j.out

cat $0

ml purge
ml foss/2021a
ml SciPy-bundle/2021.05 
ml Forge/21.0.2-linux-x86_64

ddt --connect mpirun python3 %allinea_python_debug%  hello_mpi.py

