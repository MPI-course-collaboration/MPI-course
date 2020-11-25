/*Material for the course:
An introduction to parallel programming using Message Passing with MPI
Author: Pedro Ojeda
*/
#include "mpi.h"
#include <stdio.h>

int main(int argc, char *argv[])
{
int myrank, numprocs, ierr, alpha;

MPI_Init(&argc,&argv);
MPI_Comm_size(MPI_COMM_WORLD,&numprocs);
MPI_Comm_rank(MPI_COMM_WORLD,&myrank);

if (myrank == 0) {
  printf("Type some integer\n"); 
  scanf("%d", &alpha);
}

//broadcast the value of alpha
MPI_Bcast(&alpha, 1, MPI_INT, 0, MPI_COMM_WORLD);
printf("Value of alpha on each rank %d\n", alpha); 

MPI_Finalize();
return 0;
}
