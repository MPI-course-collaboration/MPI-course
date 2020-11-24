!Material for the course:
!An introduction to parallel programming using Message Passing with MPI
!Author: Pedro Ojeda
program main
use mpi
implicit none



integer i,j, size_sendbuf, counts, myrank, numprocs, ierr, root
real, pointer :: sendbuf(:)
real recvbuf(4)
call MPI_INIT(ierr)
call MPI_COMM_RANK(MPI_COMM_WORLD, myrank, ierr)
call MPI_COMM_SIZE(MPI_COMM_WORLD, numprocs, ierr)

root = 0
counts =3 !nr. of elements to be sent/received
size_sendbuf = counts * numprocs !size receiving buffer
!allocating receiving buffer: 2 elements per rank
if (myrank == 0 ) then 
   allocate( sendbuf(size_sendbuf) )
   do i=1,size_sendbuf
      sendbuf(i) = 1.0*i-1.0
   enddo
endif
      

call MPI_Scatter(sendbuf,counts,MPI_REAL,recvbuf,counts,MPI_REAL,root,MPI_COMM_WORLD, ierr)

print *, "My rank=", myrank, "Array = ", (recvbuf(j),j=1,4)

if(myrank == 0) then 
  deallocate ( sendbuf )
endif

call MPI_FINALIZE(ierr)


end
