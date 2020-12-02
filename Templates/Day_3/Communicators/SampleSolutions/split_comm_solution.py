from mpi4py import MPI

comm = MPI.COMM_WORLD

old_rank = comm.Get_rank()
comm_size_world = comm.Get_size()

# sum up the global ranks into proc. 0
sum_world = comm.reduce(old_rank, op=MPI.SUM, root=0)

if old_rank == 0:
    print("Average in comm_world = %f." % (float(sum_world)/comm_size_world))

color = old_rank % 2   # create the even and odd colors

new_comm = comm.Split(color, old_rank)

# get the new ranks and the new size in the splitted group
new_rank = new_comm.Get_rank()
comm_size_split = new_comm.Get_size()

print("New rank: %d, old rank: %d." % (new_rank, old_rank))

# sum up the ranks into proc. 0 of each split group
sum_split = new_comm.reduce(new_rank, op=MPI.SUM, root=0)

if new_rank == 0:
    if color == 0:
        # print out avg. for the even group
        print("Average in the even world = %f." % (float(sum_split)/comm_size_split))
    else:
        # print out the avg. for the odd group
        print("Average in the odd world = %f." % (float(sum_split)/comm_size_split))

new_comm.Free()
