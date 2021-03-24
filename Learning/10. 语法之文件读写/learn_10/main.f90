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
    
    !character(len=10) :: str
    !integer :: E = 300
    !real :: value 
    !
    !str = 'E'
    !! read(E,*) value
    !value = real(E)
    !call Writetxt(str,value)
    
    
     open(111,file="E:\Temp\test.txt") 

      NTENS = 6.

      DO I=1,6 
		DO J = 1,NTENS 
			DDSDDE(I,J) = 0. 
		ENDDO 
	ENDDO
      
      DDSDDE(1,1) = 5.
      DDSDDE(1,2) = 3.
      DDSDDE(1,3) = 3.
      DDSDDE(2,1) = 3.
      DDSDDE(2,2) = 5.
      DDSDDE(2,3) = 3.
      DDSDDE(3,1) = 3.
      DDSDDE(3,2) = 3.
      DDSDDE(3,3) = 5.
      DDSDDE(4,4) = 8.
      DDSDDE(5,5) = 8.
      DDSDDE(6,6) = 8.
      

      DO 200 N = 1,NTENS 
		D = DDSDDE(N,N) 
		DO 100 J = 1,NTENS 
  100			DDSDDE(N,J) = -DDSDDE(N,J)/D 
			DO 150 I = 1,NTENS 
				IF( N-I ) 110,150,110 
  110				DO 140 J = 1,NTENS 
				IF( N-J ) 120,140,120 
  120					DDSDDE(I,J) = DDSDDE(I,J)+DDSDDE(I,N)*DDSDDE(N,J) 
  140				CONTINUE 
  150			DDSDDE(I,N) = DDSDDE(I,N)/D 
		DDSDDE(N,N) = 1./D 
      200 CONTINUE
 	
      do I=1,NTENS 
 		do J=1,NTENS 
 			write(111,*)'DDSDDE(',I,',',J,')=',DDSDDE(I,J) 
 		enddo 
 	enddo 

    end program main
    
subroutine WriteTxt(name,value)
    character(len=10) :: name
    real :: value
    open (Unit=123, file="C:\Users\123\Desktop\testfor.txt")
        write(123,'(a10," = ",f12.6)') name, value
    close(123)
end subroutine