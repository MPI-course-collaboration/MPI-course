from mpi4py import MPI
import numpy as np

comm = MPI.COMM_WORLD
rank = comm.Get_rank()
size = comm.Get_size()

if rank == 0:
    data = np.arange(10, dtype=np.float64)[::2].copy()
    for i in range(1, size):
        comm.Send(data, dest=i, tag=i)
        print(f"Rank 0 sent data to rank {i}")

else:
    data = np.empty(10, dtype=np.float64)
    status = MPI.Status()
    comm.Recv(data, source=0, tag=rank)
        
    print(f"Rank {rank} received data from rank 0: {data}")

print(f"Rank {rank} has data: {data}")

