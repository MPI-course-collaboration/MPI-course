Program Mpihello

  use mpi

  Implicit none

  Integer :: world_size, world_rank

  character(len=MPI_MAX_PROCESSOR_NAME) :: proc_name
  integer :: name_end

  Integer :: merror


  Call MPI_Init(merror)


  Call MPI_Comm_size(MPI_COMM_WORLD, world_size, merror)
  Call MPI_Comm_rank(MPI_Comm_WORLD, world_rank, merror)
  Call MPI_GET_PROCESSOR_NAME(PROC_NAME, NAME_END, MERROR)


  if (world_rank == 0) then     
     print *,"MPI_MAX_PROCESSOR_NAME: ",MPI_MAX_PROCESSOR_NAME
  endif

  Call MPI_Barrier(mpi_comm_world, merror)

  print *,"I am rank ", world_rank," out of", world_size

  Call MPI_Barrier(mpi_comm_world, merror)

  print *,"My name is ", proc_name(1:name_end), " and my rank is", world_rank

  Call MPI_Barrier(mpi_comm_world, merror)

  Call MPI_Finalize(merror)

end Program Mpihello
