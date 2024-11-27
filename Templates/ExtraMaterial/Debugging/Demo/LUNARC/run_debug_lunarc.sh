#!/bin/bash
#SBATCH -t 00:20:00
#SBATCH -n 4
#SBATCH -N 1

#SBATCH -A lu2023-7-75
##SBATCH --reservation=mpi-course
##SBATCH --reservation=mpi-course-2day
#SBATCH --reservation=mpi-course-3day
##SBATCH --reservation=mpi-course-4day


#SBATCH -o result_mpi_debug_%j.out
#SBATCH -e result_mpi_debug_%j.out

cat $0

ml purge
ml foss/2022b
ml linaro_forge/23.0.3

ddt --connect mpirun hello_mpi

