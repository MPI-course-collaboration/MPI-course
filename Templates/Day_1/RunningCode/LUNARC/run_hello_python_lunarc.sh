#!/bin/bash

## Basics
#SBATCH -t 00:05:00
#SBATCH -N 1                   # number of nodes
#SBATCH --tasks-per-node=4     # number of processes per node
#SBATCH -t 00:05:00            # job-time – here 5 min

## Accounting/Reservation
#SBATCH -A lu2025-7-75 
#SBATCH --reservation=MPI-course-1day
##SBATCH --reservation=MPI-course-2day
##SBATCH --reservation=MPI-course-3day
##SBATCH --reservation=MPI-course-4day

## Output/Error files
#SBATCH -o result_mpihello_%j.out
#SBATCH -e result_mpihello_%j.out

cat $0

ml purge
ml foss/2024a
ml Python/3.12.3
ml SciPy-bundle/2024.05
ml mpi4py/4.0.1

mpirun --bind-to core python3 hello_mpi.py
