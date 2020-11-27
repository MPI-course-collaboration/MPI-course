Program RingSend

  use mpi

  Implicit none

  Integer :: world_size, world_rank
  Integer :: up_neigh, dn_neigh
  Integer :: up_send, dn_send
  Integer :: up_sum, dn_sum
  Integer :: my_world

  Integer :: i_round

  Call setup_mpi(my_world, world_size, world_rank)

  print *,"I'm", world_rank, " out of", world_size 

  up_neigh = mod(world_rank+1, world_size)
  dn_neigh = mod(world_rank + world_size -1 , world_size)

  print *,"I'm", world_rank, " my neighbours are", dn_neigh, up_neigh

  up_send = 1000 * world_rank
  dn_send = world_rank

  up_sum = 0
  dn_sum = 0

  Do i_round = 1, world_size
     
     Call exchange(my_world, up_send, dn_send, up_neigh, dn_neigh)
     up_sum=up_sum + up_send
     dn_sum=dn_sum + dn_send
  Enddo

  print *, "I'm", world_rank, " and accumulated", up_sum, dn_sum

  Call shutdown_mpi()

contains

  Subroutine exchange(comm, up_send, dn_send, up_neigh, dn_neigh)
    integer, intent(in) :: comm
    integer, intent(inout) :: up_send, dn_send
    integer, intent(in) :: up_neigh, dn_neigh

    integer :: dn_recv, up_recv
    integer :: merror

    integer :: dn_req, up_req

    Call MPI_Irecv(dn_recv, 1, MPI_INTEGER, dn_neigh, 1, comm, dn_req, merror)
    Call MPI_Irecv(up_recv, 1, MPI_INTEGER, up_neigh, 2, comm, up_req, merror)

    Call MPI_Send(up_send, 1, MPI_INTEGER, up_neigh, 1, comm, merror)
    Call MPI_Send(dn_send, 1, MPI_INTEGER, dn_neigh, 2, comm, merror)

    Call MPI_Wait(dn_req, MPI_STATUS_IGNORE, merror)
    Call MPI_Wait(up_req, MPI_STATUS_IGNORE, merror)

    up_send = dn_recv
    dn_send = up_recv

  end Subroutine exchange

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  Subroutine setup_mpi(Comm, size, rank)

    integer, intent(out) :: comm
    integer, intent(out) :: size, rank
    Integer :: merror

    Call MPI_Init(merror)

    comm=MPI_COMM_WORLD

    Call MPI_Comm_size(comm, size, merror)
    Call MPI_Comm_rank(comm, rank, merror)

  End Subroutine setup_mpi

  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  Subroutine shutdown_mpi()

    integer :: merror

    Call MPI_Finalize(merror)

  end Subroutine shutdown_mpi

End Program RingSend
