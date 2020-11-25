/*Material for the course:
An introduction to parallel programming using Message Passing with MPI
Author: Pedro Ojeda
*/
#include "mpi.h"
#include <stdio.h>
#include <stdlib.h>
int main(int argc, char *argv[])
{
int i, counts, myrank, numprocs, ierr, root;
float *recvbuf=NULL;
MPI_Init(&argc,&argv);
MPI_Comm_size(MPI_COMM_WORLD,&numprocs);
MPI_Comm_rank(MPI_COMM_WORLD,&myrank);

root = 0;
counts = 3; //nr. of elements to be sent/received

//initializing sending buffer
float sendbuf[4]={1.0*myrank,2.0*myrank,3.0*myrank,4.0*myrank};

//allocating receiving buffer: counts elements per rank
if( myrank == 0) recvbuf = malloc(counts * sizeof(float));

MPI_Reduce(sendbuf,recvbuf,counts,MPI_FLOAT,MPI_SUM,root,MPI_COMM_WORLD);

if (myrank == 0) { 
  printf("Array %.3f  %.3f  %.3f \n", recvbuf[0],recvbuf[1],recvbuf[2]);
  free(recvbuf);
}

MPI_Finalize();
return 0;
}
