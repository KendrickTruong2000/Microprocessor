;In Class week 5
;Interrupt
;SWI is a form of software interrupt
;Reset is hardware interrupt - Non Maskable XIRQ and IRQ
;XIRQ is higher priority than IRQ
;Register interrupt bit X is for XIRQ, bit I is for IRQ
;IRQ: interrupt control Register $0001
;IRQE: when 1: IRQ is responde to falling edge
      ;when 0: IRQ is responde to low leve
;IRQEN: when 1: IRQ is enable
       ;when 0: JRQ is disable
;Enable XIQR interrupt
        ORG     $1000
        TPA
        ANDA    #%10111111
        TAP
        SWI
;Disable XIQR interrupt
        ORG     $1000
        TPA
        ANDA    #%11101111
        TAP
        SWI
