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

  ! setting up an MPI derived data type
  Call MPI_Get_address(my_values%realpart, start_address, merror)
  Call MPI_Get_address(my_values%intpart,  secnd_address, merror)

  bleng = 1

  displ(1) = 0
  displ(2) = secnd_address - start_address

  types(1) = MPI_double_precision
  types(2) = MPI_integer

  print *,"On rank", my_rank," displacements are:", displ

  Call MPI_Type_create_struct(nb_entries, bleng, displ, types, ri_mpitype, &
       merror)
  Call MPI_Type_commit( ri_mpitype, merror)

  If (my_rank == 1) then
     Call MPI_Send(my_values, 1, ri_mpitype, 0, 0, MPI_Comm_world, merror)
  elseif (my_rank == 0) then
     Call MPI_Recv(reduced_values, 1, ri_mpitype, 1, 0, MPI_comm_world, &
          mstatus, merror)
     print *,"On rank", my_rank," received value: ", reduced_values
  endif


  Call MPI_op_create(addmax_ri, .true., ri_addmax_mpiop, merror)

  Call MPI_Reduce(my_values, reduced_values, 1, ri_mpitype, &
       ri_addmax_mpiop, 0, MPI_Comm_world, merror)
  if (my_rank == 0) then
     print *,"On rank", my_rank," reduced_values after reduce: ", reduced_values
  endif

  Call MPI_Finalize(merror)

End Program ReductionTest


