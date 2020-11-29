from mpi4py import MPI
import sys

comm = MPI.COMM_WORLD

numprocs = comm.Get_size()
myrank = comm.Get_rank()

if myrank == 0:
    alpha = int(sys.argv[1])
else:
    alpha = None

#broadcast the value of alpha
alpha = comm.bcast(alpha, root=0)

print("Value of alpha on rank %d is: %d" % (myrank, alpha))
