# Example of Scatterv and Gatherv 
from mpi4py import MPI
import numpy as np

comm = MPI.COMM_WORLD

if comm.Get_rank() == 0:
    sendbuf = np.arange(100, dtype='i')
    # Determine the counts
    # for the scatter operation
    base, rem = divmod(sendbuf.size, comm.Get_size())
    counts = np.full(shape=comm.Get_size(), fill_value=base, dtype='i')
    counts[:rem] += 1

    print('counts:', counts)
else:
    sendbuf = None
    counts = np.empty(comm.Get_size(), dtype='i')

# Scatter the data
# First we broadcast the counts to all processes
comm.Bcast(counts, root=0)

# Otherwise the recvbuf will have the same size as the sendbuf
recvbuf = np.empty(counts[comm.Get_rank()], dtype='i')

comm.Scatterv([sendbuf, counts], recvbuf, root=0)

print('Rank:', comm.Get_rank(), 'recvbuf:', recvbuf)

