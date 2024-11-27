/*Material for the course:
An introduction to parallel programming using Message Passing with MPI
Source code adapted from W. Gropp, E. Lusk, and A. Skjellum
*/
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

int main(int argc, char *argv[])
{
    double PI = 3.141592653589793238462643;
    int n, i, j;
    double integral, h, sum, x, y;


    //variables for timing the code
    clock_t starttime, endtime;

          //get the command line argument value
          n = atoi( argv[1] );

          //turn on the stop watch
          starttime = clock();

          //calculate the interval size, same for X and Y
          //integration region 0 < x < Pi, 0 < y < Pi
          h = 1.0*PI / (double) n; 
          sum = 0.0; 
          //distribute work in the X axis
          for (i = 1; i <= n; i += 1) {
               x = h * ( (double)i - 0.5);
               //do regular integration in the Y axis
               for (j = 1; j<= n ; j++) {
                    y = h * ( (double)j - 0.5);
                    sum += sin( x + y);
               }
          } 
          //multiply by the area element h * h
          integral = h * h * sum;

          //turn off the stop watch
          endtime = clock();

          //print results on the root rank
              printf("Integral value is %.18f, Error is %.18f\n", integral, fabs(integral - 0.0));
              printf("Time for loop %.16f seconds\n", ((double) (endtime-starttime))/CLOCKS_PER_SEC);

    return 0;
}
