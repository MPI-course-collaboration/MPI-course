#!/bin/bash

#SBATCH -A Project_ID
#SBATCH --reservation=reserv

#SBATCH -t 00:05:00
#SBATCH -n 2

#SBATCH -o result_%j.out
#SBATCH -e result_%j.out

cat $0

ml purge
ml foss/2021b
ml Python/3.9.6
ml SciPy-bundle/2021.10

mpirun python3 $* 
