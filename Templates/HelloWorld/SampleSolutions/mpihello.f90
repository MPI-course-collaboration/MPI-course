Program Mpihello

  use mpi

  Implicit none

  Integer :: world_size, world_rank
  Integer :: merror


  Call MPI_Init(merror)


  Call MPI_Comm_size(MPI_COMM_WORLD, world_size, merror)
  Call MPI_Comm_rank(MPI_Comm_WORLD, world_rank, merror)

  print *,"I am rank ", world_rank," out of", world_size

end Program Mpihello
