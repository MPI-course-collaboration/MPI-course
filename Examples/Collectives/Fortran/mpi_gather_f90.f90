!Material for the course:
!An introduction to parallel programming using Message Passing with MPI
!Author: Pedro Ojeda
program main
use mpi
implicit none


integer i, size_recvbuf, counts, myrank, numprocs, ierr, root
real, pointer :: recvbuf(:)
real sendbuf(4)
call MPI_INIT(ierr)
call MPI_COMM_RANK(MPI_COMM_WORLD, myrank, ierr)
call MPI_COMM_SIZE(MPI_COMM_WORLD, numprocs, ierr)

root = 0
counts =3 !nr. of elements to be sent/received
size_recvbuf = counts * numprocs !size receiving buffer
!allocating receiving buffer: 2 elements per rank
if (myrank == 0 ) allocate( recvbuf(size_recvbuf) )

!initializing sending buffer
sendbuf = (/1.0*myrank,2.0*myrank,3.0*myrank,4.0*myrank /)
call MPI_Gather(sendbuf,counts,MPI_REAL,recvbuf,counts,MPI_REAL,root,MPI_COMM_WORLD, ierr)

if(myrank == 0) then 
  do i=1,size_recvbuf
     print *, "Array", recvbuf(i)
  enddo
  deallocate ( recvbuf )
endif

call MPI_FINALIZE(ierr)


end
