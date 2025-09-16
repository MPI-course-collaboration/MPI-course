# Demonstration of sending lists around a ring
This demonstration builds on the sample solution of the exercise **Message around a ring** for the lecture on non blocking communication.  The key purpose is to demonstrate the issues associsated with buffering large messages in **irecv**.

We have four versions of the Python script.   In this demonstartion we send a list of integer variables.  The number of list elements can be controlled inside the script using the variable `vleng`.

## Using blocking communication (incorrect example)
We start with a script that uses blocking communication.  For the problem at hand, using blocking communication is **incorrect** and violates the MPI standard.   The script is named: `ringsend_sol_list_block.py`.

* First we run the code for `vleng = 100` and it executes despite being incorrect.  
* Increasing `vleng = 100000` makes the code stop executing - it waits forever

## Using non-blocking receive
To improve we use a non-blocking `irecv` combined with a blocking `send`.  This Python script is named: `ringsend_sol_list.py`.

* Using `vleng = 10000` the code executes correctly.
* Using `vleng = 20000` the code fails with an exception: ```mpi4py.MPI.Exception: MPI_ERR_TRUNCATE: message truncated```

## Supplying extra buffer space to the non-blocking receive
One solution of the issue is supplying extra buffer space to `irecv`.   In `ringsend_sol_list_buf.py` we supply 1 MB of buffer space to each `irecv`.  Now the code runs cases with `vleng = 100000` correctly.   One needs to supply larger buffers to run larger cases.

## Utilising `isend` instead of `irecv`

To avoid the issue alltogether one can use non-blocking `isend` and blocking `recv`.  This is implemented in the script `ringsend_sol_list_isend.py`.  This script runs `vleng = 10000000`, 10 million list entries, without issues.

Such a solution offers little scope for overlaping communication and calculation.