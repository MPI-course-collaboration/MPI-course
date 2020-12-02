!Material for the course:
!An introduction to parallel programming using Message Passing with MPI
Program pi

  use mpi
  
  implicit none

  integer, parameter :: finval = 10000
  double precision :: pi_square = 0.0d0
  double precision :: factor
  integer :: i

  ! MPI variables
  integer :: my_comm
  integer :: world_size, world_rank
  integer, dimension(MPI_STATUS_SIZE) :: stat
  integer :: ierr

  
  integer :: my_start, my_fin, my_elements
  double precision :: recvbuffer
  
  Call MPI_Init(ierr)

  my_comm = MPI_COMM_WORLD

  Call MPI_Comm_size(my_comm, world_size, ierr)
  Call MPI_Comm_rank(my_comm, world_rank, ierr)

  ! calculating typical workload
  my_elements = (finval + world_size -1)/world_size

  ! workshare, calculating start point and end point 
  my_start = 1 + my_elements * world_rank
  my_fin   = min(finval, my_elements * (world_rank + 1))
  
  do i= my_start, my_fin
     factor = i
     pi_square = pi_square + 1.0d0/(factor * factor)
  enddo

  ! communicate results
  ! ranks 1 and higher send to rank 0, rank 0 collects
  if (world_rank .gt. 0) then
     call MPI_SEND(pi_square, 1, MPI_DOUBLE_PRECISION, 0, 1, my_comm, ierr)
  else
     do i = 1, world_size-1
        call MPI_RECV(recvbuffer, 1, MPI_DOUBLE_PRECISION, i, 1, my_comm, stat, ierr)
        pi_square = pi_square + recvbuffer
     end do
  
     print *, 'Pi**2 =', 6.0d0 * pi_square

  endif

  Call MPI_FINALIZE(ierr)
  
end Program pi
