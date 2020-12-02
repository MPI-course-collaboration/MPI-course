#include <mpi.h>
#include <stdio.h>

int main (void) {

  int old_rank, new_rank;
  int comm_size_world, comm_size_split;
  
  int color = 0;
  int sum_world, sum_split;   // sum of the ranks in the global and the split communicators
  sum_world = 0; sum_split = 0;
  
  MPI_Comm newcomm;
  
  MPI_Init( NULL, NULL );
  MPI_Comm_rank(MPI_COMM_WORLD, &old_rank);
  MPI_Comm_size(MPI_COMM_WORLD, &comm_size_world);

  MPI_Reduce(&old_rank, &sum_world, 1, MPI_INT, MPI_SUM, 0, MPI_COMM_WORLD);   // sum up the global ranks into proc. 0

  if ( old_rank == 0)  {
    printf("Average in comm_world = %f.\n", (float)sum_world/comm_size_world);
  }
  
  color = old_rank%2;   // Create the even and odd colors
  
  MPI_Comm_split(MPI_COMM_WORLD, color, old_rank, &newcomm);

  // Compute the new ranks and the new size in the splitted group
  MPI_Comm_rank(newcomm, &new_rank);
  MPI_Comm_size(newcomm, &comm_size_split);
  
  printf("New rank: %d, old rank: %d.\n", new_rank, old_rank);

  MPI_Reduce(&new_rank, &sum_split, 1, MPI_INT, MPI_SUM, 0, newcomm);   // sum up the ranks into proc. 0 of each split group
  
  if (new_rank == 0) {
    if (color == 0) {   // print out avg. for the even group
   
      printf("Average in the even world = %f.\n", (float)sum_split/comm_size_split);
    }
    else {   // print out the avg. for the odd group
      printf("Average in the odd world = %f.\n", (float)sum_split/comm_size_split);
    }
  }

  
  MPI_Comm_free(&newcomm);  
  MPI_Finalize();
  
  return 0;
}

