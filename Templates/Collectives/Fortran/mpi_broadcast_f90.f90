!Material for the course:
!An introduction to parallel programming using Message Passing with MPI
!Author: Pedro Ojeda
program main
use mpi
implicit none

integer myrank, numprocs, ierr, alpha

call MPI_INIT(ierr)
call MPI_COMM_RANK(MPI_COMM_WORLD, myrank, ierr)
call MPI_COMM_SIZE(MPI_COMM_WORLD, numprocs, ierr)

if (myrank .eq. 0) then
  print *, 'Type some integer' 
  read(*,*) alpha 
endif 

!broadcast the value of alpha
call MPI_BCAST(alpha, 1, MPI_INTEGER, 0, MPI_COMM_WORLD, ierr)
print *, 'Value of alpha on each rank', alpha 

call MPI_FINALIZE(ierr)

end
