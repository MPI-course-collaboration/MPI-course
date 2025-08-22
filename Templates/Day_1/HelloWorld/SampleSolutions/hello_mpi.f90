program Mpihello

  use mpi

  Implicit none

  Integer :: world_size, world_rank
  Integer :: my_world, ierr

  Call MPI_Init(ierr)

  my_world = MPI_COMM_WORLD

  Call MPI_Comm_size(my_world, world_size, ierr)
  Call MPI_Comm_rank(my_world, world_rank, ierr)

  print *,"I am rank ", world_rank," out of", world_size
 
  Call MPI_Finalize(ierr)
end program Mpihello

