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

  ! Implement neighbours here
  up_neigh = 
  dn_neigh = 

  print *,"I'm", world_rank, " my neighbours are", dn_neigh, up_neigh

  up_send = 1000 * world_rank
  dn_send = world_rank

  up_sum = 0
  dn_sum = 0

  ! Implement the travel around the ring here
   
  Call exchange(my_world, up_send, dn_send, up_neigh, dn_neigh)
  up_sum=up_sum + up_send
  dn_sum=dn_sum + dn_send


  print *, "I'm", world_rank, " and accumulated", up_sum, dn_sum

  Call shutdown_mpi()

contains

  Subroutine exchange(comm, up_send, dn_send, up_neigh, dn_neigh)
    integer, intent(in) :: comm
    integer, intent(inout) :: up_send, dn_send
    integer, intent(in) :: up_neigh, dn_neigh

    ! Implement data exhcange here

  end Subroutine exchange

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  Subroutine setup_mpi(Comm, size, rank)

    integer, intent(out) :: comm
    integer, intent(out) :: size, rank
    Integer :: merror

    ! Implement base communicator here


  End Subroutine setup_mpi

  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  Subroutine shutdown_mpi()

    integer :: merror

    ! Implement shutdown of MPI library

  end Subroutine shutdown_mpi

End Program RingSend
