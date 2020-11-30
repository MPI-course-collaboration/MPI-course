#include <stdio.h>
#include "mpi.h"


int main(int argc, char **argv)
{
  MPI_Init(&argc, &argv); // alt.: NULL,NULL
  
  int size, rank;

  MPI_Comm_size(MPI_COMM_WORLD, &size);
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);

  printf("I am rank %i out of %i!\n", rank, size);

    

  MPI_Finalize();

  return 0;
}

