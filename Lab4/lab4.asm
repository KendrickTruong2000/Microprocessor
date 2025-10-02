;Lab 4: Delay loop and Ports
;Define Section
DDRH    EQU     $0262
DRH     EQU     $0260
DRP     EQU     $0258
DDRP    EQU     $025A
DRJ     EQU     $0268
DDRJ    EQU     $026A
DRB     EQU     $0001
DDRB    EQU     $0003
;Main Program
        ORG     $1000
;Set DipSwitch as sending information
        LDAA    #$00
        STAA    DDRH
;Set 7 segments and LED as recieving information
        LDAB    #$FF
        STAB    DDRB
;Set LEDs as receviing information
        LDAA    #$FF
        STAA    DDRJ
;Set LEDs to 0n
        LDAA    #$00
        STAA    DRJ
;Set 7 Segment as reciveing information
        LDAA    $00
        STAA    DDRP
;Set 7 Segment to off
        LDAA    #$FF
        STAA    DRP
START   LDAA    DRH
        STAA    DRB
        BRA     START
        END
        

