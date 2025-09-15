program mpi_send_recv
    use mpi
    implicit none

    integer :: i, ierr, comm, rank, size
    integer :: N, tag, status(MPI_STATUS_SIZE)
    double precision, allocatable :: data(:)
    double precision :: t_start, t_end

    N = 40000000   ! size of data
    tag = 77
    comm = MPI_COMM_WORLD

    call MPI_Init(ierr)
    call MPI_Comm_rank(comm, rank, ierr)
    call MPI_Comm_size(comm, size, ierr)

    if (rank == 0) then
        allocate(data(N))
        data = [(dble(i-1), i=1,N)]
        call MPI_Barrier(comm, ierr)
        t_start = MPI_Wtime()
        call MPI_Send(data, N, MPI_DOUBLE_PRECISION, 1, tag, comm, ierr)
        t_end = MPI_Wtime()
        print *, 'Rank:', rank, 'send with Fortran MPI takes', t_end - t_start, 'seconds'
        deallocate(data)

    else if (rank == 1) then
        allocate(data(N))
        call MPI_Barrier(comm, ierr)
        t_start = MPI_Wtime()
        call MPI_Recv(data, N, MPI_DOUBLE_PRECISION, 0, tag, comm, status, ierr)
        t_end = MPI_Wtime()
        print *, 'Rank:', rank, 'recv with Fortran MPI takes', t_end - t_start, 'seconds'
        deallocate(data)
    end if

    call MPI_Finalize(ierr)
end program mpi_send_recv

