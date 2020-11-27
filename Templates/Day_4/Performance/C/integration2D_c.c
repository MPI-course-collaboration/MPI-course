/*Material for the course:
An introduction to parallel programming using Message Passing with MPI
Source code adapted from W. Gropp, E. Lusk, and A. Skjellum
*/
#include "mpi.h"
#include <stdio.h>
#include <math.h>

int main(int argc, char *argv[])
{
    double PI = 3.141592653589793238462643;
    int n, myrank, numprocs, i, j;
    double local_integral, integral, h, sum, x, y;


    //variables for timing the code
    double starttime, endtime;

    MPI_Init(&argc, &argv);
    MPI_Comm_size(MPI_COMM_WORLD, &numprocs);
    MPI_Comm_rank(MPI_COMM_WORLD, &myrank);

    if (myrank == 0) {
          //get the command line argument value
          n = atoi( argv[1] );
    }

    //broadcast n
    MPI_Bcast(&n, 1, MPI_INT, 0, MPI_COMM_WORLD);
    if (n <= 0) { 
          MPI_Abort(MPI_COMM_WORLD, -1); }
    else {
          //turn on the stop watch
          starttime = MPI_Wtime();

          //calculate the interval size, same for X and Y
          h = 1.0*PI / (double) n; 
          sum = 0.0; 
          //distribute work in the X axis
          for (i = myrank + 1; i <= n; i += numprocs) {
               x = h * ( (double)i - 0.5);
               //do regular integration in the Y axis
               for (j = 1; j<= n ; j++) {
                    y = h * ( (double)j - 0.5);
                    sum += sin( x + y);
               }
          } 
          local_integral = h * sum;

          //do the reduction
          MPI_Reduce(&local_integral, &integral, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);

          //turn off the stop watch
          endtime = MPI_Wtime();

          //print results on the root rank
          if (myrank == 0) {
              printf("Integral value is %.18f, Error is %.18f\n", integral, fabs(integral - 0.0));
              printf("Time for loop and MPI_Reduce %.16f seconds\n", endtime-starttime);
          }
    }
    MPI_Finalize();
    return 0;
}
