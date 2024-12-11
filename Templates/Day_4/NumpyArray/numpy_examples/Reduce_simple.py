# Simple example of Reduce
from mpi4py import MPI
import numpy as np

comm = MPI.COMM_WORLD
rank = comm.Get_rank()
size = comm.Get_size()

data = np.array([1, 2, 3, 4], dtype=np.float64) * (rank + 1)
result = np.empty(4, dtype=np.float64)

# Print partial data
print(f"Rank {rank} has data: {data}")

comm.Reduce(data, result, op=MPI.SUM, root=0)

if rank == 0:
    print(f"Rank {rank} has data after reduce: {result}")

