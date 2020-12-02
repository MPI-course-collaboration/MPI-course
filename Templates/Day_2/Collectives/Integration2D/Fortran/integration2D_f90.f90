!Material for the course:
!An introduction to parallel programming using Message Passing with MPI
!Source code adapted from W. Gropp, E. Lusk, and A. Skjellum
program main
use mpi


double precision PI 
parameter (PI = 3.141592653589793238462643d0)
double precision local_integral, integral, h, sum, x, y, f, a 
integer n, myrank, numprocs, i, j, ierr
CHARACTER(100) :: nchar

!variables for timing the code
double precision starttime, endtime

call MPI_INIT(ierr)
call MPI_COMM_RANK(MPI_COMM_WORLD, myrank, ierr)
call MPI_COMM_SIZE(MPI_COMM_WORLD, numprocs, ierr)
 
if (myrank .eq. 0) then
     call get_command_argument(1,nchar)
     read(nchar,*) n
endif 

!broadcast n
call MPI_BCAST(n, 1, MPI_INTEGER, 0, MPI_COMM_WORLD, ierr)
if(n .le. 0) then
    CALL MPI_Abort(MPI_COMM_WORLD, -1, ierr)
else
     !turn on the stop watch
     starttime = MPI_WTIME()

     !calculate the interval size, same for X and Y
     !integration region 0 < x < Pi, 0 < y < Pi
     h = 1.0d0*PI/n
     sum = 0.0d0
     !distribute work in the X axis
     do i = myrank+1, n, numprocs
        x = h * (dble(i) - 0.5d0)
        !do regular integration in the Y axis
        do j = 1, n
            y = h * (dble(j) - 0.5d0)
            sum = sum + sin( x + y )
        enddo
     enddo
     !multiply by the area element h * h
     local_integral = h * h * sum

    !do the reduction
    call MPI_REDUCE(local_integral, integral, 1, MPI_DOUBLE_PRECISION, MPI_SUM, 0, MPI_COMM_WORLD, ierr)

    !turn off the stop watch
    endtime = MPI_WTIME()

    !print results on the root rank
    if(myrank .eq. 0) then
         print *, 'Integral value is', integral, 'Error is', abs(integral-0.0d0) 
         print *, 'Time for loop and MPI_REDUCE', endtime-starttime, 'seconds'
    endif
endif
call MPI_FINALIZE(ierr)
end
