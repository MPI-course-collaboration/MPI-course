from mpi4py import MPI
import math
import sys

comm = MPI.COMM_WORLD

numprocs = comm.Get_size()
myrank = comm.Get_rank()

n = int(sys.argv[1])

if n <= 0:
    comm.Abort(-1)

starttime = MPI.Wtime()

# interval size (same for X and Y)
h = math.pi / float(n)

mysum = 0.0

# distribute work in the X axis
for i in range(myrank, n, numprocs):
    x = h * (i + 0.5)
    # regular integration in the Y axis
    for j in range(n):
        y = h * (j + 0.5)
        mysum += math.sin(x + y)

local_integral = h**2 * mysum

# reduction
integral = comm.reduce(local_integral, op=MPI.SUM, root=0)

endtime = MPI.Wtime()

if myrank == 0:
    print("Integral value is %e, Error is %e" % (integral, abs(integral - 0.0)))
    print("Time spent: %.2f sec" % (endtime-starttime))
