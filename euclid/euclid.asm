; file: euclid.asm
; Description: Calculate GCD of two numbers using Euclidean Algorithm
; Author: Dominic Giglio
;
; To compile executable (linux):
; nasm -f elf euclid.asm
; gcc -o euclid driver.c euclid.o asm_io.o

%include "asm_io.inc"

segment .data ; initialized data is put in the data segment
donemsg   db "The GCD is: ",0
intromsg  db "This program calculates the GCD of two numbers.",0
errormsg  db "You entered an unacceptable number.",0
inputmsg1 db "Enter a positive integer between 1 and 10,000: ",0
inputmsg2 db "Enter another positive integer between 1 and 10,000: ",0

segment .bss  ; uninitialized data is put in the bss segment

segment .text ; code is put in the text segment
global      asm_main
asm_main:   enter   0,0               ; setup routine
            pusha
;------------------------------------------------------------------------------
            call    print_nl
            mov     eax, intromsg     ; tell user what prog does
            call    print_string
            call    print_nl
            call    print_nl
            mov     eax, inputmsg1    ; ask for first number
            call    print_string
            call    read_int
            cmp     eax, 10000
            jg      ERROR             ; error out if number too big
            cmp     eax, 1
            jl      ERROR             ; error out if number too small
            mov     ecx, eax          ; store the valid number
            mov     eax, inputmsg2    ; ask for second number
            call    print_string
            call    read_int
            cmp     eax, 10000
            jg      ERROR             ; error out if number too big
            cmp     eax, 1
            jl      ERROR             ; error out if number too small
            cmp     ecx, eax
            jg      SWAP              ; if ecx > eax they need to be swapped

DIVIDE:     cdq                       ; initialize edx to accept remainders
            div     ecx               ; divide eax (dividend) by ecx (divisor)
            cmp     edx, 0            ; if remainder is 0, we're done
            je      DONE              ; otherwise...
            mov     eax, ecx          ; divisor becomes dividend and
            mov     ecx, edx          ; remainder becomes divisor
            jmp     DIVIDE            ; ...repeat

SWAP:       mov     ebx, eax          ; swap ax and cx because size matters
            mov     eax, ecx
            mov     ecx, ebx
            jmp     DIVIDE

ERROR:      mov     eax, errormsg
            call    print_nl
            call    print_string
            call    print_nl
            call    print_nl
            call    sub_dump_regs
            popa
            mov     eax, 1            ; return back to C
            leave                     
            ret
;------------------------------------------------------------------------------
DONE:       mov     eax, donemsg
            call    print_nl
            call    print_string
            mov     eax, ecx
            call    print_int
            call    print_nl
            popa
            mov     eax, 0            ; return back to C
            leave                     
            ret

