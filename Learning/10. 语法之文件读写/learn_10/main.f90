program main
    implicit none
    !real :: a(3,4)
    !integer :: FILE_IN , i, j
    !real :: r
    !!open(NewUnit=FILE_IN, File="2d_text.txt")
    !!    do i = 1, size(a, dim=2)
    !!        read(file_in,*) a(:,i)
    !!        write(*,*) a(:,i)
    !!    end do
    !!close(FILE_IN)
    !
    !character(len=512) :: cStr
    !open (Unit=123, file="C:\Users\123\Desktop\testfor.txt")
    !open(NewUnit=FILE_IN, File="text.txt")
    !    read(file_in, '(a512)') cStr
    !    i = index(cStr, "dt=") +3
    !    j = index(cStr, "ms")
    !    read(cStr(i+1:j-1), *) r
    !    write(*, '("DeltaT =",f10.5)') r
    !    write(123, '("DeltaT =",f10.5)') r
    !close(FILE_IN)
    !close(123)
    
    character(len=10) :: str
    integer :: E = 300
    real :: value 
    
    str = 'E'
    ! read(E,*) value
    value = real(E)
    call Writetxt(str,value)
    
    
    
    end program main
    
subroutine WriteTxt(name,value)
    character(len=10) :: name
    real :: value
    open (Unit=123, file="C:\Users\123\Desktop\testfor.txt")
        write(123,'(a10," = ",f12.6)') name, value
    close(123)
end subroutine