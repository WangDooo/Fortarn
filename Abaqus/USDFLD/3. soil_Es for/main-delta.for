      SUBROUTINE USDFLD(FIELD,STATEV,PNEWDT,DIRECT,T,CELENT, 
     1 TIME,DTIME,CMNAME,ORNAME,NFIELD,NSTATV,NOEL,NPT,LAYER, 
     2 KSPT,KSTEP,KINC,NDI,NSHR,COORD,JMAC,JMATYP,MATLAYO, LACCFLA) 

      INCLUDE 'ABA_PARAM.INC' 

      CHARACTER*80 CMNAME,ORNAME 
      CHARACTER*3  FLGRAY(15) 
      DIMENSION FIELD(NFIELD),STATEV(NSTATV),DIRECT(3,3), T(3,3),
     1 TIME(2) 
      DIMENSION ARRAY(15),JARRAY(15),JMAC(*),JMATYP(*),COORD(*)
      ! һ�²����ǲ�ʿ�����еĴ���
       ! dimension ps(3), B(10931) ! B ��ʲô����
       ! parameter (Fre=1.0D-01)
       ! parameter (Aa=1.382D0)
       ! parameter (An=1.4940)
       ! parameter (Ac=0.737D0)
       ! parameter (Ab=0.386D-01)
       ! parameter (Pa=1.01D+05)
       ! parameter (E0=15E6)
       ! parameter (Dr=0.88D0)
       !
       ! parameter (Fc=0.88D0)
       ! real :: N, D, EMOD, CYC, P
       ! integer :: NT
       ! 
       ! CALL GETVRM('S',ARRAY,JARRAY,FLGRAY,JRCD,JMAC,JMATYP, 
       !1 MATLAYO,LACCFLA) 
       ! S11 = array(1)
       ! S22 = array(2)
       ! S33 = array(3)
       ! P = (S11+S22+S33) / 3
       ! AP = DLOG(P)
      
      
      ! �ҵ� 
      real, parameter :: k_soil = 560.0
      real, parameter :: Pa=100.0
      real, parameter :: Pi = 3.1415926
      real, parameter :: lambda_soil = 0.6
      real, parameter :: phi_soil = 0.658
      real, parameter :: b1 = 0.18
      real, parameter :: b2 = 0.43
      real, parameter :: c = 0.5
      real, parameter :: increment = 0.1 ! �������Ĺ̶� increment size
      real, parameter :: T_cyc = 2.0          ! ��������
      integer :: N_cyc
      real :: inc_a, inc_b
      real :: N_decay
      real :: E_0, E_1
      real :: Sigma_m_0, Sigma_1_0, Sigma_1_sf_0, Sigma_3_0
      real :: X_0_init, re_N, X_n, X_0, E_1_init, E_sn, X_c
      real :: E_init = 20000.0
      real :: E_delta = 0.0
       
      character(len=10) :: str
      real :: value
      !str = 'inc_a'
      !value = real(inc_a)
      !call WriteValue(str,value)
      
      if (kstep .eq. 1) then
         ! ����E1����� statev(1)
        ! ��ȡ S11 S22 S33   ��Ϊ���嵥Ԫ����ѹΪ�� s11=simga3 Ϊ��
		if (Time(1).lt.0.2) then 
			statev(1) = E_init
			Field(1) = E_init
		else
              CALL GETVRM('S',ARRAY,JARRAY,FLGRAY,JRCD,JMAC,JMATYP, 
     1        MATLAYO,LACCFLA) 
                      S11 = array(1) 
                      S22 = array(2)
                      S33 = array(3)
                      ! ���ݼ򲼹�ʽ����E
                      Sigma_m_0 = abs(S11 + S22 + S33) / 3.0
                      E_0 = k_soil  * pa * (Sigma_m_0/pa) ** lambda_soil
                      STATEV(1) = E_0 + E_delta ! ���E_0 �ǳ�ʼ�ն�
                      statev(3) = E_0 + E_delta
                      FIELD(1) = E_0 + E_delta
          
                      ! ���� X_0 �����statev(2)
                      Sigma_1_0 = abs(S33)
                      Sigma_3_0 = abs(S11 + S22) / 2.0
                      Sigma_1_sf_0 = ((1+sin(phi_soil))*Sigma_3_0+
     1                          2*c*cos(phi_soil)) / (1-sin(phi_soil)) 
                      X_0_init = Sigma_1_0 / Sigma_1_sf_0
                      STATEV(2) = X_0_init
          end if
! ����ڶ��������� ѭ�����ط�����
      else if (kstep .eq. 2) then      
              ! ��ʼ�ն�
              FIELD(1) = STATEV(1)
              ! �涨��������ģ���ķ�Χ
              inc_a = (T_cyc  - increment) / 2.0 
              inc_b = (T_cyc + increment) / 2.0 
           
              ! ��ȡS11 S22 S33
              CALL GETVRM('S',ARRAY,JARRAY,FLGRAY,JRCD,JMAC,JMATYP, 
     1                            MATLAYO,LACCFLA) 
              S11 = array(1)  ! ����ֱ��ȥabs ��Ϊ���嵥Ԫ����ѹΪ�� s11=simga3 Ϊ��
              S22 = array(2)
              S33 = array(3)

              ! ����N_cyc
              N_cyc = ceiling(Time(1) / T_cyc) !  ����ȡ�� ceiling
              re_N = mod(Time(1) , T_cyc)     ! ������ѭ���е�λ��
              !str = 'Time(1)'
              !value = real(Time(1))
              !call WriteValue(str,value)
        
              ! ��¼E_1 ����һ��ѭ���µ�����ģ��
              if (N_cyc .le. 1) then ! <=
                      if (re_N .lt. inc_a) then   ! <
                              FIELD(1) = STATEV(1)
                      end if
                      if ( re_N .ge. inc_a .AND. re_N .lt. inc_b) then ! inc_a<=re_N < inc_b
                              Sigma_m = abs(S11 + S22 + S33) / 3.0
                              E_1 = k_soil*pa*(Sigma_m/pa)** lambda_soil
                              STATEV(1) = E_1 + E_delta ! ���E_1 �ǵ�һ��ѭ�������߸ն�
                              statev(3) = E_1 + E_delta   ! statev(3)Ϊѭ�����洢E
                              FIELD(1) = E_1 + E_delta
                      end if 
                      if (re_N .ge. inc_b) then   ! >
                              FIELD(1) = STATEV(1)
                      end if
              end if
           
              ! ����E_sn N_cyc > 1
              if (N_cyc .gt. 1) then
                      if (re_N .lt. inc_a) then   ! <
                              FIELD(1) = STATEV(3)
                      end if
                      if ( re_N .ge. inc_a .AND. re_N .lt. inc_b) then
                       ! ����X_n
                              
                              !str = 'S11'
                              !value = real(S11)
                              !call WriteValue(str,value)
                              !str = 'S22'
                              !value = real(S22)
                              !call WriteValue(str,value)
                              !str = 'S33'
                              !value = real(S33)
                              !call WriteValue(str,value)


                              Sigma_1_n =abs(S33)
                              Sigma_3_n = abs(S11+S22)/2.0
                              Sigma_1_sf_n = ((1+sin(phi_soil))*
     1                Sigma_3_n+2*c*cos(phi_soil)) / (1-sin(phi_soil)) 

                              X_n = Sigma_1_n / Sigma_1_sf_n

                              !str = 'X_n'
                              !value = real(X_n)
                              !call WriteValue(str,value)

                              X_0 = statev(2)

                              !str = 'X_0'
                              !value = real(X_0)
                              !call WriteValue(str,value)

                              X_c = abs((X_n-X_0)/(1-X_0))
                              
                              !str = 'X_c'
                              !value = real(X_c)
                              !call WriteValue(str,value)

                              N_decay = real(N_cyc)**(-1*b1*(X_c**b2))
                              
                              !str = 'N_decay'
                              !value = real(N_decay)
                              !call WriteValue(str,value)

                              E_1_init = statev(1)

                              E_sn = E_1_init * N_decay
                              
                              Field(1) = E_sn + E_delta
                              STATEV(3) = E_sn + E_delta
                              
                              
                      end if
                      if (re_N .ge. inc_b) then   ! >
                              FIELD(1) = STATEV(3)
                      end if  
              end if
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