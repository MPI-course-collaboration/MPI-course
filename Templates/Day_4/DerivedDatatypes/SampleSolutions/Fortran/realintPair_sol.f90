Module realint_pair

  type ri_pair
     real(kind(1.0d0)) :: realpart
     integer           :: intpart
  end type ri_pair

contains

  subroutine addmax_ri(first, second, len, type)
    type(ri_pair), dimension(len), intent(in)    :: first
    type(ri_pair), dimension(len), intent(inout) :: second
    integer, intent(in) :: len, type

    integer :: i

    Do i = 1, len
       second(i)%realpart = first(i)%realpart + second(i)%realpart
       second(i)%intpart  = max(first(i)%intpart, second(i)%intpart)
    enddo
  end subroutine addmax_ri

End Module realint_pair

