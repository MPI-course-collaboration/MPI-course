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
    counts = np.full(shape=comm.size, fill_value=base)
    counts[:rem] += 1
else:
    a, b = None, None
    counts = None

# Get local count (use lowercase scatter)

local_count = comm.scatter(counts, root=0)

# Create receiving buffers using counts
recvbuf_a = np.zeros(local_count)
recvbuf_b = np.zeros(local_count)

# Scatter a and b

comm.Scatterv([a, counts], recvbuf_a, root=0)
comm.Scatterv([b, counts], recvbuf_b, root=0)

# Compute local sum
local_sum = np.array([np.vdot(recvbuf_a, recvbuf_b)])

# Compute total sum via Reduce

total_sum = np.zeros(1)
comm.Reduce(local_sum, total_sum, op=MPI.SUM, root=0)

if comm.rank == 0:
    ref = np.vdot(a, b)
    diff = abs(total_sum[0] - ref)
    print(f'relative error: {diff / abs(ref):.3e}')
