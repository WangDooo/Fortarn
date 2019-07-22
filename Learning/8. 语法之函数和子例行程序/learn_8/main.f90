program main
    implicit none
    !integer :: x(3,3) = reshape( &
    !    [1,2,3,4,5,6,7,8,9], &
    !    [3,3])
    !
    !call WriteMatrix(x)
    
    !call sub(7, 6)
    !call sub(5, 4, 3)
    !call sub(c=30, b=40, a=50)
    
    write(*,*) integral(x2, 1.0, 2.0, 0.01)
    write(*,*) 2.0**3/3 - 1.0**3/3
    write(*,*) integral(x3, 1.0, 2.0, 0.01)
    write(*,*) 2.0**4/4 - 1.0**4/4
contains
    subroutine WriteMatrix(iMat)
        integer , intent(in) :: iMat(:,:)
        integer :: i
        do i = 1,  size(iMat, dim=2) ! dim=1 ÐÐ dim=2 ÁÐ
            write(*,*) iMat(:,i)
        end do 
    end subroutine
    
    subroutine sub(a, b, c)
        integer :: a, b
        integer, optional :: c
        write(*,*) a, b
        if ( present(c) ) then
            write(*,*) 'optional:', c
        endif
    end subroutine sub
    
    real function x2(x)
        real :: x
        x2 = x*x
    end function x2
    
    real function x3(x)
        real :: x
        x3 = x*x*x
    end function x3
    
    real function integral(func, low_bound, up_bound, delta) result (y)
        interface
            real function func(x)
                real :: x
            end function func
        end interface
        real, intent(in) :: low_bound, up_bound, delta
        integer :: i
        real :: x
        y = 0.0
        x = low_bound + delta/2.0
        do
            y = y + func(x)
            x = x + delta
            if (x>up_bound) exit
        end do
        y = y * delta
    end function integral
    
end program main