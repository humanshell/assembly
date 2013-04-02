; file: skel.asm
;
; To compile executable (linux):
; nasm -f elf skel.asm
; gcc -o skel driver.c skel.o asm_io.o

%include "asm_io.inc"

; initialized data is put in the data segment
segment .data

; uninitialized data is put in the bss segment
segment .bss

; code is put in the text segment
segment .text
global      asm_main
asm_main:
            enter   0,0               ; setup routine
            pusha
;------------------------------------------------------------------------------
; Do not modify the code before or after this comment.
;------------------------------------------------------------------------------
            popa
            mov     eax, 0            ; return back to C
            leave                     
            ret

