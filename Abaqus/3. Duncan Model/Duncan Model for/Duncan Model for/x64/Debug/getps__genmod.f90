        !COMPILER-GENERATED INTERFACE MODULE: Mon Jul 15 19:47:54 2019
        MODULE GETPS__genmod
          INTERFACE 
            SUBROUTINE GETPS(STRESS,PS,NTENS)
              INTEGER(KIND=4) :: NTENS
              REAL(KIND=8) :: STRESS(NTENS)
              REAL(KIND=8) :: PS(3)
            END SUBROUTINE GETPS
          END INTERFACE 
        END MODULE GETPS__genmod
