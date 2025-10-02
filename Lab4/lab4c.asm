;Lab 4 C: Display 1234 with 4 7 segments.
;Define Section
DRB     EQU     $0001   ;Define data address for port B
DDRB    EQU     $0003   ;Define data direction address for port B
DRJ     EQU     $0268   ;Define data adress for port J
DDRJ    EQU     $026A   ;Define data direction address for port J
DRP     EQU     $0258   ;Define data address for port P
DDRP    EQU     $025A   ;Define data direction address for port P
;Main Section
        ORG     $1000   ;Program starting at 1000
;Set output mode for port B, P, J.
        LDAA    #$FF
        STAA    DDRB
        STAA    DDRP
        STAA    DDRJ
;Start Displaying number to specific digit on 7-segment.
START   LDAA    #$FE    ;Select digit 3.
        STAA    DRP
        LDAB    #$06    ;Send data number 1 to 7 segment digit 3 to display
        STAB    DRB
        JSR     TIME1   ;Delay 1 milisecond to be visible.
        LDAA    #$FD    ;Select digit 2.
        STAA    DRP
        LDAB    #$5B    ;Send data number 2 to 7 segment digit 2 to display
        STAB    DRB
        JSR     TIME1   ;Delay 1 milisecond to be visible.
        LDAA    #$FB    ;Select digit 1.
        STAA    DRP
        LDAB    #$4F    ;Send data number 3 to 7 segment digit 1 to display
        STAB    DRB
        JSR     TIME1   ;Delay 1 milisecond to be visible.
        LDAA    #$F7    ;Select digit 0.
        STAA    DRP
        LDAB    #$66    ;Send data number 4 to 7 segment digit 0 to display.
        STAB    DRB
        JSR     TIME1   ;Delay 1 milisecond to be visible.
        BRA     START   ;Infinitie loop.
;Subrountine delay 1 milisecond.
TIME1   PSHY
        LDY     #6000
DELAY   DEY
        BNE     DELAY
        PULY
        RTS
;Data Section