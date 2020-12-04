#include <stdio.h>
#include <math.h>
#include "mpi.h"
#include "realint_pair.h"


void setup_mpi(MPI_Comm* pcomm, int* psize, int* prank)
{
    MPI_Init(NULL, NULL);
    
    *pcomm = MPI_COMM_WORLD;
    
    MPI_Comm_size(*pcomm, psize);
    MPI_Comm_rank(*pcomm, prank);
    
    return;
}


int main(int argc, char **argv) 
{

  // setting up MPI

  MPI_Comm my_world;
  int my_rank, world_size;

  setup_mpi(&my_world, &world_size, &my_rank);

  ri_pair my_values, received_values, reduced_values;

  my_values.rpart = my_rank;
  my_values.ipart = my_rank;

  printf("On rank %d my values are: (%f, %d)\n", 
	 my_rank, my_values);
 
  // implement a datatype to send my_values from rank 1 to rank 0
  
  if (my_rank == 0)
    {
      MPI_Status stat;
      MPI_Recv(&received_values, 1, ri_mpitype, 1, 1, my_world, &stat);
      printf("On rank 0 we received from 1: (%f, %d)\n", 
	     received_values);
    }
  else if(my_rank == 1)
    {
      MPI_Send(&my_values, 1, ri_mpitype, 0, 1, my_world);
    }

  MPI_Finalize();

  return 0;
}

