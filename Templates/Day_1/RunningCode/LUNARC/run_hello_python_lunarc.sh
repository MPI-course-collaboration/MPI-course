#!/bin/bash
#SBATCH -t 00:05:00
#SBATCH -N 1                   # number of nodes
#SBATCH --tasks-per-node=4     # number of processes per node
#SBATCH -t 00:05:00            # job-time – here 5 min

#SBATCH -A lu2023-7-75
#SBATCH --reservation=mpi-course
##SBATCH --reservation=mpi-course-2day
##SBATCH --reservation=mpi-course-3day
##SBATCH --reservation=mpi-course-4day

#SBATCH -o result_mpihello_%j.out
#SBATCH -e result_mpihello_%j.out

cat $0

ml purge
ml foss/2022b
ml Python/3.10.8
ml SciPy-bundle/2023.02
ml mpi4py/3.1.4

mpirun python3 hello_mpi.py
