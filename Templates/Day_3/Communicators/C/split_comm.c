#include <mpi.h>
#include <stdio.h>

int main (void) {

  int old_rank, new_rank;
  int comm_size_world, comm_size_split;
  
  int color = 0;
  int sum_world, sum_split;   // sum of the ranks in the global and the split communicators
  sum_world = 0; sum_split = 0;
  
  //______________________   // Declare the new communicator
  
  MPI_Init( NULL, NULL );
  MPI_Comm_rank(MPI_COMM_WORLD, &old_rank);
  MPI_Comm_size(MPI_COMM_WORLD, &comm_size_world);

  // Complete the reduction command to sum up the global ranks into proc. 0
  MPI_Reduce(//________,
	     //________,
	     1,
	     MPI_INT,
	     MPI_SUM,
	     0,
	     //________);   

  
  if ( old_rank == 0)  {
    printf("Average in comm_world = %f.\n", (float)sum_world/comm_size_world);
  }

	     
  color = //_________;   // Create the even and odd colors

  //  Split the COMM_WORLD based on the color and keep the ordering as in the original group	     
  MPI_Comm_split(_______);

  // Compute the new ranks and the new size in the splitted group
  MPI_Comm_rank(_______, ________);
  MPI_Comm_size(_______, ________);
  
  printf("New rank: %d, old rank: %d.\n", new_rank, old_rank);

  // Complete the reduction command to sum up the ranks into proc. 0 of each split group
  MPI_Reduce(//__________,
	     //__________,
	     1,
	     MPI_INT,
	     MPI_SUM,
	     0,
	     //__________);   
  
  if (new_rank == 0) {
    if (color == 0) {   // print out avg. for the even group
   
      printf("Average in the even world = %f.\n", (float)sum_split/comm_size_split);
    }
    else {   // print out the avg. for the odd group
      printf("Average in the odd world = %f.\n", (float)sum_split/comm_size_split);
    }
  }


  // Don't forget to free up the new communicator once you don't need it anymore	     
  MPI_Comm_free(//_________);  
  MPI_Finalize();
  
  return 0;
}

