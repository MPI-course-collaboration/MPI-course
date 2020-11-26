#!/usr/bin/env python

from mpi4py import MPI

my_comm = MPI.COMM_WORLD

size = my_comm.Get_size()
rank = my_comm.Get_rank()

print ('I am rank:', rank, ' out of:', size)
