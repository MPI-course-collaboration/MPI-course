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
ml Python/3.10.8
ml SciPy-bundle/2023.02
ml mpi4py/3.1.4
ml linaro_forge/23.0.3

ddt --connect mpirun python3 %allinea_python_debug%  hello_mpi.py

