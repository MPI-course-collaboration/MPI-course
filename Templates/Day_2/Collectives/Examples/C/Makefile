CC = mpicc
FC = mpif90
CFLAGS = -g

objects = mpi_barrier_c mpi_broadcast_c mpi_gather_c mpi_scatter_c mpi_reduce_c
allc: $(objects)

$(objects): %: %.c
	        $(CC) $(CFLAGS) -o $@ $<


objectsf = mpi_barrier_f90 mpi_broadcast_f90 mpi_gather_f90 mpi_scatter_f90 mpi_reduce_f90
allf: $(objectsf)

$(objectsf): %: %.f90
	        $(FC) $(CFLAGS) -o $@ $<

.PHONY: clean
	 
clean:
	rm *_f90 *_c
