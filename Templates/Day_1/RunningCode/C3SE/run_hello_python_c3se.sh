#!/bin/bash
#SBATCH -t 00:05:00
#SBATCH -n 4
#SBATCH -A YOUR_PROJECT

ml purge
ml mpi4py

srun python3 hello_mpi.py
