;--- Define Equation ---
DRK     EQU     $0032       ; Port K data register (output lines to LCD / device)
DDRK    EQU     $0033       ; Port K data direction register (1 = output)
;--- Main Program ---
        ORG     $1000       ; program start address
        JSR     INIT        ; initialize device (function set, display on, entry mode, etc.)

        LDX     #TEXT       ; X -> address of the TEXT buffer (string to send)

; SEND: loop through the TEXT buffer sending each character as two 4-bit transfers
SEND    LDAA    $00,X       ; A = byte at [X] (load current character/byte)
        BEQ     DONE        ; if byte == 0 (terminator), branch to DONE

        ANDA    #$F0        ; mask upper nibble (keep bits 7..4, clear 3..0)
        LSRA                ; shift right logical A >> 1
        LSRA                ; shift right logical A >> 1  ; after two shifts, original bits 7..4 are now in bits 5..2? (see note)
                            ; (effectively brings high nibble into lower nibble positions for mapping to PORTK)
        STAA    DRK         ; write the nibble to the Port K data register (drives segment/data lines)
        BSET    DRK,%00000001 ; set bit0 of DRK (e.g. RS = 1 to select data register) ; depending on wiring, bit0 might be RS or some control
        JSR     ENAB        ; pulse the enable line to latch the nibble into the device
        JSR     DELAY       ; short delay for device timing

        LDAA    $00,X       ; reload the original byte into A (we need the low nibble now)
        ANDA    #$0F        ; mask low nibble (keep bits 3..0)
        LSLA                ; shift left logical A << 1
        LSLA                ; shift left logical A << 1 ; align low nibble onto same output pins as we did for high nibble
        STAA    DRK         ; output this aligned low nibble to Port K
        BSET    DRK,%00000001 ; set bit0 (RS/data select) again if needed
        JSR     ENAB        ; strobe enable to latch low nibble
        JSR     DELAY       ; timing delay

        INX                 ; advance to next character in TEXT
        BRA     SEND        ; repeat for next character

DONE    BRA     DONE        ; infinite idle loop after finished (or could RTI/RTS / halt)

; ENAB: pulse the enable line (assumes bit1 is EN)
ENAB    BSET    DRK,%00000010 ; set bit1 = 1 (enable high)
        JSR     DELAY         ; short hold time while E = 1
        BCLR    DRK,%00000010 ; clear bit1 = 0 (enable falling edge latches data)
        JSR     DELAY         ; pause for post-enable settling
        RTS                    ; return to caller

; INIT: series of commands to initialize device (sent in same 4-bit sequence using SUB_INIT)
INIT    LDAA    #$FF
        STAA    DDRK         ; configure Port K as outputs (all bits outputs)
        JSR     DELAY         ; small delay after direction set

        LDAA    #$0C         ; command byte (example: display ON, cursor OFF)
        STAA    DRK
        JSR     ENAB
        JSR     DELAY
        JSR     ENAB
        JSR     DELAY
        JSR     ENAB
        JSR     DELAY
        ; Above: writes same nibble/command multiple times — typical for switching LCD to 4-bit mode or initial pulses.

        LDAA    #$08         ; command byte (example: function set / some control)
        STAA    DRK
        JSR     ENAB
        JSR     DELAY

        LDAA    #$28
        JSR     SUB_INIT     ; send 0x28 in two nibbles via SUB_INIT (function set: 4-bit, 2-line, 5x8 dots)

        LDAA    #$08
        JSR     SUB_INIT     ; send 0x08 (display off) or similar

        LDAA    #$01
        JSR     SUB_INIT     ; send 0x01 (clear display)

        LDAA    #$06
        JSR     SUB_INIT     ; send 0x06 (entry mode: increment cursor)

        LDAA    #$0F
        JSR     SUB_INIT     ; send 0x0F (display on, cursor on, blink) — final display state
        RTS

; SUB_INIT: helper that sends the A register as two 4-bit transfers (high nibble then low nibble)
SUB_INIT:
        PSHA                 ; save A on stack (we will alter A)
        STAA    VAR          ; store original byte in VAR for later low nibble use

        ANDA    #$F0         ; isolate high nibble of original A
        LSRA
        LSRA                 ; move high nibble into position to output (same technique as in SEND)
        STAA    DRK          ; output aligned high nibble on port
        JSR     ENAB
        JSR     DELAY

        LDAA    VAR
        ANDA    #$0F         ; get the low nibble
        LSLA
        LSLA                 ; align low nibble like above
        STAA    DRK
        JSR     ENAB
        JSR     DELAY

        PULA                 ; restore original A
        RTS

; DELAY: coarse millisecond-ish delay loop (keeps timing between ENABLE pulses)
DELAY   PSHX
        PSHY
        LDX        #25      ; outer loop count (adjust for overall delay)
LOOP    LDY     #6000     ; inner loop count (busy wait)
DELAY_1 DEY
        BNE     DELAY_1
        DEX
        BNE     LOOP
        PULY
        PULX
        RTS

; Data / buffers
VAR     RMB     1         ; temporary storage used by SUB_INIT
TEXT    FCC     "KHANG"   ; message to send
        FCC     "                                   " ; spacing / filler
        FCC     "TRUONG PHU"
        FCB     $00       ; terminating null byte (end marker)
