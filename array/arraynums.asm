;--- Define Equation ---
DRB     EQU     $0001
DDRB    EQU     $0003
DRP     EQU     $0258
DDRP    EQU     $025A
DRJ     EQU     $0268
DDRJ    EQU     $026A
;--- Main Program ---
        ORG     $1000
        LDAA    #$FF
        STAA    DDRB
        STAA    DDRP
        STAA    DDRJ
;--- Extract value in NUMS one-by-one.
;START   LDAB    COUNT
;        LDY     #NUMS
;        LDAA    #$FE
;        STAA    DRP
;        LDAA    #$00
;LOOP    LDAA    $00,Y
;        STAA    DRB
;        JSR     DELAY
;        JSR     DELAY
;        JSR     DELAY
;        JSR     DELAY
;        INY
;        DECB
;        BNE     LOOP
;        STAA    $00,Y
;        BRA     START
        
;--- Extract value at specific index ---
START   LDAB    #$0
        LDAA    #$FE
        STAA    DRP
LOOP    STAB    COUNT
        JSR     DISPLAY
        JSR     DELAY
        JSR     DELAY
        JSR     DELAY
        JSR     DELAY
        INCB
        CMPB    #$A
        BNE     LOOP
;--- Select index with COUNT
DISPLAY LDX     #NUMS
        LDAB    COUNT
        ABX
        LDAA    $00,X
        STAA    DRB
        RTS
        
DELAY   PSHA
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

FINISH  SWI
;--- Data Section ---
NUMS    FCB     $3F,$06,$5B,$4F,$66,$6D,$7D,$07,$7F,$6F
;COUNT   FCB     $9
COUNT   RMB     1
        END