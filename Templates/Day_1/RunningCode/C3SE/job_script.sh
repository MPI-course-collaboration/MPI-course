#!/bin/bash
#SBATCH -t 00:05:00
#SBATCH -n 4
#SBATCH -A YOUR_PROJECT
#SBATCH --reservation=snic_mpi

ml purge
ml foss/2019b

mpirun mpihello
