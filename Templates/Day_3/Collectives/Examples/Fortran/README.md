## Material for the course:
# An introduction to parallel programming using Message Passing with MPI
## Authors: Joachim Hein, Soheil Soltani, Pedro Ojeda, and Xin Li


* Load the correspoding modules for the compilers depending on the
system that you are using

* Compile the C examples by running the following command on the
terminal:
    make allc 

* Compile the Fortran examples by running the following command on the
terminal:
    make allf

* Clean out the executables
    make clean

* Running scritps:
    sbatch run.sh mpi_reduce_f90
    sbatch run.sh mpi_scatter_f90
    sbatch run.sh mpi_gather_f90
    sbatch run.sh mpi_reduce_f90

    sbatch run.sh mpi_broadcast_f90 1000
