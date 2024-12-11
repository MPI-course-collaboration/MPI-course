# Example of Scatterv and Gatherv 
from mpi4py import MPI
import numpy as np

comm = MPI.COMM_WORLD
rank = comm.Get_rank()
size = comm.Get_size()

if rank == 0:
    sendbuf = np.arange(100, dtype='i')  # Data to scatter
    # Determine counts and displacements
    counts = np.full(size, 100 // size, dtype='i')
    counts[:100 % size] += 1
    displs = np.zeros(size, dtype='i')
    displs[1:] = np.cumsum(counts[:-1])

    print('counts:', counts)
    print('displs:', displs)
else:
    sendbuf = None
    counts = np.empty(size, dtype='i')
    displs = np.empty(size, dtype='i')  # Proper allocation for Bcast

# Broadcast counts and displacements to all ranks
comm.Bcast(counts, root=0)
comm.Bcast(displs, root=0)

# Allocate recvbuf based on counts for the current rank
recvbuf = np.empty(counts[rank], dtype='i')

# Scatter the data
comm.Scatterv([sendbuf, counts, displs, MPI.INT], recvbuf, root=0)
print(f'Rank {rank} received data: {recvbuf}')

# Gather the data back
sendbuf2 = recvbuf
if rank == 0:
    recvbuf2 = np.empty(100, dtype='i')  # Full array to gather data
else:
    recvbuf2 = None

comm.Gatherv(sendbuf2, [recvbuf2, counts, displs, MPI.INT], root=0)

if rank == 0:
    print('Gathered data:', recvbuf2)
