;--- Define Equation ---
DDRA    EQU     $0002
DRA     EQU     $0000
DDRB    EQU     $0003
DRB     EQU     $0001
DDRP    EQU     $025A
DRP     EQU     $0258
PUCR    EQU     $000C

;--- Main Program ---
        ORG     $1000
        LDAA    #$FF
        STAA    DDRB
        STAA    DDRP
        LDAA    #$0F
        STAA    DDRA
;Enable extrem left seven seg
        LDAA    #$FE
        STAA    DRP
;Enable pull up resgister
        LDAA    #$01
        STAA    PUCR
;Run through columns to check any key press
LOOP    LDAA    #$F7
        STAA    TEMP1
        LDAB    #$04
NEXT    STAA    DRA
        JSR     DELAY
        LDAA    DRA
        STAA    TEMP3
        ANDA    #$F0
        CMPA    #$F0
        BNE     PRESS
        ROR     TEMP1
        LDAA    TEMP1
        DECB
        BEQ     LOOP
        BRA     NEXT
;If any key press check rach possible code
PRESS   LDAA    #$7D
        CMPA    TEMP3
        BNE     GOTO1
        LDAB    #$0
        STAB    KEY
        JSR     DISPLAY
        JMP     LOOP
        STAB    KEY
        JSR     DISPLAY
        JMP     LOOP
GOTO1   LDAA    #$EE
        CMPA    TEMP3
        BNE     GOTO2
        LDAB    #$1
        STAB    KEY
        JSR     DISPLAY
        JMP     LOOP
GOTO2   LDAA    #$ED
        CMPA    TEMP3
        BNE     GOTO3
        LDAB    #$2
        STAB    KEY
        JSR     DISPLAY
        JMP     LOOP
GOTO3   LDAA    #$EB
        CMPA    TEMP3
        BNE     GOTO4
        LDAB    #$3
        STAB    KEY
        JSR     DISPLAY
        JMP     LOOP
GOTO4   LDAA    #$DE
        CMPA    TEMP3
        BNE     GOTO5
        LDAB    #$4
        STAB    KEY
        JSR     DISPLAY
        JMP     LOOP
GOTO5   LDAA    #$DD
        CMPA    TEMP3
        BNE     GOTO6
        LDAB    #$5
        STAB    KEY
        JSR     DISPLAY
        JMP     LOOP
GOTO6   LDAA    #$DB
        CMPA    TEMP3
        LBNE     GOTO7
        LDAB    #$6
        STAB    KEY
        JSR     DISPLAY
        JMP     LOOP
GOTO7   LDAA    #$BE
        CMPA    TEMP3
        LBNE     GOTO8
        LDAB    #$7
        STAB    KEY
        JSR     DISPLAY
        JMP     LOOP
GOTO8   LDAA    #$BD
        CMPA    TEMP3
        LBNE     GOTO9
        LDAB    #$8
        STAB    KEY
        JSR     DISPLAY
        JMP     LOOP
GOTO9   LDAA    #$BB
        CMPA    TEMP3
        LBNE     GOTOA
        LDAB    #$9
        STAB    KEY
        JSR     DISPLAY
        JMP     LOOP
GOTOA   LDAA    #$E7
        CMPA    TEMP3
        LBNE     GOTOB
        LDAB    #$0A
        STAB    KEY
        JSR     DISPLAY
        JMP     LOOP
GOTOB   LDAA    #$D7
        CMPA    TEMP3
        LBNE     GOTOC
        LDAB    #$0B
        STAB    KEY
        JSR     DISPLAY
        JMP     LOOP
GOTOC   LDAA    #$B7
        CMPA    TEMP3
        LBNE     GOTOD
        LDAB    #$0C
        STAB    KEY
        JSR     DISPLAY
        JMP     LOOP
GOTOD   LDAA    #$77
        CMPA    TEMP3
        LBNE    GOTOE
        LDAB    #$0D
        STAB    KEY
        JSR     DISPLAY
        JMP     LOOP
GOTOE   LDAA    #$7E
        CMPA    TEMP3
        LBNE     GOTOF
        LDAB    #$0E
        STAB    KEY
        JSR     DISPLAY
        JMP     LOOP
GOTOF   LDAA    #$7B
        CMPA    TEMP3
        LBNE     LOOP
        LDAB    #$0F
        STAB    KEY
        JSR     DISPLAY
        JMP     LOOP
        
DISPLAY LDX     #PATTERN
        LDAB    KEY
        ABX
        LDAA    $00,X
        STAA    DRB
        RTS
DELAY   PSHX
        LDX     #6000
LOOP2   DEX
        LBNE     LOOP2
        PULX
        RTS
;--- Data section ---
TEMP1   RMB     1
TEMP3   RMB     1
KEY     RMB     1
PATTERN FCB     $3F,$06,$5B,$4F,$66,$6D,$7D,$07,$7F,$67,$77,$7C,$39,$5E,$79,$71
        END