GETCHAR	EQU 	$EE84
PUTCHAR	EQU 	$EE86
PRINTF	EQU 	$EE88

        ORG 	$1000
START:
        LDS	#$4000

;--- Print prompt ---
        LDD 	#PROMPT
        LDX     PRINTF
        JSR 	$00,X

        LDY 	#BUFFER

READ_LOOP:
        ; Get character
        LDD 	GETCHAR
        JSR 	$00,X
        STAA    TARGET
        CMPA 	#$0D
        BEQ 	END_INPUT
        LDX     PUTCHAR
        JSR     $00,X
        BRA 	READ_LOOP

END_INPUT:
        CLRA
        STAA 	0,Y          ; Null-terminate

;--- Print header ---
        LDD 	#RESULT
        LDX     PRINTF
        JSR 	$00,X

;--- Print entered string ---
        LDD 	#BUFFER
        LDX     PRINTF
        JSR 	$00,X

FINISH:
        SWI

;--- Data ---
PROMPT	FCC 	"Enter a line: ",0
BUFFER	RMB 	100
RESULT	FCC 	"You typed: ",0
TARGET  RMB     1
        END
