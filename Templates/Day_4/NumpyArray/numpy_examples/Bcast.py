# Example of Bcast

import numpy as np
from mpi4py import MPI

comm = MPI.COMM_WORLD
rank = comm.Get_rank()
size = comm.Get_size()

if rank == 0:
    data = np.arange(10, dtype='i')
else:
    data = np.empty(10, dtype='i')

comm.Bcast(data, root=0)

print("Rank: ", rank, "has data: ", data)
