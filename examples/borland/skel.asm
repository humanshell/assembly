

;
; file: skel.asm
; This file is a skeleton that can be used to start assembly programs.

%include "asm_io.inc"
segment _DATA public align=4 class=DATA use32
;
; initialized data is put in the data segment here
;


segment _BSS public align=4 class=BSS use32
;
; uninitialized data is put in the bss segment
;


group DGROUP _BSS _DATA

segment _TEXT public align=1 class=CODE use32
        global  _asm_main
_asm_main:
        enter   0,0               ; setup routine
        pusha

;
; code is put in the text segment. Do not modify the code before
; or after this comment.
;

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


