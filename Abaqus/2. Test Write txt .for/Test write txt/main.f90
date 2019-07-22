SUBROUTINE UMAT(STRESS,STATEV,DDSDDE,SSE,SPD,SCD,RPL,DDSDDT, &
DRPLDE,DRPLDT,STRAN,DSTRAN,TIME,DTIME,TEMP,DTEMP,PREDEF,DPRED, &
CMNAME,NDI,NSHR,NTENS,NSTATV,PROPS,NPROPS,COORDS,DROT, &
PNEWDT,CELENT,DFGRD0,DFGRD1,NOEL,NPT,LAYER,KSPT,KSTEP,KINC)

include 'aba_param.inc'

CHARACTER(len=80) :: CMNAME

DIMENSION STRESS(NTENS),STATEV(NSTATV),DDSDDE(NTENS,NTENS), &
DDSDDT(NTENS),DRPLDE(NTENS),STRAN(NTENS),DSTRAN(NTENS), &
TIME(2),PREDEF(1),DPRED(1),PROPS(NPROPS),COORDS(3),DROT(3,3), &
DFGRD0(3,3),DFGRD1(3,3)

character(len=10) :: str
real :: value

if (ndi.ne.3) then
    write(6,*) 'this umat may only be used for 3D'
end if 

! elastic properties
E = props(1)
v = props(2)
k3 = E/(1-2*v)
g2 = E/(1+v)
g = g2 / 2
lam = (k3-g2)/3

! write DDSDDE
do i = 1, NDI
    do j = 1, NDI
        DDSDDE(j,i) = lam
    end do
    DDSDDE(i,i) = g2+lam
end do

do i = NDI+1, NTENS
    DDSDDE(i,i) = g
end do

! clac stress
do i = 1, NTENS
    do j = 1, NTENS
        STRESS(j) = STRESS(j) + DDSDDE(j,i)*DSTRAN(i)
    end do
end do

str = 'v'
value = real(v)
call WriteValue(str,value)

!open (Unit=222, file="C:\Users\123\Desktop\test_all.txt")
!do i = 1, NTENS
!    do j = 1, NTENS
!        STRESS(j) = STRESS(j) + DDSDDE(j,i)*DSTRAN(i)
!        write(222,*) STRESS(j)
!    end do
!end do
!close(222)


return
end subroutine umat


subroutine WriteValue(name,value)
    character(len=10) :: name
    real :: value
    open (Unit=123, file="C:\Users\123\Desktop\test_value.txt", position='append')
        write(123,'(a10," = ",f12.6)') name, value
    close(123)
end subroutine

    
    
    