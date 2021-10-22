from mpi4py import MPI
import time

comm = MPI.COMM_WORLD

myrank = comm.Get_rank()
numprocs = comm.Get_size()

# we use a smaller finval than in the C code
# since loop in python is not as efficient
finval = 10000000

t0 = time.time()

pi_square = 0.0

for i in range(myrank, finval, numprocs):
    pi_square += 1.0 / (float(i+1)**2)

if myrank > 0:
    comm.send(pi_square, dest=0, tag=myrank)
else:
    for source in range(1, numprocs):
        pi_square += comm.recv(source=source, tag=source)
    print("Pi^2 = {:.10f}".format(pi_square*6.0))
    print("Time spent: {:.2f} sec".format(time.time() - t0))
