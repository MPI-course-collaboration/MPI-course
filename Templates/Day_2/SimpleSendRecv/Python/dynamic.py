from mpi4py import MPI
import numpy as np

comm = MPI.COMM_WORLD
rank = comm.Get_rank()

N = 40_000_000   # size of data

if rank == 0:
    data = np.arange(N, dtype='d')  # preallocated array
    comm.Barrier()
    start = MPI.Wtime()
    comm.send(data, dest=1, tag=77)
    end = MPI.Wtime()
    print(f"Rank: {rank} send with Python object takes {end - start:.6f} seconds")
elif rank == 1:
    comm.Barrier()
    start = MPI.Wtime()
    data = comm.recv(source=0, tag=77)
    end = MPI.Wtime()
    print(f"Rank: {rank} recv with Python object takes {end - start:.6f} seconds")

