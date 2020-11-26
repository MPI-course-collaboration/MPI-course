#!/bin/bash
#SBATCH -t 00:20:00
#SBATCH -n 4
#SBATCH -N 1
#SBATCH -A XXX
#SBATCH -o result_mpihello_%j.out
#SBATCH -e result_mpihello_%j.out

cat $0

ml purge
ml foss/2019b
ml Python/3.7.4
ml SciPy-bundle/2019.10-Python-3.7.4
ml Forge/20.2-Ubuntu-16.04-x86_64

ddt --connect mpirun python %allinea_python_debug%  hello_mpi.py

