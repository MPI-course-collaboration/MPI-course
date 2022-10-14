from mpi4py import MPI
import numpy as np

comm = MPI.COMM_WORLD

numprocs = comm.Get_size()
myrank = comm.Get_rank()

root = 0
counts = 3 #nr. of elements to be sent/received

#initializing sending buffer
sendbuf=[1.0*myrank,2.0*myrank,3.0*myrank,4.0*myrank];

recvbuf = comm.gather(sendbuf[:counts], root=0)

if myrank == 0:
    for sublist in recvbuf:
        for x in sublist:
            print("%.3f " % x)
