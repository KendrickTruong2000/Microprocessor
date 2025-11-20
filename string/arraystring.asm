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
        JSR     COMPARE
        BRA     START
        
COMPARE PSHA
        PSHB
        PSHD
        PSHX
        LDAB    #0
CMP_LOOP
        LDX     #KEY
        ABX
        LDAA    $00,X
        LDX     #STR
        ABX
        CMPA    $00,X
        BNE     NOT_EQUAL
        INCB
        CMPB    #3
        BEQ     EQUAL
        BRA     CMP_LOOP
EQUAL   LDD     #EQU_MES
        LDX     PRINTF
        JSR     $00,X
        BRA     END_CMP
NOT_EQUAL
        LDD     #NEQU_MES
        LDX     PRINTF
        JSR     $00,X
        BRA     END_CMP
END_CMP PULX
        PULD
        PULB
        PULA
        RTS

DONE    SWI
;--- Data Section
COUNT   RMB     1
NEXTL   FCB     $0D,$0A,$00
KEY     FCB     $6B,$65,$79
STRING  FCC     "CONESTOGA COLLEGE"
        FCB     $0D,$0A,$00
EQU_MES	FCC     "TWO STRINGS ARE EQUAL"
        FCB     $0D,$0A,$00
NEQU_MES
        FCC     "TWO STRINGS ARE NOT EQUAL"
        FCB     $0D,$0A,$00
STR     RMB     3
VAR     RMB     2
TARGET  RMB     1
FLAG    RMB     1
        END