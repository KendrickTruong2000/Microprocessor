;        ORG     $1000
;        LDAA    #5
;        LDX     #$1400
;        CLRB
;ADD     ADDB    $00,X
;        INX
;        DECB
;        BNE     ADD
;        STAB    ADD
;        SWI
;        ORG     $1400
;        FCB     $12,$13,$14,$15,$16
;        END

;Work on array
        ORG     $1000
ARR     DB      $11,$12,$13,$14,$15
        LDAB    #5
        LDX     #1400
        CLRA
ADD     ADDA    $00,X
        INX
        DECB
        BNE     ADD
        SWI
        ORG     $1400
        END
;Arithmetic
;        ORG     $1500
;        LDAA    $1000
;        CLRB
;        ADDA    $1001
;        ADDA    $1002
;        STAA    $1010
;        SWI
;        END
        ORG     $1500
ARR     DB      $1000,$1001,$1002
        LDAB    #3
        LDX     #1000
        CLRA
ADD     ADDA    $00,X
        INX
        DECB
        BNE     ADD
        SWI
        END
        
        