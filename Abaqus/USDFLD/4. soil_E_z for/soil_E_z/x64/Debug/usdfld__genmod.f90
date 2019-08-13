        !COMPILER-GENERATED INTERFACE MODULE: Tue Aug 13 19:48:05 2019
        MODULE USDFLD__genmod
          INTERFACE 
            SUBROUTINE USDFLD(FIELD,STATEV,PNEWDT,DIRECT,T,CELENT,TIME, &
     &DTIME,CMNAME,ORNAME,NFIELD,NSTATV,NOEL,NPT,LAYER,KSPT,KSTEP,KINC, &
     &NDI,NSHR,COORD,JMAC,JMATYP,MATLAYO,LACCFLA)
              INTEGER(KIND=4) :: NSTATV
              INTEGER(KIND=4) :: NFIELD
              REAL(KIND=8) :: FIELD(NFIELD)
              REAL(KIND=8) :: STATEV(NSTATV)
              REAL(KIND=8) :: PNEWDT
              REAL(KIND=8) :: DIRECT(3,3)
              REAL(KIND=8) :: T(3,3)
              REAL(KIND=8) :: CELENT
              REAL(KIND=8) :: TIME(2)
              REAL(KIND=8) :: DTIME
              CHARACTER(LEN=80) :: CMNAME
              CHARACTER(LEN=80) :: ORNAME
              INTEGER(KIND=4) :: NOEL
              INTEGER(KIND=4) :: NPT
              INTEGER(KIND=4) :: LAYER
              INTEGER(KIND=4) :: KSPT
              INTEGER(KIND=4) :: KSTEP
              INTEGER(KIND=4) :: KINC
              INTEGER(KIND=4) :: NDI
              INTEGER(KIND=4) :: NSHR
              REAL(KIND=8) :: COORD(*)
              INTEGER(KIND=4) :: JMAC(*)
              INTEGER(KIND=4) :: JMATYP(*)
              INTEGER(KIND=4) :: MATLAYO
              INTEGER(KIND=4) :: LACCFLA
            END SUBROUTINE USDFLD
          END INTERFACE 
        END MODULE USDFLD__genmod
