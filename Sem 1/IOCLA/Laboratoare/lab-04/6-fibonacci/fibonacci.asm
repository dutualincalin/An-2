%include "../io.mac"

section .text
    global main
    extern printf

main:
    mov eax, 7       ; vrem sa aflam al N-lea numar; N = 7

    ; TODO: calculati al N-lea numar fibonacci (f(0) = 0, f(1) = 1)
    mov eax, 0
    mov ebx, 1
    test ecx, ecx
    jz print

repeat:
	mov edx, eax
	add edx, ebx
	mov eax, ebx
	mov ebx, edx
	dec ecx
	jnz repeat

print:
	PRINTF32 '%d\n\x0', eax
    ret
