from mpi4py import MPI
import numpy as np

comm = MPI.COMM_WORLD

if comm.rank == 0:

    # Initialize 1D arrays
    array_size = 123453
    a = np.random.rand(array_size)
    b = np.random.rand(array_size)

    # Compute counts

    base, rem = divmod(array_size, comm.size)
    counts = 
else:
    a, b = None, None
    counts = None

# Get local count (use lowercase scatter)

local_count = comm.scatter(   , root=   )

# Create receiving buffers using counts
recvbuf_a = np.zeros(local_count)
recvbuf_b = np.zeros(local_count)

# Scatter a and b

comm.Scatterv([  ,   ],    , root=   )
comm.Scatterv([  ,   ],    , root=   )

# Compute local sum
local_sum = np.array([np.vdot(recvbuf_a, recvbuf_b)])

# Compute total sum via Reduce

total_sum = np.zeros(1)
comm.Reduce(   ,    , op=   , root=   )

if comm.rank == 0:
    ref = np.vdot(a, b)
    diff = abs(total_sum[0] - ref)
    print(f'relative error: {diff / abs(ref):.3e}')
