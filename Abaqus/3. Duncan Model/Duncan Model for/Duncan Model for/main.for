      SUBROUTINE UMAT(STRESS,STATEV,DDSDDE,SSE,SPD,SCD,
     1RPL,DDSDDT,DRPLDE,DRPLDT,
     2STRAN,DSTRAN,TIME,DTIME,TEMP,DTEMP,PREDEF,DPRED,CMNAME,
     3NDI,NSHR,NTENS,NSTATV,PROPS,NPROPS,COORDS,DROT,PNEWDT,
     4CELENT,DFGRD0,DFGRD1,NOEL,NPT,LAYER,KSPT,JSTEP,KINC)

      include 'aba_param.inc'

      CHARACTER*80 CMNAME

      DIMENSION STRESS(NTENS),STATEV(NSTATV),DDSDDE(NTENS,NTENS), 
     1DDSDDT(NTENS),DRPLDE(NTENS),STRAN(NTENS),DSTRAN(NTENS), 
     2TIME(2),PREDEF(1),DPRED(1),PROPS(NPROPS),COORDS(3),DROT(3,3), 
     3DFGRD0(3,3),DFGRD1(3,3), JSTEP(4)

C     PS(3) 存储三个主应力 DSTRESS(NTENS) 存储应力增量
      dimension PS(3), DSTRESS(NTENS)
      PARAMETER (ONE=1.0D0,TWO=2.0D0,THREE=3.0D0,SIX=6.0D0)

C     读取User Material 分别为 K n Rf c fai G D F Kur pa delatfai
      EK = props(1)
      EN = props(2)
      RF = props(3)
      c = props(4)
      FAI = props(5) / 180.0 * 3.1415925
      UG = props(6)
      UD = props(7)
      UF = props(8)
      EKUR = props(9)
      PA = props(10)
      DFAI = props(11) / 180.0 * 3.1415925

C      ! 三个状态量依次为历史最大偏应力 固结应力 应力水平
      S1S30 = STATEV(1)
      S30 = STATEV(2)
      SSS = STATEV(3)

C      ! 用子程序获得三个主应力 存在PS中 PS(1) 最大 8 5 2
      call GetPS(STRESS, PS, NTENS)

C      !!! 这个FAI的处理没看懂
      FAI = FAI - DFAI*LOG10(S30/PA)
C      !!! 这个ENU EMOD S 是哪来的 这个call 可以这样写的吗
C      ! 用子程序求得与应力状态相对应的弹模
      call GetEmod(PS, EK, EN, RF, C, FAI, ENU, PA, EKUR, EMOD, S, S30, 
     1UG, UD, UF, SSS, S1S30)
C      ! 经典的E v的关系计算
      EBULK3 = EMOD / (1.0-2.0*ENU)
      EG2 = EMOD / (1.0+ENU)
      EG = EG2 / 2.0
      EG3 = EG * 3.0
      ELAM = (EBULK3-EG2) / 3.0
C      ! 获得刚度矩阵
      call GetDDSDDE(DDSDDE, NTENS, NDI, ELAM, EG2, EG)
C      ! 按增量应变计算增量应力
      DSTRESS = 0.0
      call GetStress(DDSDDE, DSTRESS, DSTRAN, NTENS)
C     ! 更新应力
      do i = 1, NTENS
          STRESS(i) = STRESS(i) + DSTRESS(i)
      end do

C      !更新状态变量
      call GetPS(STRESS, PS, NTENS)
      call GetEmod(PS, EK, EN, RF, C, FAI, ENU, PA, EKUR, EMOD, S, S30,
     1UG, UD, UF, SSS, S1S30)
      EBULK3 = EMOD / (1.0-2.0*ENU)
      EG2 = EMOD / (1.0+ENU)
      EG = EG2 / 2.0
      EG3 = EG * 3.0
      ELAM = (EBULK3-EG2) / 3.0
C     ! 按增量不终点应力状态确定刚度矩阵 并赋值给DDSDDE矩阵
      call GetDDSDDE(DDSDDE, NTENS, NDI, ELAM, EG2, EG)
      if (PS(3) > S30) S30 = PS(3)
      if ((PS(1)-PS(3))>S1S30) S1S30=PS(1)-PS(3)
      if (S > SSS) SSS = S
      STATEV(1) = S1S30
      STATEV(2) = S30
      STATEV(3) = SSS

      return
      end subroutine umat
    
C      ! 求出三个主应力，并改变符合以压为正，从大到小按顺序排列
      subroutine GetPS(STRESS, PS, NTENS)
      include 'aba_param.inc'
      dimension PS(3), STRESS(NTENS)

C      ! SPRINC（S,PS,LSTR,NDI,NSHR） 用于计算主应力或应变值。
C      ! 其中：S=应力或应变张量；PS（I），I=1,2,3, 主应力或应变值；
C      ! LSTR=标识，1表示S为应力张量，2表示S为应变张量。

      call SPRINC(STRESS, PS, 1, 3, 3)
C      ! 排列出最大最小值 PS(）中是类似这个排序 -8 -5 -2
      do i = 1,2
          do j = i + 1, 3
              if (PS(i) > PS(j)) then
                  PS_temp = PS(i)
                  PS(i) = PS(j)
                  PS(j) = PS_temp
              end if
          end do
      end do

C      ! 以压为正 PS(）中是类似这个排序 8 5 2
      do i = 1,3
          PS(i) = -PS(i)
      end do

      return
      end subroutine GetPS

C      ! 求得与应力状态相对应的EMOD ENU 这个部分就是书写公式
      subroutine GetEmod(PS, EK, EN, RF, C, FAI, ENU, PA, EKUR, EMOD, S, 
     1S30, UG, UD, UF, SSS, S1S30)
      include 'aba_param.inc'
      dimension PS(3)
C      ! 求应力水平
      S = (1-sin(FAI))*(PS(1)-PS(3))
      if (PS(3) < (-C/tan(FAI))) then
          S = 0.99
      else
          S = S/(2*C*cos(FAI)+2*PS(3)*sin(FAI))
          if (S > 0.99) S=0.99
      end if

C      ! 确定切线模量
      EMOD = EK*PA*((S30/PA)**EN)*((1-RF*S)**2)

C      ! 求出泊松比
      AA = UD*(PS(1)-PS(3))
      AA = AA / (EK*PA*((S30/PA)**EN))
      AA = AA / (1-RF*S)
      ENU = UG - UF*LOG10(S30/PA)
      ENU = ENU / (1-AA) / (1-AA)
      if (ENU > 0.49) ENU = 0.49
      if (ENU < 0.05) ENU = 0.05

C      ! 采用回弹模量
      if (S < SSS .AND. (PS(1)-PS(3))< S1S30 ) then 
          EMOD = EKUR*PA*((S30/PA)**EN)
      end if

      end subroutine GetEmod
    
C      ! 标准的根据 G 拉梅常数 生成DDSDDE
      subroutine GetDDSDDE(DDSDDE, NTENs, NDI, ELAM, EG2, EG)
      include 'aba_param.inc'
      dimension DDSDDE(NTENS, NTENS)
C      ! 初始化 DDSDDE
      do i = 1, NTENS
          do j = 1, NTENS
              DDSDDE(i,j) = 0.0
          end do
      end do
C     ! 向DDSDDE中填值
      do i = 1, NDI
          do j = 1, NDI
              DDSDDE(j,i) = ELAM
          end do
          DDSDDE(i,i) = EG2 + ELAM
      end do
      do i = NDI+1, NTENS
          DDSDDE(i,i) = EG
      end do

      return
      end subroutine GetDDSDDE

    
C      ! 按应变增量求解应力增量
      subroutine GetStress(DDSDDE, STRESS, DSTRAN, NTENS)
      include 'aba_param.inc'
      dimension DDSDDE(NTENS, NTENS), STRESS(NTENS), DSTRAN(NTENS)
      do i = 1, NTENS
          do j = 1, NTENS
              stress(j) = stress(j) + DDSDDE(j,i) * DSTRAN(i)
          end do
      end do
      return
      end subroutine GetStress
