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

! PS(3) �洢������Ӧ�� DSTRESS(NTENS) �洢Ӧ������
dimension PS(3), DSTRESS(NTENS)

! ��ȡUser Material �ֱ�Ϊ K n Rf c fai G D F Kur pa delatfai
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

! ����״̬������Ϊ��ʷ���ƫӦ�� �̽�Ӧ�� Ӧ��ˮƽ
S1S30 = STATEV(1)
S30 = STATEV(2)
SSS = STATEV(3)

! ���ӳ�����������Ӧ�� ����PS�� PS(1) ��� 8 5 2
call GetPS(STRESS, PS, NTENS)

!!! ���FAI�Ĵ���û����
FAI = FAI - DFAI*LOG10(S30/PA)
!!! ���ENU EMOD S �������� ���call ��������д����
! ���ӳ��������Ӧ��״̬���Ӧ�ĵ�ģ
call GetEmod(PS, EK, EN, RF, C, FAI, ENU, PA, EKUR, EMOD, S, S30, UG, UD, UF, SSS, S1S30)
! �����E v�Ĺ�ϵ����
EBULK3 = EMOD / (1.0-2.0*ENU)
EG2 = EMOD / (1.0+ENU)
EG = EG2 / 2.0
EG3 = EG * 3.0
ELAM = (EBULK3-EG2) / 3.0
! ��øնȾ���
call GetDDSDDE(DDSDDE, NTENS, NDI, ELAM, EG2, EG)
! ������Ӧ���������Ӧ��
DSTRESS = 0.0
call GetStress(DDSDDE, DSTRESS, DSTRAN, NTENS)
! ����Ӧ��
do i = 1, NTENS
    STRESS(i) = STRESS(i) + DSTRESS(i)
end do

!����״̬����
call GetPS(STRESS, PS, NTENS)
call GetEmod(PS, EK, EN, RF, C, FAI, ENU, PA, EKUR, EMOD, S, S30, UG, UD, UF, SSS, S1S30)
EBULK3 = EMOD / (1.0-2.0*ENU)
EG2 = EMOD / (1.0+ENU)
EG = EG2 / 2.0
EG3 = EG * 3.0
ELAM = (EBULK3-EG2) / 3.0
! ���������յ�Ӧ��״̬ȷ���նȾ��� ����ֵ��DDSDDE����
call GetDDSDDE(DDSDDE, NTENs, NDI, ELAM, EG2, EG)
if (PS(3) > S30) S30 = PS(3)
if ((PS(1)-PS(3))>S1S30) S1S30=PS(1)-PS(3)
if (S > SSS) SSS = S
STATEV(1) = S1S30
STATEV(2) = S30
STATEV(3) = SSS

return
end subroutine umat

    
! ���������Ӧ�������ı������ѹΪ�����Ӵ�С��˳������
subroutine GetPS(STRESS, PS, NTENS)
include 'aba_param.inc'
dimension PS(3), STRESS(NTENS)

! SPRINC��S,PS,LSTR,NDI,NSHR�� ���ڼ�����Ӧ����Ӧ��ֵ��
! ���У�S=Ӧ����Ӧ��������PS��I����I=1,2,3, ��Ӧ����Ӧ��ֵ��
! LSTR=��ʶ��1��ʾSΪӦ��������2��ʾSΪӦ��������

call SPRINC(STRESS, PS, 1, 3, 3)
! ���г������Сֵ PS(����������������� -8 -5 -2
do i = 1,2
    do j = i + 1, 3
        if (PS(i) > PS(j)) then
            PS_temp = PS(i)
            PS(i) = PS(j)
            PS(j) = PS_temp
        end if
    end do
end do

! ��ѹΪ�� PS(����������������� 8 5 2
do i = 1,3
    PS(i) = -PS(i)
end do

return
end subroutine GetPS

! �����Ӧ��״̬���Ӧ��EMOD ENU ������־�����д��ʽ
subroutine GetEmod(PS, EK, EN, RF, C, FAI, ENU, PA, EKUR, EMOD, S, S30, UG, UD, UF, SSS, S1S30)
include 'aba_param.inc'
dimension PS(3)
! ��Ӧ��ˮƽ
S = (1-sin(FAI))*(PS(1)-PS(3))
if (PS(3) < (-C/tan(FAI))) then
    S = 0.99
else
    S = S/(2*C*cos(FAI)+2*PS(3)*sin(FAI))
    if (S > 0.99) S=0.99
end if

! ȷ������ģ��
EMOD = EK*PA*((S30/PA)**EN)*((1-RF*S)**2)

! ������ɱ�
AA = UD*(PS(1)-PS(3))
AA = AA / (EK*PA*((S30/PA)**EN))
AA = AA / (1-RF*S)
ENU = UG - UF*LOG10(S30/PA)
ENU = ENU / (1-AA) / (1-AA)
if (ENU > 0.49) ENU = 0.49
if (ENU < 0.05) ENU = 0.05

! ���ûص�ģ��
if (S < SSS .AND. (PS(1)-PS(3))< S1S30 ) then 
    EMOD = EKUR*PA*((S30/PA)**EN)
end if

end subroutine GetEmod
    
! ��׼�ĸ��� G ��÷���� ����DDSDDE
subroutine GetDDSDDE(DDSDDE, NTENS, NDI, ELAM, EG2, EG)
include 'aba_param.inc'
dimension DDSDDE(NTENS, NTENS)
! ��ʼ�� DDSDDE
do i = 1, NTENS
    do j = 1, NTENS
        DDSDDE(i,j) = 0.0
    end do
end do
! ��DDSDDE����ֵ
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

    
! ��Ӧ���������Ӧ������
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