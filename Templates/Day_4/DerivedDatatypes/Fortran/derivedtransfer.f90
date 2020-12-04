Program ReductionTest

  use mpi
  use realint_pair

  Implicit None

  type(ri_pair) :: my_values, reduced_values

  Integer :: my_rank, world_size
  Integer(kind=mpi_address_kind) :: start_address, secnd_address

  Integer, parameter :: nb_entries=2
  Integer, dimension(nb_entries) :: bleng, types
  Integer(kind=mpi_address_kind),dimension(nb_entries) :: displ

  Integer :: ri_mpitype, ri_addmax_mpiop

  Integer, dimension(Mpi_Status_size) :: mstatus
  Integer :: merror

  Call MPI_Init(merror)

  Call MPI_Comm_rank(MPI_Comm_world, my_rank, merror)
  Call MPI_Comm_size(MPI_Comm_world, world_size, merror)

  my_values%realpart = my_rank
  my_values%intpart  = my_rank

  print *,"On rank", my_rank," my_values contains", my_values

  
  ! implement a datatype to send my_values from rank 1 to rank 0


  If (my_rank == 1) then
     Call MPI_Send(my_values, 1, ri_mpitype, 0, 0, MPI_Comm_world, merror)
  elseif (my_rank == 0) then
     Call MPI_Recv(reduced_values, 1, ri_mpitype, 1, 0, MPI_comm_world, &
          mstatus, merror)
     print *,"On rank", my_rank," received value: ", reduced_values
  endif

  Call MPI_Finalize(merror)

End Program ReductionTest


