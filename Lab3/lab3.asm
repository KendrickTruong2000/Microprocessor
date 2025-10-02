;Lab#3: Microprocessor.

;Equation section
PRINTF  EQU     $EE88        ;Subrountine for print string
GETCHAR EQU     $EE84         ;Subrountine for getting character from keyboard
PUTCHAR EQU     $EE86        ;Subrountine for outputting single character

;Main program
        ORG     $1000   ;Program start from address $1000
        LDD     #STRING ;Load address of STRING to register D
        LDX     PRINTF  ;Load PRINTF rountine to register X
        JSR     $00,X   ;Jump to subrountine at X with argument D, this print MY TYPE WRITER IS READY
AGAIN   LDD     #NEXTL  ;Load address of NEXTL to register D
        LDX     PRINTF  ;Load address of PRINTF to register X
        JSR     $00,X   ;Print new line of data from NEXTL
        LDX     GETCHAR ;Load character input from keyboard to register X
        JSR     $00,X   ;Call function GETCHAR to use, getting character from the keyboard
        STAB    TARGET  ;Store value of B to TARGET
        LDAB    TARGET  ;Load address of TARGET to B
        CMPB    #$1B    ;Compare value of B to ESCAPE key.
        BEQ     FINISH  ;If value of B is equal to ESCAPE key stop the program.
        LDX     PUTCHAR ;Load address of PUTCHAR to X
        JSR     $00,X   ;Call function PUTCHAR, to outputting the character
        LDD     #EQUAL  ;Load address of EQUAL to D
        LDX     PRINTF  ;Load address of PRINTF to X
        JSR     $00,X   ;Call function PRINTF, to print "=".
        LDAB    TARGET  ;Load address of TARGET to accumulator B
        LSRB
        LSRB
        LSRB
        LSRB            ;Shift right 4 time to isolate upper nibble.
        ADDB    #$30    ;Add value of B to 30.
        LDX     PUTCHAR ;Load address of PUTCHAR to register X.
        JSR     $00,X   ;Call function PUTCHAR
        LDAB    TARGET  ;Load accumulator B with value of TARGET
        ANDB    #$0F    ;AND value of B with 0F
        ADDB    #$30    ;Add B with 30
        CMPB    #$39    ;Compare if B is smaller than 39 (number 9 in ASCII table)
        BLE     SKIP    ;Branch if less or equal than
        ADDB    #$07    ;Add value B with 07
SKIP    LDX     PUTCHAR ;Else load address of PUTCHAR to register X
        JSR     $00,X   ;Call PUTCHAR function
        BRA     AGAIN   ;Loop back agian and wait for next key
FINISH  SWI

;Data section
STRING  FCC     "MY TYPE WRITER IS READY"
        FCB     $0D,$0A,$00     ;New line + string terminator
EQUAL   FCB     $3D,$00         ;"="
NEXTL   FCB     $0D,$0A,$00     ;New line
TARGET  RMB     1               ;Reserve 1 memory bit for TARGET
        END