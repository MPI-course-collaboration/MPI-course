#include <stdio.h>
#include "mpi.h"


void exchange(MPI_Comm comm, int* pup_send, int* pdn_send,
              int up_neigh, int dn_neigh)
{
    // Implement data exchange here

    return;
}


void setup_mpi(MPI_Comm* pcomm, int* psize, int* prank)
{
    // Implement base communicator here
    
    return;
}

void shutdown_mpi()
{
  //Implement shutdown of MPI library  
    
  return;
}


int main(int argc, char **argv)
{
    int world_size, world_rank;
    int up_neigh, dn_neigh;
   
    int up_send, dn_send;
    int up_sum, dn_sum;
    
    MPI_Comm my_world;
    
    setup_mpi(&my_world, &world_size, &world_rank);
    
    printf("I am rank %i out of %i!\n", world_rank, world_size);
    
    // Implement neighbours here
    up_neigh =
    dn_neigh =
    
    printf("I'm %i my neighbours are %i and %i\n", world_rank, dn_neigh, up_neigh);
    
    up_send = 1000 * world_rank;
    dn_send = world_rank;
    
    up_sum = 0;
    dn_sum = 0;
    
    // Implement the travel around the ring here
    exchange(my_world, &up_send, &dn_send, up_neigh, dn_neigh);
    up_sum += up_send;
    dn_sum += dn_send;

    
    printf("I am %i and accumulated %i and %i\n", world_rank, dn_sum, up_sum);
    
    shutdown_mpi();
}
