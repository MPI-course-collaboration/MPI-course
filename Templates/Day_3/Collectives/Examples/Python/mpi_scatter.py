from mpi4py import MPI
import numpy as np

comm = MPI.COMM_WORLD

numprocs = comm.Get_size()
myrank = comm.Get_rank()

root = 0
counts = 3 #nr. of elements to be sent/received

#allocating sending buffer: counts elements per rank
if myrank == 0:
    sendbuf = []
    for i in range(numprocs):
    	sendbuf.append([i * counts + j for j in range(counts)])
else:
    sendbuf = None

recvbuf = comm.scatter(sendbuf,root=root)

print("My rank= %d, Array = %.3f %.3f %.3f" % (myrank,recvbuf[0],recvbuf[1],recvbuf[2]))
