# Example of Scatterv and Gatherv 
from mpi4py import MPI
import numpy as np

comm = MPI.COMM_WORLD

if comm.Get_rank() == 0:
    sendbuf = np.arange(100, dtype='i')  # Data to scatter
    # Determine counts and displacements
    base, rem = divmod(sendbuf.size, comm.Get_size())
    counts = np.full(shape=comm.Get_size(), fill_value=base, dtype='i')
    counts[:rem] += 1

    print('counts:', counts)
else:
    sendbuf = None
    counts = np.empty(comm.Get_size(), dtype='i')

# Broadcast counts and displacements to all ranks
comm.Bcast(counts, root=0)

# Allocate recvbuf based on counts for the current rank
recvbuf = np.empty(counts[comm.Get_rank()], dtype='i')

# Scatter the data
comm.Scatterv([sendbuf, counts], recvbuf, root=0)
print(f'Rank {comm.Get_rank()} received data: {recvbuf}')

# Gather the data back
sendbuf2 = recvbuf
if comm.Get_rank() == 0:
    recvbuf2 = np.empty_like(sendbuf)  # Full array to gather data
else:
    recvbuf2 = None

comm.Gatherv(sendbuf2, [recvbuf2, counts], root=0)

if comm.Get_rank() == 0:
    print('Gathered data:', recvbuf2)
