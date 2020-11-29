#!/bin/bash
#SBATCH -t 00:05:00
#SBATCH -N 1                   # number of nodes
#SBATCH --tasks-per-node=4     # number of processes per node
#SBATCH -t 00:05:00            # job-time – here 5 min

#SBATCH -A mpicourse
#SBATCH --reservation=mpiCourse

#SBATCH -o result_mpihello_%j.out
#SBATCH -e result_mpihello_%j.out

cat $0

ml purge
ml foss/2019b
ml Python/3.7.4
ml SciPy-bundle/2019.10-Python-3.7.4

mpirun python3 hello_mpi.py
