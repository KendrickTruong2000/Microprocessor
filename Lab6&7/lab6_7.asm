;Lab 6 & 7
;--- Define Equation Section ---
DRB     EQU     $0001
DDRB    EQU     $0003
DRP     EQU     $0258
DDRP    EQU     $025A
DRJ     EQU     $0268
DDRJ    EQU     $026A

;--- Main Program
        ORG     $1000
        LDAA    #$FF
        STAA    DDRB
        STAA    DDRP    ;Set PORT B, P to output.
        LDAA    #$00
        STAA    DRP     ;Turn ALL 7-segment off
        TPA
        ANDA    #%10101111
        TAP
        LDAA    #$40
        STAA    $001E
        LDS     #$2000
        LDD     #IRQISR ;Call maskable interrupt
        STD     $3E72
        LDD     #XIRQISR;Call non-maskable interrupt
        STD     $3E74
HERE    BRA     HERE

XIRQISR	LDAA    #$FE    ;Select Digit 3
        STAA    DRP
        LDX     #NUMS   ;Load array nums into X
        LDAA    $00,X   ;Load value of index 0 from X to A
        STAA    DRB     ;Display Number 0 to 7-segment.
        JSR     FREQ2
        JSR     FREQ2
        JSR     FREQ2
        JSR     FREQ2
        LDAA    $01,X
        STAA    DRB
        JSR     FREQ2
        JSR     FREQ2
        JSR     FREQ2
        JSR     FREQ2
        LDAA    $02,X
        STAA    DRB
        JSR     FREQ2
        JSR     FREQ2
        JSR     FREQ2
        JSR     FREQ2
        LDAA    $03,X
        STAA    DRB
        JSR     FREQ2
        JSR     FREQ2
        JSR     FREQ2
        JSR     FREQ2
        LDAA    $04,X
        STAA    DRB
        JSR     FREQ2
        JSR     FREQ2
        JSR     FREQ2
        JSR     FREQ2
        LDAA    $05,X
        STAA    DRB
        JSR     FREQ2
        JSR     FREQ2
        JSR     FREQ2
        JSR     FREQ2
        LDAA    $06,X
        STAA    DRB
        JSR     FREQ2
        JSR     FREQ2
        JSR     FREQ2
        JSR     FREQ2
        RTI

IRQISR  LDAA    #$FF
        STAA    DDRB
        STAA    DDRP
        STAA    DDRJ
        STAA    DRP
        JSR     BLINK
        RTI

BLINK   LDAA    #10
BLINK_LOOP
        LDAB    #%11111111
        STAB    DRB
        JSR     FREQ2
        LDAB    #%00000000
        STAB    DRB
        JSR     FREQ2
        DECA
        BNE     BLINK_LOOP
        RTS

FREQ2   PSHA
        PSHY
        LDAA    #250
DELAY_LOOP
        LDY     #6000
FREQ_DELAY
        DEY
        BNE     FREQ_DELAY
        DECA
        BNE     DELAY_LOOP
        PULY
        PULA
        RTS
        
        END
;DATA
NUMS    FCB     $3F,$06,$5B,$4F,$66,$6D,$7D,$07,$7F,$6F
TARGET  RMB     1
        
        