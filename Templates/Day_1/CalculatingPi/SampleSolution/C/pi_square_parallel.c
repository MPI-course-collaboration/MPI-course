/*Material for the course:
An introduction to parallel programming using Message Passing with MPI
*/
#include "mpi.h"
#include <stdio.h>
#include <math.h>
#define min(a,b) (((a)<(b))?(a):(b))

int main(int argc, char *argv[])
{
    int finval = 10000;    
    double pi_square = 0.0;
    double factor;
    int i;

    //MPI variables
    int world_rank, world_size;
    MPI_Status stat;

    int my_start, my_fin, my_elements;
    double recvbuffer;

    MPI_Init(&argc, &argv);
    MPI_Comm_size(MPI_COMM_WORLD, &world_size);
    MPI_Comm_rank(MPI_COMM_WORLD, &world_rank);

    //calculating typical workload
    my_elements = (finval + world_size -1)/world_size;

    
    // workshare, calculating start point and end point 
    my_start = 1 + my_elements * world_rank;
    my_fin   = min(finval, my_elements * (world_rank + 1));
  
    for (i = my_start; i <= my_fin; i ++) {
       factor = i;
       pi_square = pi_square + 1.0/(factor * factor);
    }

    // communicate results
    // ranks 1 and higher send to rank 0, rank 0 collects
    if (world_rank > 0) {
       MPI_Send(&pi_square, 1, MPI_DOUBLE, 0, 1, MPI_COMM_WORLD);
    } else {
       for(i = 1; i<= world_size-1; i++) {
          MPI_Recv(&recvbuffer, 1, MPI_DOUBLE, i, 1, MPI_COMM_WORLD, &stat);
          pi_square = pi_square + recvbuffer;
       }
    
       printf("Pi**2 = %.18f \n", 6.0 * pi_square);
  
    }

    MPI_Finalize();
    return 0;
}
