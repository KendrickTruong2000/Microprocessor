;--- Define Equation ---
DRB     EQU     $0001
DDRB    EQU     $0003
DRP     EQU     $0258
DDRP    EQU     $025A
DRJ     EQU     $0268
DDRJ    EQU     $026A
PRINTF  EQU     $EE88
GETCHAR EQU     $EE84
PUTCHAR EQU     $EE86

;--- Main Program ---
        ORG     $1000
        LDAA    #$FF
        STAA    DDRB
        STAA    DDRP
        STAA    DDRJ
START	LDAB    COUNT
        LDY     #NUMS
	LDAA    #$FE
        STAA    DRP
        LDAA    #$00
LOOP	LDAA    $00,Y
        STAA    DRB
        JSR     FREQ2
        JSR     FREQ2
        JSR     FREQ2
        JSR     FREQ2
        INY
        DECB
        BNE     LOOP
        STAA    $00,Y
        BRA     START
        
FREQ2   PSHA
        PSHY
        LDAA    #250
FREQ_LOOP
        LDY     #6000
DELAY_LOOP
        DEY
        BNE     DELAY_LOOP
        DECA
        BNE     FREQ_LOOP
        PULY
        PULA
        RTS

FINISHI	SWI
;--- Data ---
NUMS    FCB     $3F,$06,$5B,$4F,$66,$6D,$7D,$07,$7F,$6F
COUNT   FCB     $7