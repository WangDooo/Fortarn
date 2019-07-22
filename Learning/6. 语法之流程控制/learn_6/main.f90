program main
    use func 
    implicit none
    real, parameter :: pi = acos(-1.)
    character (len=:), allocatable :: keywd
    real, allocatable :: pars(:)
    
    do
        call readcmd(keywd, pars)
        
        if (keywd == 'end') then
            exit
        else if (keywd == 'cir' .or. keywd=='sqr') then
            IF (size(pars) /= 1) THEN
                WRITE (*, *) 'Incorrect number of parameters.'
                CYCLE
            END IF
        ELSE IF (keywd=='rect') THEN
            IF (size(pars) /= 2) THEN
                WRITE (*, *) 'Incorrect number of parameters.'
                CYCLE
            END IF
        ELSE
            WRITE (*,*) 'Keyword unknown...'
            CYCLE
        END IF
            
        IF (keywd=='cir') THEN
            WRITE (*, *) 'Area = ', pi*pars(1)**2.
        ELSE IF (keywd=='sqr') THEN
            WRITE (*, *) 'Area = ', pars(1)**2.
        ELSE IF (keywd=='rect') THEN
            WRITE (*, *) 'Area = ', pars(1)*pars(2)
        END IF
    end do
end program