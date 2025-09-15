# Simple example of Reduce
from mpi4py import MPI
import numpy as np

comm = MPI.COMM_WORLD

data = np.array([1, 2, 3, 4], dtype=np.float64) * (comm.rank + 1)
result = np.empty(4, dtype=np.float64)

# Print partial data
print(f"Rank {comm.rank} has data: {data}")

comm.Reduce(data, result, op=MPI.SUM, root=0)

if comm.rank == 0:
    print(f"Rank {comm.rank} has data after reduce: {result}")

