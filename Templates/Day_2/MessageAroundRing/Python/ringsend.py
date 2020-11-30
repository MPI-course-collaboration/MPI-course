from mpi4py import MPI


def exchange(comm, up_send, dn_send, up_neigh, dn_neigh):


    #Implement data exchange here

    return dn_recv, up_recv


# main

# Implement base communicator here

world_size = 
world_rank = 

print("I am rank %d out of %d!" % (world_rank, world_size))

# Implement neighbours here

up_neigh = 
dn_neigh = 

print("I'm %d my neighbours are %d and %d" % (world_rank, dn_neigh, up_neigh))

up_send = 1000 * world_rank
dn_send = world_rank

up_sum = 0
dn_sum = 0

# Implement the travel around the ring here

up_send, dn_send = exchange(my_world, up_send, dn_send, up_neigh, dn_neigh)
up_sum += up_send
dn_sum += dn_send

print("I am %d and accumulated %d and %d" % (world_rank, dn_sum, up_sum))
