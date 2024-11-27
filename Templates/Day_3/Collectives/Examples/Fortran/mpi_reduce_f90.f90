!Material for the course:
!An introduction to parallel programming using Message Passing with MPI
!Author: Pedro Ojeda
program main
use mpi
implicit none



integer i, counts, myrank, numprocs, ierr, root
real sendbuf(4)
real, pointer :: recvbuf(:)
call MPI_INIT(ierr)
call MPI_COMM_RANK(MPI_COMM_WORLD, myrank, ierr)
call MPI_COMM_SIZE(MPI_COMM_WORLD, numprocs, ierr)

root = 0
counts =3 !nr. of elements to be sent/received

!initializing sending buffer
sendbuf = (/1.0*myrank,2.0*myrank,3.0*myrank,4.0*myrank /)

!allocating receiving buffer: 2 elements
if (myrank == 0 ) allocate( recvbuf(counts) )

call MPI_REDUCE(sendbuf,recvbuf,counts,MPI_REAL,MPI_SUM,root,MPI_COMM_WORLD, ierr)

if(myrank == 0) then 
  print *, "Reduced array = ", (recvbuf(i),i=1,counts)
  deallocate ( recvbuf )
endif

call MPI_FINALIZE(ierr)


end
