;--- Define Equation ---
PRINTF  EQU     $EE88
GETCHAR EQU     $EE84
PUTCHAR EQU     $EE86
;--- Main program ---
        ORG     $1000
;--- Print string ---
        LDD     #STRING
        LDX     PRINTF
        JSR     $00,X
;--- Get string from user input ---
START   PSHA
        PSHB
        PSHD
        PSHX
        LDX     #STR
        STX     VAR
READ_LOOP
        LDX     GETCHAR
        JSR     $00,X
        CMPB    #$1B
        BEQ     END_INPUT
        STAB    TARGET
        LDX     VAR
        STAB    $00,X
        INX
        STX     VAR
        LDAB    TARGET
        LDX     PUTCHAR
        JSR     $00,X
        BRA     READ_LOOP
END_INPUT
        LDD     #NEXTL
        LDX     PRINTF
        JSR     $00,X
        PULX
        PULD
        PULB
        PULA
        BRA     START
DONE    SWI
;--- Data Section
COUNT   RMB     1
NEXTL   FCB     $0D,$0A,$00
STRING  FCC     "CONESTOGA COLLEGE"
        FCB     $0D,$0A,$00
STR     RMB     5
VAR     RMB     2
TARGET  RMB     1
        END