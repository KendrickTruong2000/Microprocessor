;Equation Define
DRB     EQU     $0001
DDRB    EQU     $0003
DRJ     EQU     $0268
DDRJ    EQU     $026A
DRP     EQU     $0258
DDRP    EQU     $025A
DDRK    EQU     $0033
PORTK   EQU     $0032
PUTCHAR EQU     $EE86
GETCHAR EQU     $EE84
PRINTF  EQU     $EE88
;Main Program
        ORG     $1000
        JSR     INIT
        LDAA    #$5FF
        STAA    DDRK
        STAA    DDRB
        STAA    DDRJ
        STAA    DDRP
        LDD     COUNT
READ   	JSR     GETCHAR
        CMPA    #$0D
        BEQ     ENDI
        STAA    0,X
        INX
        BRA     READ

ENDI	CLR     0,X

        LDX     #INPAS
        LDY     #PASS
Compare LDAA    0,x
        LDAB    0,y
        CMPA    B
        BNE     NEQUAL
        BEQ     ISEND
ISEND   CMPA    #0
        BEQ     EQUAL
        INX
        INY
        BRA     Compare
EQUAL   LDX     #MESS
        JSR     PRINTF
        BRA     6SECO
NEQUAL  LDAB    $00,D
        DECB
        CMPB
        BNE     READ
        LDD     LMESS
        JSR     PRINTF
ENIRQ   TPA             ;Enable IQR
        ANDA    #%10101111
        TAP
        LDAA    #$40
        STAA    $001E
        JSR     BLINK
FINISH  SWI



;Blink LEDs 10 time
BLINK   LDAB    #10
LOOP    LDAA    #$00
        STAA    DRJ
        JSR     FREQ2
        LDAA    #$FF
        STAA    DRJ
        JSR     FREQ2
        CMPB    #0
        DECB
        BNE     LOOP
        RTS
        END
        
;Blink LEDs with frequency = 2Hz
FREQ2   PSHY
        PSHA
        LDAA    #250
LOOP1   LDY     #6000
DELAY   DEY
        BNE     DELAY
        DECA
        BNE     LOOP1
        PULY
        PULA
        RTS
        END

;Wait for 6 seconds
6SECO   PSHY
        PSHA
        LDAB    #$F7
        STAB    DRP
        LDX     #6
        LDY     #NUMS
        LDAA    #6000
LOOP2   LDY     #6000
DELAY   DEY
        BNE     DELAY
        DECA
        DEX
        STAB    X,Y
        LDAB    DRP
        BNE     LOOP2
        PULY
        PULA
        RTS
        END
        

;Data Section
EMESS	FCC     "ID incorrect Please try again"
LMESS   FCC     "YOUR ACCOUNT IS LOCKED"
MESS    FCC     "Processing, the IRQ will be enabled in 6 second"
COUNT   FCB     3
TARGET  RMB     1
NUMS    FCB     $3F,$06,$5B,$4F,$66,$6D
PASS    FCC     "key",0
INPAS   RMB     3