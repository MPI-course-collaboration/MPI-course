from mpi4py import MPI


def exchange(comm, up_send, dn_send, up_neigh, dn_neigh):

    dn_recv = comm.irecv(source=dn_neigh, tag=1)
    up_recv = comm.irecv(source=up_neigh, tag=2)

    comm.send(up_send, dest=up_neigh, tag=1)
    comm.send(dn_send, dest=dn_neigh, tag=2)

    return dn_recv, up_recv


# main

my_world = MPI.COMM_WORLD

world_size = my_world.Get_size()
world_rank = my_world.Get_rank()

print("I am rank %d out of %d!" % (world_rank, world_size))

up_neigh = (world_rank + 1) % world_size
dn_neigh = (world_rank + world_size - 1) % world_size

print("I'm %d my neighbours are %d and %d" % (world_rank, dn_neigh, up_neigh))

up_send = 1000 * world_rank
dn_send = world_rank

up_sum = 0
dn_sum = 0

for i in range(world_size):
    up_send, dn_send = exchange(my_world, up_send, dn_send, up_neigh, dn_neigh)
    up_sum += up_send
    dn_sum += dn_send

print("I am %d and accumulated %d and %d" % (world_rank, dn_sum, up_sum))
