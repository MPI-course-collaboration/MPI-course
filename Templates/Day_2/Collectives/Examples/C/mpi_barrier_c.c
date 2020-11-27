/*Material for the course:
An introduction to parallel programming using Message Passing with MPI
Author: Pedro Ojeda
*/
#include "mpi.h"
#include <stdio.h>

int main(int argc, char *argv[])
{
int myrank, numprocs, ierr;

MPI_Init(&argc,&argv);
MPI_Comm_size(MPI_COMM_WORLD,&numprocs);
MPI_Comm_rank(MPI_COMM_WORLD,&myrank);

ierr = MPI_Barrier(MPI_COMM_WORLD);

MPI_Finalize();
return 0;
}
