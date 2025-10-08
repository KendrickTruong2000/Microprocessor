;=================================
; Dragon12 Password Input Program
;=================================

DRB     EQU     $0001
DDRB    EQU     $0003
DRJ     EQU     $0268
DDRJ    EQU     $026A
DRP     EQU     $0258
DDRP    EQU     $025A
PRINTF  EQU     $EE88        ;Subrountine for print string
GETCHAR EQU     $EE84         ;Subrountine for getting character from keyboard
PUTCHAR EQU     $EE86        ;Subrountine for outputting single character

        ORG     $1000
        LDAA    #$FF
        STAA    DDRB
        STAA    DDRP
        STAA    DDRJ
        LDAA    #$00
        STAA    DRJ
START   LDX     GETCHAR
        JSR     $00,X
        STAB    TARGET
        CMPB    #$1B
        BEQ     BLINK
        BRA     START
FINISH  SWI

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
DELAY   DEY
        BNE     DELAY
        DECA
        BNE     DELAY_LOOP
        PULY
        PULA
        RTS
TARGET  RMB     1
        END