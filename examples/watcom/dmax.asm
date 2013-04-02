

;
; file: dmax.asm

global _dmax

; Watcom doesnt pass floats back on the coprocessor stack'
; Instead, the address of the location with the return value
; is passed back in EAX
segment _BSS public align=4 class=BSS use32 
return_value resq  1            ; quadword to store result into


segment _TEXT public align=1 class=CODE use32
; function _dmax
; returns the larger of its two double arguments
; C prototype
; double dmax( double d1, double d2 )
; Parameters:
;   d1   - first double
;   d2   - second double
; Return value:
;   larger of d1 and d2 

; next, some helpful symbols are defined

%define d1   [ebp+8]
%define d2   [ebp+16]

_dmax:
        enter   0, 0

        fld     qword d2
        fld     qword d1            ; ST0 = d1, ST1 = d2
        fcomip  st1                 ; ST0 = d2
        jna     short d2_bigger
        fcomp   st0                 ; pop d2 from stack
        fld     qword d1            ; ST0 = d1

d2_bigger:                          ; if d2 is bigger, nothing to do
        mov     eax, return_value   ; address of quadword with result
        fstp    qword [eax]         ; store result at location 

exit:
        leave
        ret


