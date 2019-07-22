program main
    implicit none
    
    !integer :: i
    !integer, dimension(5) :: arr
    !data arr /1,3,5,77,999/
    !
    !write(*,'(A,3X,A)') 'index', 'value'
    !do i = 1, 5
    !    write(*,'(2i5)') i, arr(i)
    !end do
    !
    !print *
    !write(*,'(A,1X,A)') 'Max_loc', 'Max_val'
    !write(*,'(2i5)') maxloc(arr), maxval(arr)
    !
    !print *
    
    integer, parameter :: nmax = 100
    real, parameter :: pi = 3.1415926
    real, dimension(nmax) :: arr
    integer, dimension(5) :: vecsubscp=(/1,4,6,7,5/)
    integer :: narr, i
    
    narr = 10
    
    arr(:narr) = 1
    write(*,*) "assign total"
    write(*,'(10f12.6)') arr(:narr)
    write(*,*)
    
    arr(1) = -1
    write(*,*) "assign element"
    write(*,'(10f12.6)') arr(:narr)
    write(*,*)
    
    arr(2:4) = (/(sin(pi*(i-1.)/(narr-1)), i=2,4)/)
    write(*,*) "assign slice"
    write(*,'(10f12.6)') arr(:narr)
    write(*,*)
    
    call funarr(arr(2:4),3)
    write(*,*) "assign slice"
    write(*,'(10f12.6)') arr(:narr)
    write(*,*)
    
    arr(vecsubscp(:3))=0.5
    write(*,*) "assign vector subscript"
    write(*,'(10f12.6)') arr(:narr)
    write(*,*)
    
    call funarr(arr(vecsubscp(3:5)), 3)
    write(*,*) "assign vector subscript"
    write(*,'(10f12.6)') arr(:narr)
    write(*,*)
    
    stop
    
end program

    
    
subroutine funarr(a,n)
    implicit none
    integer :: n
    real, dimension(n) :: a
    
    write (*,*) "funarr vector subscript----in"
    write(*,'(10F12.6)') a(:n) 
    write (*,*) "funarr vector subscript----out"
    a(:n) = a(:n) -100
end subroutine
