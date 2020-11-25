/*Material for the course:
An introduction to parallel programming using Message Passing with MPI
Author: Pedro Ojeda
*/
#include "mpi.h"
#include <stdio.h>
#include <stdlib.h>
int main(int argc, char *argv[])
{
int i, counts, size_sendbuf, myrank, numprocs, ierr, root;
float *sendbuf=NULL;
float recvbuf[4];
MPI_Init(&argc,&argv);
MPI_Comm_size(MPI_COMM_WORLD,&numprocs);
MPI_Comm_rank(MPI_COMM_WORLD,&myrank);

root = 0;
counts = 3; //nr. of elements to be sent/received
size_sendbuf = counts * numprocs; //size receiving buffer
//allocating sending buffer: counts elements per rank
if( myrank == 0) {
  sendbuf = malloc(size_sendbuf * sizeof(float));
  for( i = 0; i < size_sendbuf; i++)       
     sendbuf[i] = 1.0*i;
}

MPI_Scatter(sendbuf,counts,MPI_FLOAT,recvbuf,counts,MPI_FLOAT,root,MPI_COMM_WORLD);

printf("My rank= %d Array = %.3f %.3f %.3f %.3f \n",myrank,recvbuf[0],recvbuf[1],recvbuf[2],recvbuf[3]);

if( myrank == 0) {
  free(sendbuf);
}

MPI_Finalize();
return 0;
}
