      SUBROUTINE USDFLD(FIELD,STATEV,PNEWDT,DIRECT,T,CELENT, 
     1 TIME,DTIME,CMNAME,ORNAME,NFIELD,NSTATV,NOEL,NPT,LAYER, 
     2 KSPT,KSTEP,KINC,NDI,NSHR,COORD,JMAC,JMATYP,MATLAYO, LACCFLA) 

      INCLUDE 'ABA_PARAM.INC' 

      CHARACTER*80 CMNAME,ORNAME 
      CHARACTER*3  FLGRAY(15) 
      DIMENSION FIELD(NFIELD),STATEV(NSTATV),DIRECT(3,3), T(3,3),
     1 TIME(2) 
      DIMENSION ARRAY(15),JARRAY(15),JMAC(*),JMATYP(*),COORD(*)
      
      character(len=10) :: str
      real :: value
      
      
      E_now = 10000.0*TAN(38.0/180.0*3.1415)*sqrt(9.5*(10.0-coord(3)))
      STATEV(1) =E_now
      str = 'E_now'
      value = real(E_now)
      call WriteValue(str,value)
      
      Field(1) = E_now
      
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