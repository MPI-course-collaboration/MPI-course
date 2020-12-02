!Material for the course:
!An introduction to parallel programming using Message Passing with MPI
!Author: Pedro Ojeda
program main
use mpi
implicit none


integer old_rank, new_rank
integer ierr, comm_size_world, comm_size_split

!declare a new communicator that will contained the split MPI_COMM_WORLD

integer color
integer sum_world, sum_split !sum of the ranks in the global and the split communicators
sum_world = 0
sum_split = 0


call MPI_INIT(ierr)
call MPI_COMM_RANK(MPI_COMM_WORLD, old_rank, ierr)
call MPI_COMM_SIZE(MPI_COMM_WORLD, comm_size_world, ierr)

! sum up the global ranks into proc. 0
call MPI_REDUCE(,,1,MPI_INTEGER,MPI_SUM,0,,) 

if (old_rank == 0) then
     print *, "Average in comm_world = ", 1.0*sum_world/(1.0*comm_size_world)
endif

!create even and odd colors
color =

!split the MPI_COMM_WORLD
call MPI_Comm_split(,,,,)


! Compute the new ranks and the new size in the splitted group
call MPI_COMM_RANK(,,)
call MPI_COMM_SIZE(,,)

print *, "New rank", new_rank, "old rank", old_rank

! sum up the ranks into proc. 0 of each split group
call MPI_REDUCE(,,,MPI_INTEGER,MPI_SUM,0,,) 


if (new_rank == 0) then
  if( color == 0 ) then
     print *, "Average in the even world = ", 1.0*sum_split/(1.0*comm_size_split)
  else
     print *, "Average in the odd world = ", 1.0*sum_split/(1.0*comm_size_split)
  endif
endif

call MPI_COMM_FREE(, )
call MPI_FINALIZE()


end
