;this is my first program
;        ORG     $1000 ;Directive, the program start from location 1000
;        LDAA    $1020 ;Instruction contain two part operation and operand
;        ADDA    $1021
;        STAA    $1022
;        SWI
;        ORG     $1020
;        FCB     $02,$04
;        END
;LDAA Load Accumulator A
;LDAA #$56 - Accumulator A will be load with value 56 in binary
;LDAA $56 - Accumulator A will be load with value at the address 56.
;this is my second program
;        ORG     $1000
;        LDAA    DATA
;        ADDA    DATA+1
;        STAA    DATA+2
;        SWI
;DATA    FCB     $02,$04
;        END
;This is my third program
;Index addressing
;        ORG     $1000
;        LDX	#$1000
;        LDAA    $01,X
;        INX
;        ADDA    $02,x
;        DEX
;        STAA    $04,x
;        SWI
;
;        ORG     $1020
;        FCB     $89,$AB,$CD,$FF
;        END

;This is my fourth program
;The use of label in indexed addressing
        ORG     $1000
        LDX     #VALS
        LDAA    $00,X
        ADDA    $01,X
        STAA    $02,X
        SWI
VALS    FCB     $01,$05
        END
