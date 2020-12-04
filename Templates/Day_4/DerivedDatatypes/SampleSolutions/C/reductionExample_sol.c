#include <stdio.h>
#include <math.h>
#include "mpi.h"
#include "realint_pair.h"


void setup_mpi(MPI_Comm* pcomm, int* psize, int* prank)
{
    MPI_Init(NULL, NULL);
    
    *pcomm = MPI_COMM_WORLD;
    
    MPI_Comm_size(*pcomm, psize);
    MPI_Comm_rank(*pcomm, prank);
    
    return;
}

void addmax_ri(void* pfirst, void* psecond, int* plen,
	       MPI_Datatype* ptype)
{
  ri_pair* pf = (ri_pair*)pfirst;
  ri_pair* ps = (ri_pair*)psecond;

  for (int i=0; i < *plen; i++)
    {
      ps[i].rpart += pf[i].rpart;
      ps[i].ipart = fmax(pf[i].ipart, ps[i].ipart);
    }
  return;
}


int main(int argc, char **argv) 
{

  // setting up MPI

  MPI_Comm my_world;
  int my_rank, world_size;

  setup_mpi(&my_world, &world_size, &my_rank);

  ri_pair my_values, received_values, reduced_values;

  my_values.rpart = my_rank;
  my_values.ipart = my_rank;

  printf("On rank %d my values are: (%f, %d)\n", 
	 my_rank, my_values);
 
  // Stuff to make derived datatype
  const int nb_entries = 2;
  int bleng[nb_entries];
  bleng[0] = 1;
  bleng[1] = 1;

  MPI_Aint start_address, disp[nb_entries];
  MPI_Get_address(&my_values,       &start_address);
  MPI_Get_address(&my_values.rpart, &(disp[0]));
  MPI_Get_address(&my_values.ipart, &(disp[1]));

  for (int i=0; i < nb_entries; i++)
    disp[i] = disp[i] - start_address;

  MPI_Datatype types[nb_entries]; 
  types[0] = MPI_DOUBLE;
  types[1] = MPI_INT;

  MPI_Datatype ri_mpitype;
  MPI_Type_create_struct(nb_entries, bleng, disp, types, &ri_mpitype);
  MPI_Type_commit(&ri_mpitype);

  if (my_rank == 0)
    {
      MPI_Status stat;
      MPI_Recv(&received_values, 1, ri_mpitype, 1, 1, my_world, &stat);
      printf("On rank 0 we received from 1: (%f, %d)\n", 
	     received_values);
    }
  else if(my_rank == 1)
    {
      MPI_Send(&my_values, 1, ri_mpitype, 0, 1, my_world);
    }

  // reduction operator
  MPI_Op ri_addmax_mpiop;
  MPI_Op_create(&addmax_ri, 1, &ri_addmax_mpiop);

  MPI_Reduce(&my_values, &reduced_values, 1, ri_mpitype, 
	     ri_addmax_mpiop, 0, my_world);

  if (my_rank == 0)
    {
      printf("On rank 0 we got reduced values: (%f, %d)\n", 
	     reduced_values);
    }
	     

 
  MPI_Finalize();

  return 0;
}

