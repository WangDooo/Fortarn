      SUBROUTINE USDFLD(FIELD,STATEV,PNEWDT,DIRECT,T,CELENT, 
     1 TIME,DTIME,CMNAME,ORNAME,NFIELD,NSTATV,NOEL,NPT,LAYER, 
     2 KSPT,KSTEP,KINC,NDI,NSHR,COORD,JMAC,JMATYP,MATLAYO, LACCFLA) 

      INCLUDE 'ABA_PARAM.INC' 

      CHARACTER*80 CMNAME,ORNAME 
      CHARACTER*3  FLGRAY(15) 
      DIMENSION FIELD(NFIELD),STATEV(NSTATV),DIRECT(3,3), T(3,3),
     1 TIME(2) 
      DIMENSION ARRAY(15),JARRAY(15),JMAC(*),JMATYP(*),COORD(*)

      dimension ps(3), B(10931) ! B ��ʲô����
      parameter (Fre=1.0D-01)
      parameter (Aa=1.382D0)
      parameter (An=1.4940)
      parameter (Ac=0.737D0)
      parameter (Ab=0.386D-01)
      parameter (Pa=1.01D+05)
      parameter (E0=15E6)
      parameter (Dr=0.88D0)

      parameter (Fc=0.88D0)
      real :: N, D, EMOD, CYC, P
      integer :: NT

      character(len=10) :: str
      real :: value
      
      ! str = 'Time1'
      ! value = 123.3
      ! call WriteValue(str,value)
      
      if (kstep .ge. 3) then
          
      
      
      CALL GETVRM('S',ARRAY,JARRAY,FLGRAY,JRCD,JMAC,JMATYP, 
     1 MATLAYO,LACCFLA) 
      S11 = array(1)
      S22 = array(2)
      S33 = array(3)
      P = (S11+S22+S33) / 3
      AP = DLOG(P)

      
      
      end if
      return
      end subroutine USDFLD
    
      subroutine WriteValue(name,value)
          character(len=10) :: name
          real :: value
          open (Unit=123, file="C:\Users\123\Desktop\test_value.txt", 
     1            position='append')
              write(123,'(a10," = ",f12.6)') name, value
          close(123)
      end subroutine WriteValue