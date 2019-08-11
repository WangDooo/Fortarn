SUBROUTINE UMAT(STRESS,STATEV,DDSDDE,SSE,SPD,SCD,RPL,DDSDDT, &
DRPLDE,DRPLDT,STRAN,DSTRAN,TIME,DTIME,TEMP,DTEMP,PREDEF,DPRED, &
CMNAME,NDI,NSHR,NTENS,NSTATV,PROPS,NPROPS,COORDS,DROT, &
PNEWDT,CELENT,DFGRD0,DFGRD1,NOEL,NPT,LAYER,KSPT,KSTEP,KINC)

include 'aba_param.inc'

CHARACTER(len=80) :: CMNAME

DIMENSION STRESS(NTENS),STATEV(NSTATV),DDSDDE(NTENS,NTENS), &
DDSDDT(NTENS),DRPLDE(NTENS),STRAN(NTENS),DSTRAN(NTENS), &
TIME(2),PREDEF(1),DPRED(1),PROPS(NPROPS),COORDS(3),DROT(3,3), &
DFGRD0(3,3),DFGRD1(3,3), JSTEP(4)

! dstres(6)��������е�Ӧ��         d(3,3) �洢����ϵ���İ�
dimension dstres(6), d(3,3)
! PS(3) �洢����Ӧ�� propss(5) ��¼�洢�����İ�
dimension ps(3), propss(5)

! PROPS(1)~(4) ��Ӧ����� k n v w
FEK = props(1)
FEN = props(2)
FEV = props(3)
FEW = props(4)

! STATEV(1)~(4) ��Ӧ ��ǰΧѹ��G/Gmax��D������Ӧ��ymax
SIG30 = STATEV(1)
GG = STATEV(2)
DD = STATEV(3)
GAMA = STATEV(4)

! ELG ��󶯼���ģ��
ELG = FEK*(SIG30/100)**FEN*100
! ELG <- G
ELG = ELG*GG
! ELM <- Lambda����K �������ģ��
ELM = 2*ELG*FEV/(1-2*FEV)

! ELGT ELMT ��ϵ��
! ELGT �������ϵ��
ELGT = 2*ELG*DD/FEW
! ELMT ����������ϵ��
ELMT = 2*ELM*DD/FEW

!!! ��β������� ��ʱû����
! ����E2=100E1��������������е�����������ԭ�����Ҫ��ֱ�ӵ���ԭ����
ELG1 = ELG/1.01
ELM1 = ELM/1.01
ELGT1 = ELGT/1.01
ELMT1 = ELMT/1.01
EFEI =0.01*ELGT/ELG  !  EFEI <- v~    E1=0.01E2
propss(1) = ELM1     ! ELM <- Lambda����K �������ģ��
propss(2) = ELG1      ! ELG ��󶯼���ģ��
propss(3) = ELMT1   ! ELMT ����������ϵ��
propss(4) = ELGT1    ! ELGT �������ϵ��
propss(5) = EFEI

! ��ǰӦ����
EV = 0.0
DEV = 0.0
do i = 1,NDI
    EV = EV + STRAN(i)
    DEV = DEV + DSTRAN(i)
end do 

! TERM ϵ���м���
TERM1 = 0.5*DTIME+ propss(5)
TERM1I  = 1.0/TERM1 ! ��һ��ϵ��
TERM2 = (0.5*DTIME*propss(1) + propss(3))*TERM1I*DEV
TERM3 = (DTIME*propss(2) + 2.0*propss(4))*TERM1I

! ������Ӧ�� 1~3 11 22 33
do i = 1, NDI
    dstres(i) = TERM2 + TERM3*DSTRAN(i) + DTIME*TERM1I*(propss(1)*EV+2.0*propss(2)*STRAN(i)-STRESS(i))
    STRESS(i) = STRESS(i) + dstres(i)
end do
! ���¼�Ӧ�� 4~6 12 13 23
TERM2 = (0.5*DTIME*propss(2) + propss(4))*TERM1I
j = NDI ! ��ά NDIΪ3 ֱ��Ӧ����Ӧ����� 11 22 33
do i = 1, NSHR ! ��ά NSHR 3 ����Ӧ����Ӧ����� 12 13 23
    j = j + 1
    dstres(j) = TERM2*DSTRAN(j) + DTIME*TERM1I*(propss(2)*STRAN(j) - STRESS(j))
    STRESS(j) = STRESS(j) + dstres(j)
end do

! ����jacobian����
TERM2 = ( DTIME*(0.5*propss(1) + propss(2)) + propss(3) + 2.0*propss(4)) * TERM1I
TERM3 = (0.5*DTIME*propss(1) + propss(3)) * TERM1I
do i = 1, NTENS  ! NDI+ NSHR����Ӧ�������ĸ���
    do j = 1, NTENS
        DDSDDE(j,i) = 0.0
    end do
end do

do i = 1, NDI
    DDSDDE(i,i) = TERM2
end do

do i = 2, NDI
    temp_n = i - 1
    do j = 1, temp_n
        DDSDDE(j,i) = TERM3
        DDSDDE(i,j) = TERM3
    end do
end do

TERM2 = (0.5*DTIME*propss(2)+propss(4))*TERM1I
j = NDI
do i = 1, NSHR
    j = j + 1
    DDSDDE(j,j) = TERM2
end do  
 
! total change in specific energy
TDE = 0
do i = 1, NTENS
    TDE = TDE + (STRESS(i) - 0.5*dstres(i)) * DSTRAN(i)
end do
! change in specific elastic strain energy
TERM1 = propss(1) + 2.0*propss(2)
do i = 1, NDI
    d(i,i) = TERM1
end do

do i = 2, NDI
    temp_n = i -1
    do j = 1, temp_n
        d(i,j) = propss(1)
        d(j,i) = propss(1)
    end do
end do

DEE = 0
do i = 1, NDI
    TERM1 = 0
    TERM2 = 0
    do j = 1,NDI
        TERM1 = TERM1 + d(i,j)*STRAN(j)
        TERM2 = TERM2 + d(i,j)*DSTRAN(j)
    end do
    DEE = DEE + (TERM1+0.5*TERM2)*DSTRAN(i)
end do

j = NDI
do i = 1, NSHR
    j = j + 1
    DEE = DEE + propss(2)*(STRAN(j) + 0.5*DSTRAN(j))*DSTRAN(j)
end do

SSE = SSE + DEE
SCD = SCD + TDE - DEE

! SPRINC��S,PS,LSTR,NDI,NSHR�� ���ڼ�����Ӧ����Ӧ��ֵ��
! ���У�S=Ӧ����Ӧ��������PS��I����I=1,2,3, ��Ӧ����Ӧ��ֵ��
! LSTR=��ʶ��1��ʾSΪӦ��������2��ʾSΪӦ��������

! ���㲢�洢��󶯼�Ӧ��
call SPRINC(STRAN, ps, 2, 3, 3)
GAmax = ((ps(1)-ps(2))**2 + (ps(2)-ps(3))**2 + (ps(3)-ps(1))**2)*2/3
GAmax = SQRT(GAmax)
if(GAMA<GAmax) statev(4) = GAmax
    
return
end subroutine umat