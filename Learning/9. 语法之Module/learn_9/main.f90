program main
    implicit none
    interface
        subroutine sub(x)
            real :: x(:,:)
        end subroutine
    end interface
    
    real :: a(30,23)
    call sub(a)
    call call_sub()
end program
    
subroutine sub(x)
    implicit none
    real :: x(:,:)
    write(*,*) size(x,dim=1), size(x,dim=2)
end subroutine sub

subroutine call_sub()
    implicit none
    interface
        subroutine sub(x)
            real :: x(:,:)
        end subroutine
    end interface
    
    real :: b(12,13)
    call sub(b)
end subroutine call_sub
    
    