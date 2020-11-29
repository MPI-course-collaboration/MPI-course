from mpi4py import MPI
import numpy as np

comm = MPI.COMM_WORLD

numprocs = comm.Get_size()
myrank = comm.Get_rank()

root = 0
counts = 3 #nr. of elements to be sent/received

#initializing sending buffer
sendbuf=np.array([1.0*myrank,2.0*myrank,3.0*myrank,4.0*myrank])

recvbuf = comm.reduce(sendbuf[:counts],op=MPI.SUM,root=root)

if myrank == 0:
    print("Array {:.3f}  {:.3f}  {:.3f} ".format(recvbuf[0],recvbuf[1],recvbuf[2]))
