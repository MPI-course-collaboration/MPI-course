!Material for the course:
!An introduction to parallel programming using Message Passing with MPI
!Author: Pedro Ojeda
program main
use mpi
implicit none

integer myrank, numprocs, ierr

call MPI_INIT(ierr)
call MPI_COMM_RANK(MPI_COMM_WORLD, myrank, ierr)
call MPI_COMM_SIZE(MPI_COMM_WORLD, numprocs, ierr)

call MPI_Barrier(  MPI_COMM_WORLD, ierr)

call MPI_FINALIZE(ierr)

end
