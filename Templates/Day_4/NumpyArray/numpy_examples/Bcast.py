# Example of Bcast

import numpy as np
from mpi4py import MPI

comm = MPI.COMM_WORLD

if comm.rank == 0:
    data = np.arange(10, dtype='i')
else:
    data = np.empty(10, dtype='i')

comm.Bcast(data, root=0)

print("Rank: ", comm.rank, "has data: ", data)
