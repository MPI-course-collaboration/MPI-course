#include <stdio.h>
#include "mpi.h"


int main(int argc, char **argv)
{
  MPI_Init(&argc, &argv); // alt.: NULL,NULL
  
  int size, rank;

  // Copy the communicator
  MPI_COMM my_world = MPI_COMM_WORLD;

  MPI_Comm_size(my_world, &size);
  MPI_Comm_rank(my_world, &rank);

  printf("I am rank %i out of %i!\n", rank, size);

  MPI_Finalize();

  return 0;
}

