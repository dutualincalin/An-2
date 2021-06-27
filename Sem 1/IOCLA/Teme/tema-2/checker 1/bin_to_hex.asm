%include "io.mac"

section .text
    global bin_to_hex
    extern printf

bin_to_hex:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; hexa_value
    mov     esi, [ebp + 12]     ; bin_sequence
    mov     ecx, [ebp + 16]     ; length
    ;; DO NOT MODIFY

    ;; TODO: Implement bin to hex

    mov ebx, [ebp + 16]             ; ebx = lungimea secv mari de biti


reset_sequence:

    mov ecx, 0                      ; Se reseteaza secventa de 4 biti
    mov edx, 0                      ; si suma in baza 10 a secventei.

phase_1:
                                    ; Se incepe cu finalul secventei.
    mov al, byte [esi + ebx - 1]    ; Pentru fiecare bit se scade 48 (= 0 in ASCII)
    sub eax, 48                     ; ca sa avem 0 sau 1, apoi shiftam in functie de
    shl eax, cl                     ; pozitia bit-ului in secventa (bit * 2^pozitie).

    add dl, al                      ; Se adauga in suma rezultatul.

    inc ecx                         ; Se inregistreaza bit-ul in secv de 4 biti.
    dec ebx                         ; Scadem lungimea secventei intregi de biti.

    cmp ebx, 0                      ; Daca secventa e completa se intra in
    je add_num                      ; label-ul add_num.

    cmp ecx, 4                      ; Dar daca nu mai sunt biti de verificat
    je add_num                      ; se intra in add_num cu secventa ramasa.

    jmp prep_next


add_num:

    add edx, 48                     ; Transformarea sumei de biti in numar (in ASCII)

    cmp edx, 57                     ; Daca suma nu este numar(1 - 9) atunci se trece
    jg  add_letter                  ; la add_letter pentru ca avem litera mare(A - F).

    jmp insert                      ; Urmeaza inserarea in hexa_value.

add_letter:
                                    ; Se aduna cu 7 pentru ca rezultatul
    add edx, 7                      ; sa devina litera mare in ASCII.


insert:

    mov eax, edx                    ; Rezultatul se pune in eax.
    mov edx, [ebp + 8]              ; edx = adresa variabilei hexa_value.
    jmp search_free_place

inc_adress:

    inc edx                         ; Se trece la adresa urmatoare.

search_free_place:

    cmp byte [edx], 0x00            ; Se cauta un loc liber pentru bit si 
    jne inc_adress                  ; se insereaza rezultatul in acel loc.

    mov [edx], eax                  ; Se adauga rezultatul in adresa.

    cmp ebx, 0                      ; Daca s-a iterat prin toti bitii trecem
    je phase2_start                 ; la faza a doua a programului.


insert_next:
                                    ; Dupa insert trebuie resetata suma si
    jmp reset_sequence              ; dimensiunea pentru o noua secventa de biti.

prep_next:
                                    ; Daca secventa nu este inca formata se
    jmp phase_1                     ; trece la urmatoarea litera.


phase2_start:
                                    ; Avem rezultat, dar este afisat pe dos
    mov ecx, 0                      ; de aceea incepem procedura de swap prin
    mov ebx, [ebp + 8]              ; reinitializarea lui ecx = lungimea lui
    jmp len_calculator              ; hexa_value si ebx = adresa primului bit.

inc_adress_2:

    inc ebx                         ; Se trece la urmatoarul bit si
    inc ecx                         ; creste lungimea.
    
len_calculator:

    cmp byte [ebx], 0x00            ; Se intereaza pana la primul null terminator.
    jne inc_adress_2

    mov eax, ecx                    ; Lungimea se imparte la doi ca sa aflam
    shr ecx, 1                      ; numarul de iteratii de swap pe care
    mov [ebp + 16], ecx             ; trebuie sa le facem.


swapper_prepare:

    mov ebx, [ebp + 8]              ; Cream adresa pentru capatul din stanga.

    mov edx, [ebp + 8]              ; Cream adresa pentru capatul din dreapta.
    add edx, eax

vector_end:

    mov byte [edx], 10              ; Adaugam '\n' si '\0' la finalul 
    inc edx                         ; vectorului pentru ca asa trebuie,
    mov byte [edx + 2], 0           ; aparent :)... si se revine la
    sub edx , 2                     ; capatul din dreapta al vectorului.

swappy:

    mov al, byte [ebx]              ; Se preiau cei 2 biti...
    mov cl, byte [edx]

    mov byte [ebx], cl              ; Si se face interschimbarea.
    mov [edx], al

    mov ecx, [ebp + 16]             ; Se scade numarul de iteratii 
    dec ecx
    mov [ebp + 16], ecx

    cmp ecx, 0                      ; Daca mai sunt iteratii se trece prin
    jne swappy_prep_next            ; swappy_prep_next

    jmp exit

swappy_prep_next:

    inc ebx                         ; Se actualizeaza adresele din capete
    dec edx                         ; si se reitereaza swappy
    jmp swappy

exit:

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY