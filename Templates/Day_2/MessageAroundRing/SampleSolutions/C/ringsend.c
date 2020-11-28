#include <stdio.h>
#include "mpi.h"


void exchange(MPI_Comm comm, int* pup_send, int* pdn_send,
              int up_neigh, int dn_neigh)
{
    int dn_recv, up_recv;
    MPI_Request dn_req, up_req;
    MPI_Status stat;
    
    MPI_Irecv(&dn_recv, 1, MPI_INT, dn_neigh, 1, comm, &dn_req);
    MPI_Irecv(&up_recv, 1, MPI_INT, up_neigh, 2, comm, &up_req);
    
    MPI_Send(pup_send, 1, MPI_INT, up_neigh, 1, comm);
    MPI_Send(pdn_send, 1, MPI_INT, dn_neigh, 2, comm);
    
    MPI_Wait(&dn_req, &stat);
    MPI_Wait(&up_req, &stat);
    
    *pup_send = dn_recv;
    *pdn_send = up_recv;
    
    return;
}


void setup_mpi(MPI_Comm* pcomm, int* psize, int* prank)
{
    MPI_Init(NULL, NULL);
    
    *pcomm = MPI_COMM_WORLD;
    
    MPI_Comm_size(*pcomm, psize);
    MPI_Comm_rank(*pcomm, prank);
    
    return;
}

void shutdown_mpi()
{
    MPI_Finalize();
    
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
    
    up_neigh = (world_rank + 1)              % world_size;
    dn_neigh = (world_rank + world_size - 1) % world_size;
    
    printf("I'm %i my neighbours are %i and %i\n", world_rank, dn_neigh, up_neigh);
    
    up_send = 1000 * world_rank;
    dn_send = world_rank;
    
    up_sum = 0;
    dn_sum = 0;
    
    for (int i = 0; i < world_size; i++ )
    {
        exchange(my_world, &up_send, &dn_send, up_neigh, dn_neigh);
        up_sum += up_send;
        dn_sum += dn_send;
    }
    
    printf("I am %i and accumulated %i and %i\n", world_rank, dn_sum, up_sum);
    
    shutdown_mpi();
}
