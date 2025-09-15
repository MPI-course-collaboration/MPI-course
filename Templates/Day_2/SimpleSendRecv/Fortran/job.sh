#!/bin/bash
#SBATCH -N 1                   # number of nodes
#SBATCH --tasks-per-node=2     # number of processes per node
#SBATCH -t 00:08:00            # job-time – here 5 min

#SBATCH -A lu2025-7-75
##SBATCH --reservation=mpi-course-1day
##SBATCH --reservation=mpi-course-2day
##SBATCH --reservation=mpi-course-3day
##SBATCH --reservation=mpi-course-4day

#SBATCH -o result_mpihello_%j.out
#SBATCH -e result_mpihello_%j.out

cat $0

ml purge
ml foss/2024a
ml Python/3.12.3
ml SciPy-bundle/2024.05
ml mpi4py/4.0.1


mpifort -O3 -march=native -o mpisendrecv mpi_send_recv.f90
mpirun --bind-to core mpisendrecv

