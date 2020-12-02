from mpi4py import MPI
import numpy as np

comm = MPI.COMM_WORLD

myrank = comm.Get_rank()
numprocs = comm.Get_size()

if myrank == 0:

    # Initialize 1D arrays

    array_size = 123453
    a = np.random.rand(array_size)
    b = np.random.rand(array_size)

    # Compute counts and displacements

    ave, res = divmod(array_size, numprocs)
    counts = 
    displs = 
else:
    a, b = None, None
    counts, displs = None, None

# Get local count (use lowercase scatter)

local_count = comm.scatter(   , root=   )

# Create receiving buffers using counts

recvbuf_a = np.zeros(local_count)
recvbuf_b = np.zeros(local_count)

# Scatter a and b

comm.Scatterv([  ,   ,   ,   ],    , root=   )
comm.Scatterv([  ,   ,   ,   ],    , root=   )

# Compute local sum

local_sum = np.zeros(1)
local_sum[0] = np.vdot(recvbuf_a, recvbuf_b)

# Compute total sum via Reduce

total_sum = np.zeros(1)
comm.Reduce(   ,    , op=   , root=   )

if myrank == 0:
    ref = np.vdot(a,b)
    diff = abs(total_sum[0] - ref)
    print('relative error: {:.3e}'.format(diff / abs(ref)))
