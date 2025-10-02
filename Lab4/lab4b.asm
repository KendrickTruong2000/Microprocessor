;Lab 4: question 2: display LED in binary code 1010101010 and 01010101
;Defin Section
DRB     EQU     $0001   ;Define data address for port B
DDRB    EQU     $0003   ;Define data direction address for port B
DRH     EQU     $0260   ;Define data address for port H
DDRH    EQU     $0262   ;Define data direction address for port H
DRJ     EQU     $0268   ;Define data address for port J
DDRJ    EQU     $026A   ;Define data direction address for port J
DRP     EQU     $0258   ;Define data address for port P
DDRP    EQU     $025A   ;Define data direction address for port P
;Main Section
        ORG     $1000   ;Program start at $1000
;Set dipswitch as output (deactive)
        LDAA    #$FF
        STAA    DDRH
;Set 7-segments, and LEDs as output (enable)
        LDAA    #$FF
        STAA    DDRB
;Select all common cathod of LEDs
        LDAA    #$FF
        STAA    DDRJ
;Turn off all LEDs
        LDAA    #$00
        STAA    DRJ
;Select all common cathod of 7-segments
        LDAA    #$FF
        STAA    DDRP
;Turn off all 7-segments.
        LDAA    #$FF
        STAA    DRP
;Selecting LEDs which turn on which turn off
START   LDAB    #%01010101
        STAB    DRB
;Jump to subroutine to delay between on off time (delay for 250 miliseconds).
        JSR     TIME25
;Select different LEDs pattern.
        LDAB    #%10101010
        STAB    DRB
;Jump to subrountine to delay the switching pattern.
        JSR     TIME25
        BRA     START
FINISH	SWI
;Subrountine.
;Clear register A, Y.
TIME25  PSHA
        PSHY
;Load accumulator A with 250 and Y with 6000
        LDAA    #250
;Every 6000 loop take 1 milisecond. Constantly make 250 times looping 6000 will delay 250 miliseconds
LOOP    LDY     #6000
DELAY   DEY
        BNE     DELAY
        DECA
        BNE     LOOP
        PULY
        PULA
        RTS
        END
;Data Section