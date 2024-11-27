!Material for the course:
!An introduction to parallel programming using Message Passing with MPI
!Source code adapted from W. Gropp, E. Lusk, and A. Skjellum
program main

double precision PI 
parameter (PI = 3.141592653589793238462643d0)
double precision integral, h, sum, x, y, f, a 
integer n, i, j
CHARACTER(100) :: nchar

!variables for timing the code
double precision starttime, endtime
 
!The number of bins is typed by the user
     call get_command_argument(1,nchar)
     read(nchar,*) n

     !turn on the stop watch
     call cpu_time(starttime)

     !calculate the interval size, same for X and Y
     !integration region 0 < x < Pi, 0 < y < Pi
     h = 1.0d0*PI/n
     sum = 0.0d0
     !work in the X axis
     do i = 1, n
        x = h * (dble(i) - 0.5d0)
        !do regular integration in the Y axis
        do j = 1, n
            y = h * (dble(j) - 0.5d0)
            sum = sum + sin( x + y )
        enddo
     enddo
     !multiply by the area element h * h
     integral = h * h * sum

    !turn off the stop watch
    call cpu_time(endtime)

    !print results
         print *, 'Integral value is', integral, 'Error is', abs(integral-0.0d0) 
         print *, 'Time for loop is', endtime-starttime, 'seconds'
end
