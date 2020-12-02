from mpi4py import MPI

# we use a smaller finval than in the C code
# since loop in python is not as efficient
finval = 1000

pi_square = 0.0

my_world = MPI.COMM_WORLD
world_size = my_world.Get_size()
world_rank = my_world.Get_rank()

# calculate typical workload
my_elements = (finval + world_size -1)//world_size

my_start = my_elements * world_rank
my_fin   = min(finval, my_elements * (world_rank + 1 ))

print (world_rank, my_start, my_fin)

for i in range(my_start, my_fin):
    pi_square += 1.0 / (float(i+1)**2)

if world_rank > 0:
    my_world.send(pi_square, dest=0 )
else:
    for i in range(1, world_size):
        recv_buffer = my_world.recv(source=0)
        pi_square += recv_buffer

    print("Pi^2 = {:.10f}".format(pi_square*6.0))
