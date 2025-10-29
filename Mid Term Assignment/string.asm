;--- Define Equation ---
DRB     EQU     $0001
DDRB    EQU     $0003
DRP     EQU     $0258
DDRP    EQU     $025A
DRJ     EQU     $0268
DDRJ    EQU     $026A
PRINTF  EQU     $EE88
GETCHAR EQU     $EE84
PUTCHAR EQU     $EE86
;--- Main Program ---
        ORG     $1000
        LDS     #$4000          ; initialize stack (important)
        LDAA    #$FF
        STAA    DDRB
        STAA    DDRJ
        STAA    DDRP
        LDAA    #$00
        STAA    DRP

START	PSHA
        PSHB
        PSHD
        PSHX
        LDD     #PROMPT
        LDX     PRINTF
        JSR     $00,X
        LDX     #STR
        STX     VAR
READ_LOOP
        LDX     GETCHAR
        JSR     $00,X
        CMPB    #$1B
        BEQ     END_INPUT
        LDX     VAR
        STAB    $00,X
        INX
        STX     VAR
        LDAB   	#$2A
        LDX     PUTCHAR
        JSR     $00,X
        BRA     READ_LOOP
END_INPUT
        LDD     #NEXTL
        LDX     PRINTF
        JSR     $00,X
        PULX
        PULD
        PULB
        PULA

COMPARE PSHA
        PSHB
        PSHD
        PSHX
        PSHY
        LDX     #PASSKEY
        LDY     #STR
COMP_LOOP
	LDAA    $00,X
        CMPA    $00,Y
        BNE     DISP_WRONG
	INY
        INX
        BNE     COMP_LOOP
        JSR     DISP_CORRECT
        PULY
        PULX
        PULD
        PULB
        PULA
        RTS

DISP_CORRECT
        LDD     #CORRECT_MESS
        LDX     PRINTF
        JSR     $00,X
        RTS
        
DISP_WRONG
        LDAB    COUNTER
        LDD     #WRONG_MESS
        LDX     PRINTF
        JSR     $00,X
        DECB
        RTS
        
;--- WAIT 6 Second
WAIT6   LDAB    COUNT
        LDY     #NUMS
        LDAA    #$FE
        STAA    DRP
        LDAA    #$00
LOOP    LDAA    $00,Y
        STAA    DRB
        JSR     FREQ2
        JSR     FREQ2
        JSR     FREQ2
        JSR     FREQ2
        INY
        DECB
        BNE     LOOP
        STAA    $00,Y
        BRA     WAIT6
        JMP     START

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
        JMP     START

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

;--- Data Section ---
NUMS    FCB     $3F,$06,$5B,$4F,$66,$6D,$7D,$07,$7F,$6F
PROMPT  FCC     "Enter Password: "
        FCB     $0D,$0A,$00
PASSKEY	FCB     $6B,$65,$79
COUNT   FCB     7
COUNTER	FCB     3
WRONG_MESS
        FCC     "Wrong Password"
        FCB     $0D,$0A,$00
CORRECT_MESS
        FCC     "Correct Password"
        FCB     $0D,$0A,$00
NEXTL   FCB     $0D,$0A,$00     ;New Line
TARGET  RMB     1
STR     RMB     3
VAR     RMB     2

        END