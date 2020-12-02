#!/bin/bash
#SBATCH -t 00:05:00
#SBATCH -n 4
#SBATCH -A YOUR_PROJECT
#SBATCH --reservation=snic_mpi

ml purge
ml foss/2019b

module load Arm-Forge/20.1-Redhat-7.0-x86_64

ddt --connect mpirun mpihello
