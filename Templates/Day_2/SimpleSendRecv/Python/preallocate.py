from mpi4py import MPI
import numpy as np

comm = MPI.COMM_WORLD
rank = comm.Get_rank()

N = 40_000_000   # size of data

if rank == 0:
    data = np.arange(N, dtype='d')  # preallocated array
    comm.Barrier()
    start = MPI.Wtime()
    comm.Send([data, MPI.DOUBLE], dest=1, tag=11)
    end = MPI.Wtime()
    print(f"Rank: {rank} Send with NumPy buffer took {end - start:.6f} seconds")
elif rank == 1:
    data = np.empty(N, dtype='d')
    comm.Barrier()
    start = MPI.Wtime()
    comm.Recv([data, MPI.DOUBLE], source=0, tag=11)
    end = MPI.Wtime()
    print(f"Rank: {rank} Recv with NumPy buffer took {end - start:.6f} seconds")

