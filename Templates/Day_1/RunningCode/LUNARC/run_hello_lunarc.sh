#!/bin/bash
#SBATCH -t 00:05:00
#SBATCH -N 1                   # number of nodes
#SBATCH --tasks-per-node=4     # number of processes per node
#SBATCH -t 00:05:00            # job-time – here 5 min

#SBATCH -A lu2024-7-94
#SBATCH --reservation=MPI-course
##SBATCH --reservation=MPI-course2
##SBATCH --reservation=MPI-course3
##SBATCH --reservation=MPI-course4


#SBATCH -o result_mpihello_%j.out
#SBATCH -e result_mpihello_%j.out

cat $0

ml purge
ml foss/2024a

mpirun --bind-to core mpihello
