;Program 1
;        ORG     $1000
;        CLR     COUNT
;        LDAA    #$0D
;        LDY     #STRING
;LOOP    CMPA    $00,Y
;        BEQ     DONE
;        INC     COUNT
;        INY
;        BRA     LOOP
;DONE    SWI
;COUNT   RMB     1
;STRING  FCC     "CONESTOGA COLLEGE"
;        FCB     $0D
;        END
;Program 2
        ORG     $1000
        LDAB    COUNT
        LDY     #NUMS
        LDAA    #$00
LOOP    CMPA    $00,Y
        BHI     BIGGER
        LDAA    $00,Y
BIGGER  INY
        DECB
        BNE     LOOP
        STAA    $00,Y
        SWI
COUNT   FCB     $05
NUMS    FCB     $8C,$42,$AB,$CD,$56
