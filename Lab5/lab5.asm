;Equation Define
DRB     EQU     $0001
DDRB    EQU     $0003
DRJ     EQU     $0268
DDRJ    EQU     $026A
DRP     EQU     $0258
DDRP    EQU     $025A
GETCHAR EQU     $EE84
;Main program
        ORG     $1000
        LDAA    #$FF
        STAA    DDRB
        STAA    DDRP
        LDAA    #$00
        STAA    DRP
START   LDX     GETCHAR
        JSR     $00,X
        STAB    TARGET
        STAB    TARGET
        CMPB    #$74
        BEQ     FINISH
        CMPB    #$75
        BEQ     UP
        CMPB    #$64
        BEQ     DOWN
        BRA     START
FINISH  SWI

UP      LDAA    #$FE
        STAA    DRP
        LDX     #NUMS
        LDAA    $00,X
        STAA    DRB
        JSR     TIME25
        LDAA    $01,X
        STAA    DRB
        JSR     TIME25
        LDAA    $02,X
        STAA    DRB
        JSR     TIME25
        LDAA    $03,X
        STAA    DRB
        JSR     TIME25
        LDAA    $04,X
        STAA    DRB
        JSR     TIME25
        LDAA    $05,X
        STAA    DRB
        JSR     TIME25
        LDAA    $06,X
        STAA    DRB
        JSR     TIME25
        LDAA    $07,X
        STAA    DRB
        JSR     TIME25
        LDAA    $08,X
        STAA    DRB
        JSR     TIME25
        LDAA    $09,X
        STAA    DRB
        JSR     TIME25
        JMP     START

DOWN    LDAA    #$F7
        STAA    DRP
        LDX     #NUMS
        LDAA    $09,X
        STAA    DRB
        JSR     TIME25
        LDAA    $08,X
        STAA    DRB
        JSR     TIME25
        LDAA    $07,X
        STAA    DRB
        JSR     TIME25
        LDAA    $06,X
        STAA    DRB
        JSR     TIME25
        LDAA    $05,X
        STAA    DRB
        JSR     TIME25
        LDAA    $04,X
        STAA    DRB
        JSR     TIME25
        LDAA    $03,X
        STAA    DRB
        JSR     TIME25
        LDAA    $02,X
        STAA    DRB
        JSR     TIME25
        LDAA    $01,X
        STAA    DRB
        JSR     TIME25
        LDAA    $00,X
        STAA    DRB
        JSR     TIME25
        JMP     START

TIME25  PSHA
        PSHY
;Load accumulator A with 250 and Y with 6000
        LDAA    #250
;Every 6000 loop take 1 milisecond. Constantly make 250 times looping 6000 will delay 250 miliseconds
LOOP    LDY     #6000
DELAY   DEY
        BNE     DELAY
        DECA
        BNE     LOOP
        PULY
        PULA
        RTS
        END
        
;Data section
TARGET  RMB     1
NUMS    FCB     $3F,$06,$5B,$4F,$66,$6D,$7D,$07,$7F,$6F