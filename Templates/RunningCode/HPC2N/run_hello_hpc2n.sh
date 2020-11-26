#!/bin/bash
#SBATCH -t 00:05:00
#SBATCH -n 4
#SBATCH -N 1
#SBATCH -A XXXX
#SBATCH -o result_mpihello_%j.out
#SBATCH -e result_mpihello_%j.out

cat $0

ml purge
ml foss/2019b

mpirun mpihello
