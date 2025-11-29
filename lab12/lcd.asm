DRK     EQU     $0032
DDRK    EQU     $0033

        ORG     $1000
        JSR     INIT
        LDX     #TEXT
SEND    LDAA    $00,X
        BEQ     DONE
        ANDA    #$F0
        LSRA
        LSRA
        STAA    DRK
        BSET    DRK,%00000001
        JSR     ENAB
        JSR     DELAY
        LDAA    $00,X
        ANDA    #$0F
        LSLA
        LSLA
        STAA    DRK
        BSET    DRK,%00000001
        JSR     ENAB
        JSR     DELAY
        INX
        BRA     SEND
DONE    BRA     DONE

ENAB    BSET    DRK,%00000010
        JSR     DELAY
        BCLR    DRK,%00000010
        JSR     DELAY
        RTS

INIT    LDAA    #$FF
        STAA    DDRK
        JSR     DELAY

        LDAA    #$0C
        STAA    DRK
        JSR     ENAB
        JSR     DELAY
        JSR     ENAB
        JSR     DELAY
        JSR     ENAB
        JSR     DELAY

        LDAA    #$08
        STAA    DRK
        JSR     ENAB
        JSR     DELAY

        LDAA    #$28
        JSR     SUB_INIT

        LDAA    #$08
        JSR     SUB_INIT

        LDAA    #$01
        JSR     SUB_INIT

        LDAA    #$06
        JSR     SUB_INIT

        LDAA    #$0F
        JSR     SUB_INIT
        RTS


SUB_INIT:
        PSHA
        STAA    VAR
        ANDA    #$F0
        LSRA
        LSRA
        STAA    DRK
        JSR     ENAB
        JSR     DELAY
        LDAA    VAR
        ANDA    #$0F
        LSLA
        LSLA
        STAA    DRK
        JSR     ENAB
        JSR     DELAY
        PULA
        RTS



DELAY        PSHX
        PSHY
        LDX        #25
LOOP        LDY     #6000
DELAY_1        DEY
        BNE     DELAY_1
        DEX
        BNE     LOOP
        PULY
        PULX
        RTS

VAR     RMB     1
TEXT    FCC     "KHANG"
        FCC     "                                   "
        FCC     "TRUONG PHU"
        FCB     $00
