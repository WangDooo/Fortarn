      SUBROUTINE USDFLD(FIELD,STATEV,PNEWDT,DIRECT,T,CELENT, 
     1 TIME,DTIME,CMNAME,ORNAME,NFIELD,NSTATV,NOEL,NPT,LAYER, 
     2 KSPT,KSTEP,KINC,NDI,NSHR,COORD,JMAC,JMATYP,MATLAYO, LACCFLA) 

      INCLUDE 'ABA_PARAM.INC' 

      CHARACTER*80 CMNAME,ORNAME 
      CHARACTER*3  FLGRAY(15) 
      DIMENSION FIELD(NFIELD),STATEV(NSTATV),DIRECT(3,3), T(3,3),
     1 TIME(2) 
      DIMENSION ARRAY(15),JARRAY(15),JMAC(*),JMATYP(*),COORD(*)
      ! 一下部分是博士论文中的代码
      dimension ps(3), B(10931) ! B 是什么东西
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
      
      CALL GETVRM('S',ARRAY,JARRAY,FLGRAY,JRCD,JMAC,JMATYP, 
     1 MATLAYO,LACCFLA) 
      S11 = array(1)
      S22 = array(2)
      S33 = array(3)
      P = (S11+S22+S33) / 3
      AP = DLOG(P)
      
      
      ! 我的 
       parameter (k_soil = 560.0)
       parameter (Pa=100.0)
       parameter (Pi = 3.1415926)
       parameter (lambda_soil = 0.6)
       parameter (phi_soil = 0.658)
       parameter (T = 2.0)
       parameter (b1 = 0.18)
       parameter (b2 = 0.43)
       parameter (c=0.5)
      
      character(len=10) :: str
      real :: value
      
      ! str = 'Time1'
      ! value = 123.3
      ! call WriteValue(str,value)
      
      if (kstep .eq. 1) then
         ! 计算E1存放在 statev(1)
          CALL GETVRM('S',ARRAY,JARRAY,FLGRAY,JRCD,JMAC,JMATYP, 
     1 MATLAYO,LACCFLA) 
          S11 = abs(array(1))  ! 这里直接去abs 因为土体单元是受压为负 s11=simga3 为负
          S22 = abs(array(2))
          S33 = abs(array(3))
          Sigma_m = (S11 + S22 + S33) / 3.0
          E_1 = k_soil  * pa * (Sigma_m/pa) ** lamdba_soil
          STATEV(1) = E_1 ! 这个E1具体是什么意思
          Field(1) = E_1
          ! 计算 X_0 存放在statev(2)
          Sigma_1_0 = S33
          Sigma_3_0 = (S11 + S22) / 2.0
          Sigma_1_sf_0 = ((1+sin(phi_soil))*Sigma_3_0+
     1                          2*c*cos(phi_soil)) / (1-sin(phi_soil)) 
          X_0 = Sigma_1_0 / Sigma_1_sf_0
          STATEV(2) = X_0
          
      else if (kstep .eq. 2) then
          CALL GETVRM('S',ARRAY,JARRAY,FLGRAY,JRCD,JMAC,JMATYP, 
     1 MATLAYO,LACCFLA) 
          S11 = abs(array(1))  ! 这里直接去abs 因为土体单元是受压为负 s11=simga3 为负
          S22 = abs(array(2))
          S33 = abs(array(3))
          ! 计算N
          N_cyc = Time(1) / 2.0 ! 的整数部分【需要改一下】
          ! 计算X_n
          Sigma_1_n = S33
          Sigma_3_n = (S11+S22)/2.0
          Sigma_1_sf_n = ((1+sin(phi_soil))*Sigma_3_n+
     1                          2*c*cos(phi_soil)) / (1-sin(phi_soil)) 
          X_n = Sigma_1_n / Sigma_1_sf_n
          X_0 = statev(2)
          X_c = (X_1-X_0)/(1-X_0)
          N_decay = N_cyc**(-1*b1*(X_c**b2))
          E_1 = statev(1)
          E_sn = E_1 * N_decay
          Field(1) = E_sn
          
          
          
          
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