program Test
    implicit none
    integer :: i, arr(3)
    ! read(*,*) i
    ! call sub(i)
    real :: r=1.
    write(*, '(es12.2)') r
    ! write(*,*) arr(i)
end program Test

subroutine sub(i)
    integer :: i
end subroutine sub
    
    