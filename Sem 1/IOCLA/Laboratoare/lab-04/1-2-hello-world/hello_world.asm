%include "../io.mac"

section .data
    myString: db "Hello, World!", 0
    my2str : db "Goodbye, World!", 0

section .text
    global main
    extern printf

main:
    mov ecx, 6                      ; N = valoarea registrului ecx
    mov eax, 2
    mov ebx, 1

jump:
    cmp eax, ebx
    jg print                        ; TODO1: eax > ebx?
    jmp exit

print:
    PRINTF32 `%s\n\x0`, myString	; TODO2.2: afisati "Hello, World!" de N ori
    sub ecx, 1
    cmp ecx, 0
    jg print

exit:
    PRINTF32 `%s\n\x0`, my2str   	; TODO2.1: afisati "Goodbye, World!"
    ret
