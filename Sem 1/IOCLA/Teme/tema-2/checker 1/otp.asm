%include "io.mac"

section .text
    global otp
    extern printf

otp:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY

    ;; TODO: Implement the One Time Pad cipher

xordifier:
    mov al, [esi]   ; punem litera lui plaintext in registrul al
    mov bl, [edi]   ; punem cheia in registrul bl
    xor al,bl

    inc esi         ; incrementam pointerii pentru
    inc edi         ; a lua urmatoarea litera la urmatorul loop

    mov [edx],al    ; adaugam rezultatul xor-ului in ciphertext 
    inc edx         ; incrementam edx pentru urmatoarea pozitie

    loop xordifier  ; se face loop pana la ultima litera din esi

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY