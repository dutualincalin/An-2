%include "../utils/printf32.asm"

%define NUM 5
   
section .text

extern printf
global main
main:
    mov ebp, esp

    ; TODO 1: replace every push by an equivalent sequence of commands (use direct addressing of memory. Hint: esp)
    mov ecx, NUM
push_nums:
    sub esp, 4
    mov [esp], ecx
    loop push_nums

    sub esp, 4
    mov dword [esp], 0
    sub esp, 4
    mov dword [esp], "mere"
    sub esp, 4
    mov dword [esp], "are "
    sub esp, 4
    mov dword [esp], "Ana "

    lea esi, [esp]
    PRINTF32 `%s\n\x0`, esi

    ; TODO 2: print the stack in "address: value" format in the range of [ESP:EBP]
    ; use PRINTF32 macro - see format above

    mov ebx, esp
    mov ecx, ebp
    
Print_2:
    mov eax, [ebx]
    PRINTF32 `0x%x:\x0`, ebx
    PRINTF32 `%hhd\n\x0`, eax
    inc ebx
    cmp ecx, ebx
    jne Print_2

    ; TODO 3: print the string
    mov ebx, esp
    PRINTF32 `%s\n\x0`,ebx

    ; TODO 4: print the array on the stack, element by element.
    add esp, 16
    mov eax, [esp]
    PRINTF32 `%hhd \x0`,eax
    add esp, 4
    mov eax, [esp]
    PRINTF32 `%hhd \x0`,eax
    add esp, 4
    mov eax, [esp]
    PRINTF32 `%hhd \x0`,eax
    add esp, 4
    mov eax, [esp]
    PRINTF32 `%hhd \x0`,eax
    add esp, 4
    mov eax, [esp]
    PRINTF32 `%hhd \x0`,eax

    ; restore the previous value of the EBP (Base Pointer)
    mov esp, ebp

    ; exit without errors
    xor eax, eax
    ret
