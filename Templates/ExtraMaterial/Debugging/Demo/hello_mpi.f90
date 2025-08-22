Program Mpihello

  use mpi

  Implicit none

  Integer :: world_size, world_rank

  Character(len=MPI_MAX_PROCESSOR_NAME) :: proc_name
  Integer :: name_end

  Integer :: ierr, my_world


  Call MPI_Init(ierr)

  my_world = MPI_COMM_WORLD

  Call MPI_Comm_size(my_world, world_size, ierr)
  Call MPI_Comm_rank(my_world, world_rank, ierr)
  Call MPI_Get_processor_name(proc_name, name_end, ierr)


  print *,"I am rank ", world_rank," out of", world_size

  Call MPI_Barrier(my_world, ierr)

  print *,"My name is ", proc_name(1:name_end), " and my rank is", world_rank

  Call MPI_Barrier(my_world, ierr)

  Call MPI_Finalize(ierr)

end Program Mpihello
