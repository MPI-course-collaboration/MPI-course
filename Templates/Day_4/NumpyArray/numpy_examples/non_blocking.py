# Example non blocking Isend/Irecv
from mpi4py import MPI
import numpy as np

comm = MPI.COMM_WORLD

if comm.rank == 0:
    data = np.arange(10, dtype=np.float64)
    reqs = []
    for i in range(1, comm.size):
        reqs.append(comm.Isend(data, dest=i, tag=i))
    for req in reqs:
        req.Wait()
        print('process 0 sent:', data)
else:
    data = np.empty(10, dtype=np.float64)
    req = comm.Irecv(data, source=0, tag=comm.rank)
    req.Wait()
    print('process', comm.rank, 'received:', data)

    
