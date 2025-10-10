;Midterm Assignment
;--- Define Equation Section ---
DRB     EQU     $0001
DDRB    EQU     $0003
DRP     EQU     $0258
DDRP    EQU     $025A
DRJ     EQU     $0268
DDRJ    EQU     $026A
PRINTF  EQU     $EE88
GETCHAR EQU     $EE84
PUTCHAR EQU     $EE86

;--- Main Program
        ORG     $1000
        LDAA    #$FF
        STAA    DDRB
        STAA    DDRP    ;Set PORT B, P to output.
        STAA    DDRJ
        LDAA    #$00
        STAA    DRP     ;Turn ALL 7-segment off

;START   LDD     PROMPT
;        LDX     PRINTF
;        JSR     $00,X
;        LDX     GETCHAR
;        JSR     $00,X
;        STAB    TARGET
;        CMPB    #$74
;        BEQ     FINISH
;        CMPB    #$75
;        BEQ     WRONG
;        CMPB    #$64
;        BEQ     MATCH
;        BRA     START
START	LDD     #PROMPT
        LDX     PRINTF
        JSR     $00,X
        LDY     #BUFFER
        
READ_LOOP
        LDX     GETCHAR
        JSR     $00,X
        STAB    TARGET
        CMPB    #$6B
        BEQ     CHECKE
CHECKE	CMPB    #$65
        BEQ     CHECKY
CHECKY	CMPB    #$79
        BEQ     CHECKESC
CHECKESC
        CMPB    #$1B
        BEQ     MATCH
        BRA 	READ_LOOP

;--- Compare Subroutine
;COMPARE LDAA    0,X
;        LDAB    0,Y
;        CMPA    #0
;        BEQ     MATCH
;        CBA
;        BNE     WRONG
;        INX
;        INY
;        BRA     COMPARE

;--- MATCH Subroutine
MATCH   LDD     #SUCCESS
        LDX     PRINTF
        JSR     0,X
        JSR     WAIT6
        TPA
        ANDA    #%10101111
        TAP
        LDAA    #$40
        STAA    $001E
        LDS     #$2000
        LDD     #IRQISR ;Call maskable interrupt
        STD     $3E72
HERE    BRA     HERE
        RTS
        
;--- WRONG Subroutine
WRONG   LDD     #FAIL
        LDX     PRINTF
        JSR     0,X
        RTS

;--- IRQISR Subroutine
IRQISR  LDAA    #$FF
        STAA    DDRB
        STAA    DDRP
        STAA    DDRJ
        STAA    DRP
        JSR     BLINK
        RTI

;--- WAIT 6 Second
WAIT6   LDAA    #$FE
        STAA    DRP
        LDX     #NUMS
        LDAA    $00,X
        STAA    DRB
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
        RTS

;--- Blink LEDs 10 times
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
        
;--- Frequency 2Hz
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
        
FINISH  SWI
        
;--- DATA
NUMS    FCB     $3F,$06,$5B,$4F,$66,$6D,$7D,$07,$7F,$6F
TARGET  RMB     1
PROMPT  FCC     "Enter Password: "
        FCB     $0D,$0A,$00
PASS    FCC     "key",$0
        FCB     0
SUCCESS FCC     "Processing, the IRQ will be enabled in 6 sec"
        FCB     $0D,$0A,$00
FAIL    FCC     "YOUR ACCOUNT IS LOCKED"
        FCB     $0D,$0A,$00
BUFFER  RMB     21

        END
        