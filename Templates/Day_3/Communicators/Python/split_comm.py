from mpi4py import MPI

comm = MPI.COMM_WORLD

old_rank = comm.Get_rank()
comm_size_world = comm.Get_size()

# Complete the reduction command to sum up the global ranks into proc. 0

sum_world = comm.reduce(   , op=   , root=   )

if old_rank == 0:
    print("Average in comm_world = %f." % (float(sum_world)/comm_size_world))

# Create the even and odd colors

color = 

# Split the COMM_WORLD based on the color and keep the ordering as in the original group

new_comm = comm.Split(    ,    )

# Get the new ranks and the new size in the splitted group

new_rank = new_comm.      () 

comm_size_split = new_comm.      ()

print("New rank: %d, old rank: %d." % (new_rank, old_rank))

# Complete the reduction command to sum up the ranks into proc. 0 of each split group

sum_split = new_comm.reduce(   , op=   , root=   )

if new_rank == 0:
    if color == 0:
        # print out avg. for the even group
        print("Average in the even world = %f." % (float(sum_split)/comm_size_split))
    else:
        # print out the avg. for the odd group
        print("Average in the odd world = %f." % (float(sum_split)/comm_size_split))

# Don't forget to free up the new communicator once you don't need it anymore

new_comm.   ()
