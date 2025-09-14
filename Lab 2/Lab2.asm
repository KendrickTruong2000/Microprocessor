;Program 1
;        ORG     $1000   ;Program start at memory address $1000
;        CLR     COUNT   ;Clear COUNT variable for later use
;        LDAA    #$0D    ;Load register A with value $0D (13 in decimal)
;        LDY     #STRING ;Load register Y with value from address #STRING
;LOOP    CMPA    $00,Y   ;Compare value of A=$0D with the byte at the address Y
;        BEQ     DONE    ;If equal (A == $Y) then go to DONE
;        INC     COUNT   ;Otherwise increment the counter
;        INY             ;Move pointer Y to different character by increasing.
;        BRA     LOOP    ;Repeat
;DONE    SWI             ;Software interupt to end program
;COUNT   RMB     1       ;Reserves one byte of memory for COUNT
;STRING  FCC     "CONESTOGA COLLEGE"
;        FCB     $0D     ;Define the string "CONESTOGA COLLEGE" in memory that follow by $0D
;        END             ;End of program
;Program 2
;        ORG     $1000  ;Program start at memory address $1000
;        LDAB    COUNT  ;Load register B with value of COUNT = 5
;        LDY     #NUMS  ;Load register Y with address of NUMS
;        LDAA    #$00   ;Load register A with maximum value that was found.
;LOOP    CMPA    $00,Y  ;Compare the current maximum value (A) with the current array element.
;        BHI     BIGGER ;If A is already bigger, skip updating. Otherwise A will update new value
;        LDAA    $00,Y  ;Update the maximum value.
;BIGGER  INY            ;Move Y to next element.
;        DECB           ;Decrement counter
;        BNE     LOOP   ;If B!=0, repeat loop.
;        STAA    $00,Y  ;Store the final maximum at current address Y
;        SWI            ;Software interupt - halt the program
;COUNT   FCB     $05    ;Number of element is 5
;NUMS    FCB     $8C,$42,$AB,$CD,$56    ;Declare 5 different variables for 5 values
;        END            ;End of the program.
;Program 3
        ORG     $1000  ;Program start at memory address $1000
        LDAB    COUNT  ;Load register B with value of COUNT=5
        LDX     #FROM  ;X point to the source of array
        LDY     #TO    ;Y point to the destination of array
LOOP    LDAA    $00,X  ;Load A with byte from X
        STAA    $00,Y  ;Store A into Y
        INX            ;Move pointer X to next source element
        INY            ;Move pointer Y to next destination element
        DECB           ;Decrement B for one less element left
        BNE     LOOP   ;if B != 0 repeat.
        SWI            ;Software interupt.
COUNT   FCB     $5     ;5 Elements
FROM    FCB     $AB,$CD,$EF,$2A,$EF
TO      RMB     5      ;Reserve 5 bytes for 5 elements.
        END