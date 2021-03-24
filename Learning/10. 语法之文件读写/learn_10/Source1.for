      program main

      open(111,file="E:\Temp\test.txt") 
      NTENS = 6
      DIMENSION DDSDDE(NTENS,NTENS)


      DO I=1,NTENS 
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
      DDSDDE(3,1) = 3
      DDSDDE(3,2) = 3
      DDSDDE(3,3) = 5
      DDSDDE(4,4) = 8
      DDSDDE(5,5) = 8
      DDSDDE(6,6) = 8
      

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
 200  CONTINUE
 	
      do I=1,NTENS 
 		do J=1,NTENS 
 			write(111,*)'DDSDDE(',I,',',J,')=',DDSDDE(I,J) 
 		enddo 
 	enddo 

      end program main