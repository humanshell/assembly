

;
; file: array1.asm
; This program demonstrates arrays in assembly
;
; To create executable:
; nasm -f coff array1.asm
; gcc -o array1 array1.o array1c.c
;

%define ARRAY_SIZE 100
%define NEW_LINE 10

segment _DATA public align=4 class=DATA use32
FirstMsg        db   "First 10 elements of array", 0
Prompt          db   "Enter index of element to display: ", 0
SecondMsg       db   "Element %d is %d", NEW_LINE, 0
ThirdMsg        db   "Elements 20 through 29 of array", 0
InputFormat     db   "%d", 0

segment _BSS public align=4 class=BSS use32
array           resd ARRAY_SIZE

group DGROUP _BSS _DATA

segment _TEXT public align=1 class=CODE use32
        extern  puts_, printf_, scanf_, _dump_line
        global  _asm_main
_asm_main:
        enter   4,0             ; local dword variable at EBP - 4
        push    ebx
        push    esi

; initialize array to 100, 99, 98, 97, ...

        mov     ecx, ARRAY_SIZE
        mov     ebx, array
init_loop:
        mov     [ebx], ecx
        add     ebx, 4
        loop    init_loop

        mov     eax, FirstMsg        ; Watcom doesnt use C calling convention here'
        call    puts_           ; print out FirstMsg
 

        push    dword 10
        push    dword array
        call    _print_array           ; print first 10 elements of array
        add     esp, 8

; prompt user for element index
Prompt_loop:
        push    dword Prompt
        call    printf_
        pop     ecx

        lea     eax, [ebp-4]      ; eax = address of local dword
        push    eax
        push    dword InputFormat
        call    scanf_
        add     esp, 8
        cmp     eax, 1               ; eax = return value of scanf
        je      InputOK

        call    _dump_line  ; dump rest of line and start over
        jmp     Prompt_loop          ; if input invalid

InputOK:
        mov     esi, [ebp-4]
        push    dword [array + 4*esi]
        push    esi
        push    dword SecondMsg      ; print out value of element
        call    printf_
        add     esp, 12
        mov     eax, ThirdMsg        ; Watcom doesnt use C calling convention here'
        call    puts_
 

        push    dword 10
        push    dword array + 20*4     ; address of array[20]
        call    _print_array
        add     esp, 8

        pop     esi
        pop     ebx
        mov     eax, 0            ; return back to C
        leave                     
        ret

;
; routine _print_array
; C-callable routine that prints out elements of a double word array as
; signed integers.
; C prototype:
; void print_array( const int * a, int n);
; Parameters:
;   a - pointer to array to print out (at ebp+8 on stack)
;   n - number of integers to print out (at ebp+12 on stack)

segment _DATA public align=4 class=DATA use32
OutputFormat    db   "%-5d %5d", NEW_LINE, 0

segment _TEXT public align=1 class=CODE use32
        global  _print_array
_print_array:
        enter   0,0
        push    esi
        push    ebx

        xor     esi, esi                  ; esi = 0
        mov     ecx, [ebp+12]             ; ecx = n
        mov     ebx, [ebp+8]              ; ebx = address of array
print_loop:
        push    ecx                       ; printf might change ecx!

        push    dword [ebx + 4*esi]       ; push array[esi]
        push    esi
        push    dword OutputFormat
        call    printf_
        add     esp, 12                   ; remove parameters (leave ecx!)

        inc     esi
        pop     ecx
        loop    print_loop

        pop     ebx
        pop     esi
        leave
        ret




