# Example of Scatterv and Reduce for partial and total sums
from mpi4py import MPI
import numpy as np

comm = MPI.COMM_WORLD

if comm.rank == 0:
    sendbuf = np.arange(100, dtype='i')  # Data to scatter
    # Determine the counts
    base, rem = divmod(sendbuf.size, comm.size)
    counts = np.full(shape=comm.size, fill_value=base, dtype='i')
    counts[:rem] += 1

    print('counts:', counts)
else:
    sendbuf = None
    counts = np.empty(comm.size, dtype='i')

# Broadcast counts and displacements to all ranks
comm.Bcast(counts, root=0)

# Allocate recvbuf based on counts for the current rank
recvbuf = np.empty(counts[comm.rank], dtype='i')

# Scatter the data
comm.Scatterv([sendbuf, counts], recvbuf, root=0)
print(f'Rank {comm.rank} received data: {recvbuf}')

# Compute the partial sum on each comm.rank
partial_sum = np.sum(recvbuf)  # This is a scalar value
print(f'Rank {comm.rank} has partial sum: {partial_sum}')

# Use Reduce to compute the total sum across all ranks
total_sum = np.zeros_like(partial_sum, shape=1)
comm.Reduce(partial_sum, total_sum, op=MPI.SUM, root=0)

if comm.rank == 0:
    print('Total sum of all elements:', total_sum[0])
