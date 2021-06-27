%include "io.mac"

section .text
    global caesar
    extern printf

caesar:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY

    ;; TODO: Implement the caesar cipher

    mov ebx, edi

loopy_letters:
    mov al, [esi]       ; Preluam litera din plaintext.

find_side:
    cmp eax, 65         ; Verificam ce fel de litera este:
    jl next             

    cmp eax, 90         ; x = litera mare => 65 <= x <= 90
    jle big

    cmp eax, 97         ; x = litera mica => 97 <= x <= 122
    jl next

    cmp eax, 122
    jl small

    jmp next            ; altfel este un alt tip de caracter.

big:
    add al, bl          ; Adaugam cheia in litera.
    cmp eax, 90         ; Daca litera reprezentata in ASCII sare de
    jg big_z_a          ; Z in ASCII atunci facem transformare.

    jmp next

big_z_a:
    sub eax, 26         ; Scadem cu numarul de litere din alfabet
    cmp eax, 90         ; si dupa verificam daca mai este nevoie
    jg big_z_a          ; de inca o data de acest artificiu.

    jmp next

small:
    add al, bl          ; Adaugam cheia in liter.
    cmp eax, 122        ; Daca litera reprezentata in ASCII sare de
    jg small_z_a        ; z in ASCII atunci facem transformare.

    jmp next

small_z_a:
    sub eax, 26         ; Scadem cu numarul de litere din alfabet
    cmp eax, 122        ; si dupa verificam daca mai este nevoie
    jg small_z_a        ; sa transformam din nou.

    jmp next

next:
    mov [edx], al       ; Punem litera transformata in ciphertext.
    inc esi             ; Trecem la urmatoarea litera din plaintext.
    inc edx             ; Trecem la urmatoarea pozitie din ciphertext.
    dec ecx             ; Scadem size-ul lui plaintext.
    cmp ecx, 0          ; Daca size-ul este mai mare ca 0 continuam
    jg loopy_letters    ; altfel ne oprim.

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY