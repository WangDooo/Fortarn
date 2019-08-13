program main
    implicit none
    
    real :: E_now
    real :: E_m
    
    
    !integer :: i
    !do i =1, 20
    !    write(*,*) i, Selected_Int_Kind(i)
    !end do
    
    !integer , parameter :: KI  = Selected_Int_Kind(9)
    !integer(Kind=KI) :: i = 0, j, k
    !write(*,*) kind(i), i
    !write(*,*) huge(i)
    !i = i + 100_KI
    !write(*,*) i
    
    !integer, parameter :: DP = Selected_Real_Kind(r=50,p=14)
    !Real(Kind=DP) :: r1=1.0_DP, r2, r3
    !write(*,*) kind(r1), r1
    !r1 = r1 + 1.6_DP
    !write(*,*) r1
    !r1 = r1 + 1.6 ! 常数如果没有Kind值就会产生误差
    !write(*,*) r1 
    
    character(len=13) :: c="www.??????.cn"
    c(5:10) = "wangbc"
    write(*,*) c
    c(:3) = "bbs"
    write(*,*) c
    c(10:) = ""
    write(*,*) c
    E_now = 10000.0*TAN(38.0/180.0*3.1415)*sqrt(9.5*(10.0-0.0))
    write(*,*) E_now
    
    E_m = 560*100*(2.6/100)**0.6
    write(*,*) E_m
end program main