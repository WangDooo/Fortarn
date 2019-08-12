 SUBROUTINE USDFLD(FIELD,STATEV,PNEWDT,DIRECT,T,CELENT, &
TIME,DTIME,CMNAME,ORNAME,NFIELD,NSTATV,NOEL,NPT,LAYER, &
KSPT,KSTEP,KINC,NDI,NSHR,COORD,JMAC,JMATYP,MATLAYO, LACCFLA) 

INCLUDE 'ABA_PARAM.INC' 

CHARACTER*80 CMNAME,ORNAME 
CHARACTER*3  FLGRAY(15) 
DIMENSION FIELD(NFIELD),STATEV(NSTATV),DIRECT(3,3), T(3,3),TIME(2) 
DIMENSION ARRAY(15),JARRAY(15),JMAC(*),JMATYP(*),COORD(*)
        
character(len=10) :: str
real :: value
      
str = 'Time1'
value = real(TIME(1))
call WriteValue(str,value)

if(TIME(1) .lt. 0.5) then
  FIELD(1) = 1
else
  FIELD(1) = 2
end if

return
end subroutine USDFLD
    
subroutine WriteValue(name,value)
      character(len=10) :: name
      real :: value
      open (Unit=123, file="C:\Users\123\Desktop\test_value.txt",position='append')
          write(123,'(a10," = ",f12.6)') name, value
       close(123)
end subroutine WriteValue