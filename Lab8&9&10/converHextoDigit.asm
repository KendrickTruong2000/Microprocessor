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
START  	JSR     HTOD
        JSR     DISP
        BRA     START
        
HTOD    PSHA
        PSHB
        PSHX
        LDAA    #0
        LDAB    DRH
        LDX     #$64
        IDIV
        XGDX
        STAB    HUNDS
        XGDX
        LDX     #$0A
        IDIV
        XGDX
        STAB    TENS
        XGDX
        STAB	UNITS
        PULX
        PULB
        PULA
        RTS

DISP    LDAA    #$FD
        STAA    DRP
        LDX     #SEGDIG
        LDAB    HUNDS
        ABX
        LDAA    $00,X
        STAA    DRB
        JSR     DELAY1
        LDAA    #$FB
        STAA    DRP
        LDAB    HUNDS
        ABX
        LDAA    $00,X
        STAA    DRB
        JSR     DELAY1
        LDAA    #$F7
        STAA    DRP
        LDAB    UNITS
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
HUNDS   RMB     1
TENS    RMB     1
UNITS   RMB     1
SEGDIG  FCB     $3F,$06,$5B,$4F,$66,$6D,$7D,$07,$7F,$6F
        END
        