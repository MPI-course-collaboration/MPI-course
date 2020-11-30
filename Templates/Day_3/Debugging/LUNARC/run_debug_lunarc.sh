#!/bin/bash
#SBATCH -t 00:20:00
#SBATCH -n 4
#SBATCH -N 1

#SBATCH -A mpicourse
#SBATCH --reservation=mpiCourse

#SBATCH -o result_mpi_debug_%j.out
#SBATCH -e result_mpi_debug_%j.out

cat $0

ml purge
ml foss/2019b
ml arm_forge/20.1.1

ddt --connect mpirun hello_mpi.py

