# Example of Scatterv and Gatherv 
from mpi4py import MPI
import numpy as np

comm = MPI.COMM_WORLD
rank = comm.Get_rank()
size = comm.Get_size()

if rank == 0:
    sendbuf = np.arange(100, dtype='i')
    # Determine the counts and displacements
    # for the scatter operation
    counts = np.full(size, 100//size, dtype='i')
    counts[:100%size] += 1
    displs = np.insert(np.cumsum(counts), 0, 0)[:-1]

    print('counts:', counts)
    print('displs:', displs)

else:
    sendbuf = None
    counts = np.empty(size, dtype='i')
    displs = None  

# Scatter the data
# First we broadcast the counts to all processes
comm.Bcast(counts, root=0)

# Otherwise the recvbuf will have the same size as the sendbuf
recvbuf = np.empty(counts[rank], dtype='i')

comm.Scatterv([sendbuf, counts, displs, MPI.INT], recvbuf, root=0)

print('Rank:', rank, 'recvbuf:', recvbuf)

