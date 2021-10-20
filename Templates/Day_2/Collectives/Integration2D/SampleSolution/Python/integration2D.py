from mpi4py import MPI
import math
import sys

comm = MPI.COMM_WORLD

numprocs = comm.Get_size()
myrank = comm.Get_rank()

if myrank == 0:
    n = int(sys.argv[1])
else:
    n = None

#broadcast n
n = comm.bcast(n, root=0)

if n <= 0:
    comm.Abort(-1)

#turn on the stop watch
starttime = MPI.Wtime()

#calculate the interval size, same for X and Y
h = math.pi / float(n)

mysum = 0.0

#distribute work in the X axis
for i in range(myrank, n, numprocs):
    x = h * (i + 0.5)
    #do regular integration in the Y axis
    for j in range(n):
        y = h * (j + 0.5)
        mysum += math.sin(x + y)

local_integral = h**2 * mysum

#do the reduction
integral = comm.reduce(local_integral, op=MPI.SUM, root=0)

#turn off the stop watch
endtime = MPI.Wtime()

#print results on the root rank
if myrank == 0:
    print("Integral value is %.18f, Error is %.18f" % (integral, abs(integral - 0.0)))
    print("Time for loop and reduce is %.16f seconds" % (endtime-starttime))
