Program Mpihello

  use mpi

  Implicit none

  Integer :: world_size, world_rank

  character(len=MPI_MAX_PROCESSOR_NAME) :: proc_name
  integer :: name_end

  Integer :: ierr


  Call MPI_Init(ierr)


  Call MPI_Comm_size(MPI_COMM_WORLD, world_size, ierr)
  Call MPI_Comm_rank(MPI_Comm_WORLD, world_rank, ierr)
  Call MPI_Get_processor_name(proc_name, name_end, ierr)


  print *,"I am rank ", world_rank," out of", world_size

  Call MPI_Barrier(mpi_comm_world, ierr)

  print *,"My name is ", proc_name(1:name_end), " and my rank is", world_rank

  Call MPI_Barrier(mpi_comm_world, ierr)

  Call MPI_Finalize(ierr)

end Program Mpihello
