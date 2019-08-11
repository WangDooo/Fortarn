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

! dstres(6)计算过程中的应力         d(3,3) 存储过程系数的吧
dimension dstres(6), d(3,3)
! PS(3) 存储三个应变 propss(5) 记录存储变量的吧
dimension ps(3), propss(5)

! PROPS(1)~(4) 对应输入的 k n v w
FEK = props(1)
FEN = props(2)
FEV = props(3)
FEW = props(4)

! STATEV(1)~(4) 对应 震前围压、G/Gmax、D、最大剪应变ymax
SIG30 = STATEV(1)
GG = STATEV(2)
DD = STATEV(3)
GAMA = STATEV(4)

! ELG 最大动剪切模量
ELG = FEK*(SIG30/100)**FEN*100
! ELG <- G
ELG = ELG*GG
! ELM <- Lambda或者K 材料体积模量
ELM = 2*ELG*FEV/(1-2*FEV)

! ELGT ELMT 黏壶系数
! ELGT 剪切黏滞系数
ELGT = 2*ELG*DD/FEW
! ELMT 材料体积黏滞系数
ELMT = 2*ELM*DD/FEW

!!! 这段参数调整 暂时没看到
! 假设E2=100E1，将输入参数进行调整，以满足原程序的要求，直接调用原程序
ELG1 = ELG/1.01
ELM1 = ELM/1.01
ELGT1 = ELGT/1.01
ELMT1 = ELMT/1.01
EFEI =0.01*ELGT/ELG  !  EFEI <- v~    E1=0.01E2
propss(1) = ELM1     ! ELM <- Lambda或者K 材料体积模量
propss(2) = ELG1      ! ELG 最大动剪切模量
propss(3) = ELMT1   ! ELMT 材料体积黏滞系数
propss(4) = ELGT1    ! ELGT 剪切黏滞系数
propss(5) = EFEI

! 当前应变量
EV = 0.0
DEV = 0.0
do i = 1,NDI
    EV = EV + STRAN(i)
    DEV = DEV + DSTRAN(i)
end do 

! TERM 系数中间量
TERM1 = 0.5*DTIME+ propss(5)
TERM1I  = 1.0/TERM1 ! 第一个系数
TERM2 = (0.5*DTIME*propss(1) + propss(3))*TERM1I*DEV
TERM3 = (DTIME*propss(2) + 2.0*propss(4))*TERM1I

! 更新正应力 1~3 11 22 33
do i = 1, NDI
    dstres(i) = TERM2 + TERM3*DSTRAN(i) + DTIME*TERM1I*(propss(1)*EV+2.0*propss(2)*STRAN(i)-STRESS(i))
    STRESS(i) = STRESS(i) + dstres(i)
end do
! 更新剪应力 4~6 12 13 23
TERM2 = (0.5*DTIME*propss(2) + propss(4))*TERM1I
j = NDI ! 三维 NDI为3 直接应力、应变个数 11 22 33
do i = 1, NSHR ! 三维 NSHR 3 剪切应力、应变个数 12 13 23
    j = j + 1
    dstres(j) = TERM2*DSTRAN(j) + DTIME*TERM1I*(propss(2)*STRAN(j) - STRESS(j))
    STRESS(j) = STRESS(j) + dstres(j)
end do

! 创建jacobian矩阵
TERM2 = ( DTIME*(0.5*propss(1) + propss(2)) + propss(3) + 2.0*propss(4)) * TERM1I
TERM3 = (0.5*DTIME*propss(1) + propss(3)) * TERM1I
do i = 1, NTENS  ! NDI+ NSHR，总应力分量的个数
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

! SPRINC（S,PS,LSTR,NDI,NSHR） 用于计算主应力或应变值。
! 其中：S=应力或应变张量；PS（I），I=1,2,3, 主应力或应变值；
! LSTR=标识，1表示S为应力张量，2表示S为应变张量。

! 计算并存储最大动剪应变
call SPRINC(STRAN, ps, 2, 3, 3)
GAmax = ((ps(1)-ps(2))**2 + (ps(2)-ps(3))**2 + (ps(3)-ps(1))**2)*2/3
GAmax = SQRT(GAmax)
if(GAMA<GAmax) statev(4) = GAmax
    
return
end subroutine umat