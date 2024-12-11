from mpi4py import MPI
import numpy as np

comm = MPI.COMM_WORLD
rank = comm.Get_rank()
size = comm.Get_size()

if rank == 0:
    data = np.arange(10, dtype=np.float64)
    for i in range(1, size):
        # Using [data, size, type] to send a buffer of data
        comm.Send([data[2:5], 2, MPI.DOUBLE], dest=i, tag=i)
        print(f"Rank 0 sent data to rank {i}")

else:
    data = np.empty(10, dtype=np.float64)
    # Using [data, size, type] to receive a buffer of data
    comm.Recv([data[2:5], 2, MPI.DOUBLE], source=0, tag=rank)
        
    print(f"Rank {rank} received data from rank 0: {data}")

print(f"Rank {rank} has data: {data}")