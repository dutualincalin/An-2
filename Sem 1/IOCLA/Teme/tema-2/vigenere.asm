%include "io.mac"

section .text
    global vigenere
    extern printf

vigenere:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     ecx, [ebp + 16]     ; plaintext_len
    mov     edi, [ebp + 20]     ; key
    mov     ebx, [ebp + 24]     ; key_len
    ;; DO NOT MODIFY

    ;; TODO: Implement the Vigenere cipher

phase_1:

    mov al, [esi]              ; Memoram litera

check_letter:

    cmp eax, 65                 ; Verificam tipul literei.
    jl loopy_part

    cmp eax, 90
    jl crypt_letter_big

    cmp eax, 97
    jl loopy_part

    cmp eax, 122
    jl crypt_letter_small

    jmp loopy_part

reinitiate_key_big:             
                                ; Actualizam pointerul la zona de inceput
     mov edi, [ebp + 20]        ; a cheii.

crypt_letter_big:               
                                ; Daca cheia ajunge la null terminator se
    cmp byte [edi], 0x00        ; apeleaza reinitializarea cheii.
    je reinitiate_key_big

    sub eax, 65                 ; Se scade cu z = 65 pentru a se afla pozitia
    add al,[edi]                ; litere din cheie in ASCII si se adauga in al

    jmp compare_big

change_z_a_big:

    sub eax, 26

compare_big:

    cmp eax, 90                 ; Se verifica daca litera e prea mare
    jg change_z_a_big           ; si se fac ajustari.

    inc edi                     ; Se trece la urmatoarea litera din cheie.
    jmp loopy_part

reiterate_key_small:            
                                ; De aici si pana la compare_small se fac
     mov edi, [ebp + 20]        ; aceleasi operatii ca in cazul literei mari.

crypt_letter_small:             
                                ; doar ca vor fi ajustate pentru literele
    cmp byte [edi], 0x00        ; mici (Z = 122).
    je reiterate_key_small

    sub eax, 65
    add al,[edi]

    jmp compare_small

change_z_a_small:

    sub eax, 26

compare_small:

    cmp eax, 122
    jg change_z_a_small

    inc edi
    jmp loopy_part

loopy_part:

    mov [edx], al               ; Se adauga litera in ciphertext

    inc edx                     ; Se trec la urmatoarele pozitii
    inc esi

    loop phase_1                ; Pana cand ecx nu e 0 loop-ul va continua


    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY