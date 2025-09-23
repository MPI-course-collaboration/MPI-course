from mpi4py import MPI

comm = MPI.COMM_WORLD

myrank = comm.Get_rank()
numprocs = comm.Get_size()

finval = 10000000

t0 = MPI.Wtime()

my_elements = (finval + numprocs - 1) // numprocs
my_start = my_elements * myrank
my_fin = min(finval, my_elements * (myrank + 1))

pi_square = 0.0
for i in range(my_start, my_fin):
    pi_square += 1.0 / float(i + 1)**2

if myrank > 0:
    comm.send(pi_square, dest=0, tag=myrank)
else:
    for source in range(1, numprocs):
        pi_square += comm.recv(source=source, tag=source)
    print("Pi^2 = {:.10f}".format(pi_square*6.0))
    print("Time spent: {:.2f} sec".format(MPI.Wtime() - t0))
