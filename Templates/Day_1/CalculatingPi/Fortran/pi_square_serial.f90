Program pi

  implicit none

  integer, parameter :: finval = 10000
  double precision :: pi_square = 0.0d0
  double precision :: factor
  integer:: i
  
  do i= 1, finval
     factor = i
     pi_square = pi_square + 1.0d0/(factor * factor)
  enddo

  print *, 'Pi**2 =', 6.0d0 * pi_square
  
end Program pi
