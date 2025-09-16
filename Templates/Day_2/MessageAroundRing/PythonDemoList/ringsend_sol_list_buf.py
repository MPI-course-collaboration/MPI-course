import sys
import mpi4py
from mpi4py import MPI

def exchange(comm, up_send, dn_send, up_neigh, dn_neigh):

    buf1 = bytearray(1<<20)
    buf2 = bytearray(1<<20)
    
    dn_req = comm.irecv(buf1, source=dn_neigh, tag=1)
    up_req = comm.irecv(buf2, source=up_neigh, tag=2)

    comm.send(up_send, dest=up_neigh, tag=1)
    comm.send(dn_send, dest=dn_neigh, tag=2)

    dn_recv = dn_req.wait()
    up_recv = up_req.wait()

    return dn_recv, up_recv


# main

vleng = 100000

my_world = MPI.COMM_WORLD

world_size = my_world.Get_size()
world_rank = my_world.Get_rank()

print("I am rank %d out of %d!" % (world_rank, world_size))

up_neigh = (world_rank + 1) % world_size
dn_neigh = (world_rank + world_size - 1) % world_size

print("I'm %d my neighbours are %d and %d" % (world_rank, dn_neigh, up_neigh))

up_send = [1000 * world_rank] * vleng
dn_send = [world_rank] * vleng

if (world_rank == 0):
    print('We are sending list of', vleng, 'elements')
    print('The object is', sys.getsizeof(up_send), 'bytes')
    print('Default buffersize', mpi4py.rc.irecv_bufsz, 'bytes')

up_sum = 0
dn_sum = 0

for i in range(world_size):
    up_send, dn_send = exchange(my_world, up_send, dn_send, up_neigh, dn_neigh)
    up_sum += up_send[vleng-1]
    dn_sum += dn_send[vleng-1]

print("I am %d and accumulated %d and %d" % (world_rank, dn_sum, up_sum))
