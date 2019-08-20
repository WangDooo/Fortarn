      SUBROUTINE USDFLD(FIELD,STATEV,PNEWDT,DIRECT,T,CELENT, 
     1 TIME,DTIME,CMNAME,ORNAME,NFIELD,NSTATV,NOEL,NPT,LAYER, 
     2 KSPT,KSTEP,KINC,NDI,NSHR,COORD,JMAC,JMATYP,MATLAYO, LACCFLA) 

      INCLUDE 'ABA_PARAM.INC' 

      CHARACTER*80 CMNAME,ORNAME 
      CHARACTER*3  FLGRAY(15) 
      DIMENSION FIELD(NFIELD),STATEV(NSTATV),DIRECT(3,3), T(3,3),
     1 TIME(2) 
      DIMENSION ARRAY(15),JARRAY(15),JMAC(*),JMATYP(*),COORD(*)
      

      real, parameter :: k_soil = 560.0
      real, parameter :: pa=100.0
      real, parameter :: lambda_soil = 0.6
      real :: Sigma_m_0 
      real :: E_0



      character(len=10) :: str
      real :: value
      
      if (CMNAME(1:4) .eq. 'MAT1') then
           if (kstep .le. 1) then
              E_0 = 10000.0*TAN(38.0/180.0*3.1415)*
     1    sqrt(9.5*(40.0-coord(3)))
             !         CALL GETVRM('S',ARRAY,JARRAY,FLGRAY,JRCD,JMAC,JMATYP, 
             !1        MATLAYO,LACCFLA) 
             !         S11 = array(1) 
             !         S22 = array(2)
             !         S33 = array(3)
             !         ! 根据简布公式计算E
             !         Sigma_m_0 = abs(S11 + S22 + S33) / 3.0
             !         !str = 'Sigma_m_0'
             !         !value = real(Sigma_m_0)
             !         !call WriteValue(str,value)
             !         E_0 = k_soil  * pa * (Sigma_m_0/pa) ** lambda_soil 
             !
             !         STATEV(1) = S11
             !         STATEV(2) = S22
             !         STATEV(3) = S33
             !         STATEV(4) = Sigma_m_0
                      statev(1) = E_0
                      Field(1) = E_0
              else if (kstep .gt. 1) then
                      Field(1) = statev(1)
              end if

      else if (CMNAME(1:4) .eq. 'MAT2') then
          CALL GETVRM('S',ARRAY,JARRAY,FLGRAY,JRCD,JMAC,JMATYP, 
     1        MATLAYO,LACCFLA) 
          S11 = array(1)
          S22 = array(2)
          S33 = array(3)
          sigma_m = (abs(S11)+abs(S22)+abs(S33)) / 3.0
          str = 'S22'
          value = real(S22)
          call WriteValue(str,value)
          E_m = 560.0*100.0*(sigma_m/100.0)**0.6
          Field(1) = E_m 
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