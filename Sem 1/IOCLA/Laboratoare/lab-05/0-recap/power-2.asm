%include "../utils/printf32.asm"

section .text
extern printf
global main
main:
    push ebp
    mov ebp, esp

    mov eax, 211    ; to be broken down into powers of 2
    mov ebx, 1      ; stores the current power

    ; TODO - print the powers of 2 that generate number stored in EAX
    mov ecx, 1
    cmp eax,ecx
    jbe PRINT

POW:
	inc ebx
    shl ecx,1

PRINT:
	cmp eax,ecx
	jb stop
	PRINTF32 '%d\n\x0', ecx
	jmp POW

stop:
    leave
    ret
