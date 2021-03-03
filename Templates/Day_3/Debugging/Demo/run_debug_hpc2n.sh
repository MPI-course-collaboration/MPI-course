#!/bin/bash
#SBATCH -t 00:20:00
#SBATCH -n 4
#SBATCH -N 1
#SBATCH -A SNIC2020-9-175
#SBATCH --reservation=SNIC2020-9-175-day3

#SBATCH -o result_mpihello_%j.out
#SBATCH -e result_mpihello_%j.out

cat $0

ml purge
ml foss/2019b
ml Forge/20.2-Ubuntu-16.04-x86_64

#ddt --connect mpirun mpihello
ddt --connect mpirun ringsend

