program Mpihello

  use mpi

  Implicit none

  Integer :: world_size, world_rank
  Integer :: ierr

  Call MPI_Init(ierr)

  Call MPI_Comm_size(MPI_COMM_WORLD, world_size, ierr)
  Call MPI_Comm_rank(MPI_Comm_WORLD, world_rank, ierr)

  print *,"I am rank ", world_rank," out of", world_size

end program Mpihello

