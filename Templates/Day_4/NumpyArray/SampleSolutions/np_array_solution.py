from mpi4py import MPI
import numpy as np

comm = MPI.COMM_WORLD

myrank = comm.Get_rank()
numprocs = comm.Get_size()

if myrank == 0:
    array_size = 123453
    a = np.random.rand(array_size)
    b = np.random.rand(array_size)

    ave, res = divmod(array_size, numprocs)
    counts = [ave + 1 if p < res else ave for p in range(numprocs)]
    displs = [sum(counts[:p]) for p in range(numprocs)]
else:
    a, b = None, None
    counts, displs = None, None

local_count = comm.scatter(counts, root=0)

recvbuf_a = np.zeros(local_count)
recvbuf_b = np.zeros(local_count)

comm.Scatterv([a, counts, displs, MPI.DOUBLE], recvbuf_a, root=0)
comm.Scatterv([b, counts, displs, MPI.DOUBLE], recvbuf_b, root=0)

local_sum = np.zeros(1)
local_sum[0] = np.vdot(recvbuf_a, recvbuf_b)

total_sum = np.zeros(1)
comm.Reduce(local_sum, total_sum, op=MPI.SUM, root=0)

if myrank == 0:
    ref = np.vdot(a,b)
    diff = abs(total_sum[0] - ref)
    print('relative error: {:.3e}'.format(diff / abs(ref)))
