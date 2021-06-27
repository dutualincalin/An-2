%include "io.mac"

section .text
    global my_strstr
    extern printf

my_strstr:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; substr_index
    mov     esi, [ebp + 12]     ; haystack
    mov     ebx, [ebp + 16]     ; needle
    mov     ecx, [ebp + 20]     ; haystack_len
    mov     edx, [ebp + 24]     ; needle_len
    ;; DO NOT MODIFY

    ;; TO DO: Implement my_strstr

next_letter:

    mov al, [esi]               ; Preia litera din haystack.

    cmp al,[ebx]                ; Verifica daca se potriveste ceva.
    je something_found

    mov edx, [ebp + 24]         ; Daca nu, se reseteaza cheia.
    mov ebx, [ebp + 16]
    jmp prep_next

something_found:

    dec edx                     ; Daca se gaseste ceva atunci se scade
    inc ebx                     ; lungimea cheii si se trece la urm litera.

    cmp edx, 0                  ; Daca se gaseste toata secventa trecem la
    je found                    ; label-ul found.

prep_next:

    inc esi                     ; Se trece la urmatoarea litera din haystack,
    dec ecx                     ; se scade lungimea haystack-ului si se
    cmp ecx, 0                  ; verifica daca mai exista litere.
    jg next_letter

    jmp not_found

found:                          
                                ; Daca s-a gasit secventa atunci se
    mov eax, [ebp + 20]         ; calculeaza indicele cu formula:
    sub eax, ecx                ; ind = haystack_len - haystack_len_actual + 1.
    sub eax, [ebp + 24]         
    add eax, 1
    mov edx, [ebp + 8]
    mov [edx], eax              ; Si se adauga indicele in substr_index
    jmp exit

not_found:

    mov eax, [ebp + 20]         ; Daca nu s-a gasit secventa atunci se va
    add eax, 1                  ; calcula indicele cu formula:
    mov edx, [ebp + 8]          ; ind = haystack_len + 1 conform cerintei
    mov [edx], eax              ; si se va returna in substr_index

exit:
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY