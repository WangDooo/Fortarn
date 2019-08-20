program main
    implicit none
    
    real :: E_now
    real :: E_m
    
    real :: Time
    real ::  remainder 
    real :: T = 2.0
    integer :: N 
    real, parameter :: T_cyc = 2.0
    real, parameter :: inc = 0.1
    
      real,parameter :: k_soil = 560.0
      real,parameter :: pa=100.0
      real,parameter :: lambda_soil = 1.0
      real :: Sigma_m_0 
      real :: E_0
        
      character(len=10) :: str
      real :: value



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
    
    Time = 0.3
    remainder  = mod(Time,T)
    N = ceiling(Time/T)
    write(*,*) remainder
    write(*,*) N
    write(*,*) (T_cyc - inc) / 2.0
    
    Sigma_m_0 = 423.366

    E_0 = k_soil  * pa * (Sigma_m_0/pa) ** lambda_soil
   write(*,*) E_0
end program main