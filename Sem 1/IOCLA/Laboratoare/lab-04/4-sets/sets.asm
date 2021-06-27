%include "../io.mac"

section .text
    global main
    extern printf

main:
    ;cele doua multimi se gasesc in eax si ebx
    mov eax, 139
    mov ebx, 169
    PRINTF32 `%u\n\x0`, eax ; afiseaza prima multime
    PRINTF32 `%u\n\x0`, ebx ; afiseaza cea de-a doua multime

    ; TODO1: reuniunea a doua multimi
    or eax,ebx
    PRINTF32 '%d\n\x0', eax

    ; TODO2: adaugarea unui element in multime
    or eax, 16
    or eax, 64
    PRINTF32 '%d\n\x0', eax

    ; TODO3: intersectia a doua multimi
    mov ecx, 12
    and ecx, ebx
    PRINTF32 '%d\n\x0', ecx

    ; TODO4: complementul unei multimi
    not ebx
    PRINTF32 '%d\n\x0', ebx

    ; TODO5: eliminarea unui element
    mov eax, 139
    xor eax, 0
    PRINTF32 '%d\n\x0', eax

    ; TODO6: diferenta de multimi EAX-EBX
    mov eax, 139
    mov ebx, 169
    cmp eax, ebx
    jl caseOne
    
caseOne:
    not ebx
    and ebx, eax
    PRINTF32 '%d\n\x0', ebx