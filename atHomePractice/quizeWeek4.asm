;Quize week 4
;Question 1. x * time for one loop = total time delay
; x * 4 cycle * T, T = 1/ 2MHz = 0.042 uSec, x = T/ 4 * 0.042 = 4464
        ORG     $1000
        JSR     TIME075 ;Jump to subroutine delay 750 microseconds.
TIME075 PSHY
        LDY     4500    ;Loop 4500 time to make a delay for 750 microseconds.
DELAY   DEY
        BNE     DELAY
        PULY
        RTS

;Question 2. T = 1/ 4Hz = 250 milisec, LED on for 125 milisec and off for 125 milsec => LEDs blink at 250 milisec 4 Hz
DRB     EQU     $0001   ;Define Data port B address.
DDRB    EQU     $0003   ;Define Data Direction port B address.
DRJ     EQU     $0268   ;Define Data port J address.
DDRJ    EQU     $026A   ;Define Data Direction port J address.
DRP     EQU     $0258   ;Define Data port P address.
DDRP    EQU     $025A   ;Define Data Direction address port P.
;Main Program
	ORG     $1000
        LDAA    #$FF
        STAA    DDRB    ;Set Data Direction port B to output.
        STAA    DDRJ    ;Set Data Direction port J to output.
        STAA    DDRP    ;Set Data Direction port P to output.
        STAA    DRP     ;Set Data port P to output
START   LDAB    #%11111111      ;Turn on all LEDs
        STAB    DRB
        JSR     TIME125 ;Jump subroutine to delay
        LDAB    #%00000000      ; Turn off all LEDs
        STAB    DRB
        JSR     TIME125 ;Jump to subroutine to delay
        BRA     START
FINISH	SWI

TIME125 PSHY            ;Subroutine delay 250 milisec -> 4 Hz
        PSHA
        LDAA    #125    ;Do 125 loop to delay 125 milisecond.
LOOP    LDY     #6000   ;Each loop is 1 milisecond
DELAY1  DEY
        BNE     DELAY1
        DECA
        BNE     LOOP
        END