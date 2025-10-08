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
        ORG     $1400
ARR     DB      $11,$12,$13,$14,$15
        LDAB    #5
        LDX     #1400
        CLRA
ADD     ADDA    $00,X
        INX
        DECB
        BNE     ADD
        SWI
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
;Example 2.4
        ORG     $1000
        LDAA    $1000
        ADDA    $1002
        SUBA    $1005
        STAA    $1010
        END
;Example 2.5
        ORG     $1500
        LDAA    $1000
        SUBA    #5
        STAA    $1000
        LDAA    $1001
        SUBA    #5
        STAA    $1001
        LDAA    $1002
        SUBA    #5
        STAA    $1002
        LDAA    $1003
        SUBA    #5
        STAA    $1003
        END
;Example 2.6
        ORG     $1500
        LDAA    $1000
        ADDA    $1002
        STAA    $1010
        END
;Example 2.10
        ORG     $1500
        STY     $1010
        TFR     X,Y
        emul
        STY     $1000
        STD     $1002
        LDY     $1010
        
;For loop example 2.14
N       EQU     20      ;Array count
        ORG     $1000   ;Starting address of on-chip SRAM
SUM     RMB     2       ;Reserve byte for array sum
i       RMB     1       ;Reserve byte for array index
        ORG     $1500   ;Starting address of the program
        LDAA    #0
        STAA    i       ;Initialize loop (array) index to 0
        STAA    SUM     ;Initialize sum to 0
        STAA    SUM+1   ;
LOOP    LDAB    i
        CMPB    #N      ;Is i = N?
        BEQ     DONE   ;if done, then branch
        LDX     #array  ;Use index register X as a pointer to the arry
        ABX             ;Compute the address of array[i]
        LDAB    0,X     ;Place array[i] in B
        LDY     SUM     ;Place sum in Y
        ABY             ;Compute sum <- sum + array[i]
        STY     SUM     ;Update sum
        INC     i       ;Increment the loop count by 1
        BRA     LOOP
DONE    SWI             ;Return to D-Bug12 monitor
;The array is defineed in the following statement
array   db      1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20
        end
;Example 2.15
M       EQU     20      ;Array count
        ORG     $1000   ;Starting address of on-chip SRAM
arrmax  ds.b    1       ;Memory location to hold array max
        ORG     $1500   ;Starting addres of program
        MOVB    array2,arrmax    ;Set arr[0] as the temporary array max
        LDX     #array+M-1      ;Start from the end of the array
        LDAB    #M-1    ;Use B to hold variable i and initiliazed it to N-1
loop2   LDAA    arrmax
        CMPA    0,X     ;Compare arrmax with array[i]
        BGE     chk_end ;no update if max_val is larger
        MOVB    0,X,arrmax      ;Update arrmax
chk_end DEX             ;Move the array pointer
        DBNE    B,loop2  ;Decrement the loop count, branch if not zero ye
FOREVER BRA     FOREVER
array2   DB      1,3,5,6,19,41,53,28,13,42,76,14,20,54,64,74,29,33,41,45
        END