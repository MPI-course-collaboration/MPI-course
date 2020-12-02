!Material for the course:
!An introduction to parallel programming using Message Passing with MPI
!Author: Pedro Ojeda
program main
use mpi
implicit none


integer old_rank, new_rank
integer ierr, comm_size_world, comm_size_split

integer newcomm

integer color
integer sum_world, sum_split !sum of the ranks in the global and the split communicators
sum_world = 0
sum_split = 0


call MPI_INIT(ierr)
call MPI_COMM_RANK(MPI_COMM_WORLD, old_rank, ierr)
call MPI_COMM_SIZE(MPI_COMM_WORLD, comm_size_world, ierr)

! sum up the global ranks into proc. 0
call MPI_REDUCE(old_rank,sum_world,1,MPI_INTEGER,MPI_SUM,0,MPI_COMM_WORLD, ierr) 

if (old_rank == 0) then
     print *, "Average in comm_world = ", 1.0*sum_world/(1.0*comm_size_world)
endif

color = mod(old_rank,2)

call MPI_Comm_split(MPI_COMM_WORLD, color, old_rank, newcomm, ierr)


! Compute the new ranks and the new size in the splitted group
call MPI_COMM_RANK(newcomm, new_rank, ierr)
call MPI_COMM_SIZE(newcomm, comm_size_split, ierr)

print *, "New rank", new_rank, "old rank", old_rank

! sum up the ranks into proc. 0 of each split group
call MPI_REDUCE(new_rank,sum_split,1,MPI_INTEGER,MPI_SUM,0,newcomm, ierr) 


if (new_rank == 0) then
  if( color == 0 ) then
     print *, "Average in the even world = ", 1.0*sum_split/(1.0*comm_size_split)
  else
     print *, "Average in the odd world = ", 1.0*sum_split/(1.0*comm_size_split)
  endif
endif

call MPI_COMM_FREE(newcomm, ierr)
call MPI_FINALIZE(ierr)


end
