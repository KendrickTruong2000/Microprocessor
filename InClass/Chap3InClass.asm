;#o loop * time for one loop = total time delay
;Delay 1 miliseconds
;Main Program
;        ORG $1000
;        JSR TIME
;TIME    PSHY
;        LDY     #6000
;DELAY   DEY
;        BNE     DELAY
;        PULY
;        RTS
;Data Section
;Delay 25 miliseconds
        ORG
	$1000
        JSR     TIME25
TIME25  PSHA    #25
        PSHY
        LDAA    #25
LOOP    LDY     #6000
DELAY   DEY
        BNE     DELAY
        DECA
        BNE     LOOP
        PULY
        PULA
        RTS
;Make Port H as input
        LDAA    #$00
        STAA    $0262
;Make Port B as output
        LDAB    #$FF
        STAB    $0003
        
;1 send information
;0 recieve information

;Define section
DRB     EQU     $0001
DDRB    EQU     $0003
DRH     EQU     $0260
DDRH    EQU     $0262
DRP     EQU     $0258
DDRP    EQU     $025A

;Main Program
        ORG     $1000
        LDAA    #$00
        STAA    DDRH
        LDAA    #$FF
        STAA    DDRB
        LDAA    #$FF
        STAA    DDRP
        LDAA    #$00    ;if FF 7-seg will off
        STAA    DRP
START   LDAA    DRH
        STAA    DRB
        BRA     START
        END
