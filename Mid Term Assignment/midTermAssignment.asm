;Midterm Assignment
;--- Define Equation Section ---
DRB     EQU     $0001   ;Define PORT B
DDRB    EQU     $0003   ;Define Data Direction PORT B
DRP     EQU     $0258   ;Define PORT P
DDRP    EQU     $025A   ;Define Data Direction PORT P
DRJ     EQU     $0268   ;Define PORT J
DDRJ    EQU     $026A   ;Define Data Direction PORT J
PRINTF  EQU     $EE88   ;Define PRINTF
GETCHAR EQU     $EE84   ;Define GETCHAR
PUTCHAR EQU     $EE86   ;Define PUTCHAR

;--- Main Program
        ORG     $1000
        LDAA    #$FF
        STAA    DDRB
        STAA    DDRP    ;Set PORT B, P to output.
        STAA    DDRJ
        LDAA    #$00
        STAA    DRP     ;Turn ALL 7-segment off

START   PSHA            ;Clear Accumulator A
        PSHB            ;Clear Accumulator B
        PSHD            ;Clear register D
        PSHX            ;Clear register X
        LDD     #PROMPT ;Load promoption message into register D
        LDX     PRINTF
        JSR     $00,X   ;Call PRINTF function
        LDX     #STR    ;Load address of STR to store user input into X
        STX     VAR     ;Store address of STR to VAR
        
READ_LOOP
        LDX     GETCHAR
        JSR     $00,X   ;Call function GETCHAR
        CMPB    #$1B    ;Check for key ESC
        BEQ     END_INPUT       ;If ESC key detected jump to END_INPUT
        LDX     VAR     ;load address of STR into X
        STAB    $00,X   ;Store address of STR into B
        INX             ;Increase X
        STX     VAR     ;
        LDAB    #$2A    ;Load '*' into B
        LDX     PUTCHAR ;Call PUTCHAR
        JSR     $00,X   ;Display '*' onto screen.
        BRA     READ_LOOP       ;Continue reading.
        
END_INPUT
        LDD     #NEXTL  ;Load new line character into D
        LDX     PRINTF  ;Call PRINTF to display new line.
        JSR     $00,X
        PULX            ;Remove register X from memeory
        PULD            ;Remove register D from memeory
        PULB            ;Remove accummulator B from memory
        PULA            ;Remove accummulator A from memory
        JSR     COMPARE ;Jump to COMPARE subroutine
        BRA     START
        
COMPARE PSHA            ;Clear data from accummulator A
        PSHB            ;Clear data from accummulator B
        PSHD            ;Clear register D
        PSHX            ;Clear register X
        LDAA    COUNTER ;Load value of COUNTER
        CMPA    #0      ;Check number time user has input key pass have reach 0
        BEQ     LOCK_ACC        ;If number of time equal to 0 jump to lock account
        LDAA    #2      ;Load A = 2 as valid
        STAA    FLAG    ;Set flag as valid
        LDAB    #0      ;Load B = 0 as counting index
CMP_LOOP
        LDX     #PASSKEY        ;Load actual PASSKEY into X
        ABX             ;X = B + X to access index of PASSKEY accodingly to value of B
        LDAA    $00,X   ;Load value of X into A
        LDX     #STR    ;Load address of STR into X
        ABX             ;Access index of STR accodingly to value of B
        CMPA    $00,X   ;Compare character in A and X
        BNE     NOT_VALID       ;IF not equal go to NOT_VALID
        INCB            ;Else increase B
        CMPB    #3      ;Compare B with 3, check if looping through all 3 characters
        BEQ     VALID   ;If true jump to VALID
        BRA     CMP_LOOP        ;Continue comparing loop.

VALID   LDAA    #2      ;Load A = 2
        STAA    FLAG    ;Set Flag as valid
        LDD     #CORRECT_MESS   ;Load Correct message
        LDX     PRINTF  ;Call PRINTF to print correct message
        JSR     $00,X
        JSR     WAIT6   ;Jump to WAIT6 subroutine
        TPA
        ANDA    #%10101111
        TAP
        LDAA    #$40
        STAA    $001E
        LDS     #$2000
        LDD     #IRQISR ;Call maskable interrupt
        STD     $3E72
        BRA     END_CMP ;Move to END_CMP

NOT_VALID
        LDAA    #0      ;Load A = 0
        STAA    FLAG    ;Set FLAG invalid
        LDAA    COUNTER ;Load COUNTER
        DECA            ;Decrease A
        STAA    COUNTER ;Store new value of A into COUNTER
        CMPA    #0        ;Compare A with 0
        BEQ     LOCK_ACC        ;If equal to 0 move to LOCK_ACC
        LDD     #WRONG_MESS     ;Load WRONG_MESS
        LDX     PRINTF  ;Call function PRINTF to print WRONG_MESS
        JSR     $00,X
        BRA     END_CMP ;Move to END_CMP
        
LOCK_ACC
        LDAA    #1      ;Load A = 1
        STAA    FLAG    ;Set Flag to lock
        LDD     #LOCK_MESS      ;Load LOCK_MESS into D
        LDX     PRINTF  ;Call function PRINTF to print LOCK_MESS
        JSR     $00,X
        BRA     END_CMP ;Move to END_CMP
        
END_CMP PULX            ;Remove register X from memory
        PULD            ;Remove register D from memory
        PULB            ;Remove accummulator B from memory
        PULA            ;Remove accummulaotor A from memory
        LDAB    FLAG    ;Load FLAG into B
        CMPB    #1      ;If B equal to 1 status LOCK
        BEQ     HERE          ;Jump to FINISH
        CMPB    #2      ;If B equal to 2 status VALID
        BEQ     HERE          ;Jump to FINISH
        RTS             ;Return subroutine

;--- IRQISR Subroutine
IRQISR  LDAA    #$FF    ;Set Port B, P, J to output
        STAA    DDRB
        STAA    DDRP
        STAA    DDRJ
        STAA    DRP     ;Enable LEDs, 7-SEGMENT
        JSR     BLINK
        RTI

;--- WAIT 6 Second
WAIT6   LDAA    #$FE    ;Select Digit 3
        STAA    DRP
        LDAB    COUNT   ;Load COUNT into B
        LDY     #NUMS   ;Load address NUMS into Y
        LDAA    #$00    ;Load accumulator A = 0
LOOP_NUMS
        LDAA    $00,Y   ;Load index of NUMS accordingly to Y
        STAA    DRB     ;Display number onto 7 segment onto B
        JSR     FREQ2
        JSR     FREQ2
        JSR     FREQ2
        JSR     FREQ2   ;Delay 250 ms 4 times = 1 sec
        INY             ;Move Y to next index of NUMS
        DECB            ;Decrease B to count number of second
        BNE     LOOP_NUMS       ;Return to continue
        STAA    $00,Y   ;Store next index of NUMS into accumulator A
        RTS

;--- Blink LEDs 10 times
BLINK   LDAA    #10     ;Load A = 10
BLINK_LOOP
        LDAB    #%11111111      ;Turn on all LEDs
        STAB    DRB
        JSR     FREQ2   ;Delay 250ms
        LDAB    #%00000000      ;Turn off all LEDs
        STAB    DRB
        JSR     FREQ2   ;Delay 250ms
        DECA
        BNE     BLINK_LOOP      ;Return and continue counting
        RTS
        
;--- Frequency 2Hz
FREQ2   PSHA            ;Clear data from accummulator A
        PSHY            ;Clear data from register Y
        LDAA    #250    ;Load 250 into A
DELAY_LOOP
        LDY     #6000   ;Load 6000 into Y
FREQ_DELAY
        DEY             ;Decrease Y
        BNE     FREQ_DELAY      ;If loop not looping 6000 continue loopoing
        DECA                ;DecreaseA
        BNE     DELAY_LOOP      ;If A not equal not looping 250
        PULY            ;Remove register Y from memory address
        PULA            ;Remove accummulator from memory address
        RTS

HERE    BRA     HERE
FINISH  SWI
        
;--- DATA
NUMS    FCB     $3F,$06,$5B,$4F,$66,$6D,$7D,$07,$7F,$6F
PROMPT  FCC     "Enter Password: "
        FCB     $0D,$0A,$00
PASSKEY FCB     $6B,$65,$79     ;'K','E','Y'
COUNT   FCB     7
COUNTER FCB     3
WRONG_MESS
        FCC     "ID incorrect PLease try again"
        FCB     $0D,$0A,$00
CORRECT_MESS
        FCC     "Correct Password"
        FCB     $0D,$0A,$00
LOCK_MESS
        FCC     "YOUR ACCOUNT IS LOCKED"
        FCB     $0D,$0A,$00
NEXTL   FCB     $0D,$0A,$00     ;New Line
TARGET  RMB     1
STR     RMB     3
VAR     RMB     2
FLAG    RMB     1
        