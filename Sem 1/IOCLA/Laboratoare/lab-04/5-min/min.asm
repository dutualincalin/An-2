%include "../io.mac"

section .text
    global main
    extern printf

main:
    ; cele doua numere se gasesc in eax si ebx
    mov eax, 4
    mov ebx, 1

    ; TODO: aflati minimul
    cmp eax, ebx
    jl exchange

exchange:
	xchg eax, ebx
    PRINTF32 `Minimul este: %d\n\x0`, eax ; eax

    ret
