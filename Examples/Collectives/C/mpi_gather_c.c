/*Material for the course:
An introduction to parallel programming using Message Passing with MPI
Author: Pedro Ojeda
*/
#include "mpi.h"
#include <stdio.h>
#include <stdlib.h>
int main(int argc, char *argv[])
{
int i, counts, size_recvbuf, myrank, numprocs, ierr, root;
float *recvbuf=NULL;
MPI_Init(&argc,&argv);
MPI_Comm_size(MPI_COMM_WORLD,&numprocs);
MPI_Comm_rank(MPI_COMM_WORLD,&myrank);

root = 0;
counts = 3; //nr. of elements to be sent/received
size_recvbuf = counts * numprocs; //size receiving buffer
//allocating receiving buffer: counts elements per rank
if( myrank == 0) recvbuf = malloc(size_recvbuf * sizeof(float));

//initializing sending buffer
float sendbuf[4]={1.0*myrank,2.0*myrank,3.0*myrank,4.0*myrank};
MPI_Gather(sendbuf,counts,MPI_FLOAT,recvbuf,counts,MPI_FLOAT,root,MPI_COMM_WORLD);

if (myrank == 0) { 
  for( i = 0; i < size_recvbuf; i++)       
     printf("Array %.3f \n", recvbuf[i]);

  free(recvbuf);
}

MPI_Finalize();
return 0;
}
