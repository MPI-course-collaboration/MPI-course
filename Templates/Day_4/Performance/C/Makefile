CC = mpicc
FC = mpif90
CFLAGS = -g -lm

objects =  integration2D_c
allc: $(objects)

$(objects): %: %.c
	        $(CC) $(CFLAGS) -o $@ $<


objectsf =  integration2D_f90
allf: $(objectsf)

$(objectsf): %: %.f90
	        $(FC) $(CFLAGS) -o $@ $<

.PHONY: clean
	 
clean:
	rm *_f90 *_c
