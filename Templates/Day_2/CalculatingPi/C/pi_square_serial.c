#include <stdio.h>

int main()
{

  const int finval = 1000000000;

  double pi_square = 0.0;

  for ( int i=1 ; i <= finval; i++)
    {  
      double factor = (double) i;
      pi_square += 1.0/( factor * factor );
    }

  printf ( "Pi^2 = %.10f\n", pi_square*6.0);

  return 0;
}
