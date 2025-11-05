;--- Define equation ---
DRB     EQU         $0001
DDRB    EQU         $0003
DRJ     EQU     $0268
DDRJ    EQU     $026A
DRP     EQU         $0258
DDRP    EQU         $025A
DRH     EQU         $0260
DDRH    EQU         $0262

;--- Main Program ---
        ORG     $1000
        LDAA    #$FF
        STAA    DDRB
        STAA    DDRJ
        STAA    DDRP
        LDAA    #$00
        STAA    DDRH
START          JSR     HTOD
        JSR     DISP
        BRA     START

HTOD    PSHA
        PSHB
        PSHX
        LDAB    DRH
        LDAA    #196
        MUL

        LDX     #10000
        IDIV
        XGDX
        STAB    THOUS
        
        XGDX
        LDX     #1000
        IDIV
        XGDX
        STAB    HUNDS
        
        XGDX
        LDX     #100
        IDIV
        XGDX
        STAB    TENS
        
        XGDX
        LDX     #10
        IDIV
        XGDX
        STAB        UNITS
        PULX
        PULB
        PULA
        RTS

DISP    LDAA    #$FE
        STAA    DRP
        LDX     #SEGDOT
        LDAB    THOUS
        ABX
        LDAA    $00,X
        STAA    DRB
        JSR     DELAY1
        
        LDAA    #$FD
        STAA    DRP
        LDX     #SEGDIG
        LDAB    HUNDS
        ABX
        LDAA    $00,X
        STAA    DRB
        JSR     DELAY1
        
        LDAA    #$FB
        STAA    DRP
        LDX     #SEGDIG
        LDAB    TENS
        ABX
        LDAA    $00,X
        STAA    DRB
        JSR     DELAY1
        
        LDAA    #$F7
        STAA    DRP
        LDAB    UNITS
        LDX     #SEGDIG
        ABX
        LDAA    $00,X
        STAA    DRB
        JSR     DELAY1
        RTS

DELAY1  PSHY
        LDY     #6000
DELAY   DEY
        BNE     DELAY
        PULY
        RTS

;--- Data Section ---
THOUS   RMB     1
HUNDS   RMB     1
TENS    RMB     1
UNITS   RMB     1
SEGDIG  FCB     $3F,$06,$5B,$4F,$66,$6D,$7D,$07,$7F,$6F
SEGDOT  FCB     $BF,$86,$DB,$CF,$E6,$ED,$FD,$87,$FF,$EF
        END