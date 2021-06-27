section .data
    delim db " ", 0

section .bss
    root resd 1

section .text

extern malloc
extern check_atoi
extern print_tree_inorder
extern print_tree_preorder
extern evaluate_tree

global create_tree
global iocla_atoi

iocla_atoi:
	push ebp
	mov ebp, esp

	push ecx
	push edx
	push ebx			; Se salveaza parametrii apelantului si se initializeaza registrele din apelat.
	push edi
	push esi

	mov ecx, [ebp + 8]
	mov edx, 0
	mov eax, 0

atoi_val:
    mov bl, byte[ecx]

    cmp bl, 0				; Se verifica daca string-ul nu mai are caractere si daca numarul din string este negativ.
    je atoi_minus

    cmp bl, 45
    je atoi_remember_minus

    sub ebx, 48				; Se trece din cifra de tip char in cifra de tip int.

    push edx

    mov edx, 10
    mul edx					; Se face inmultirea cu 10 ca sa faca loc urmatoarei cifre si se pune cifra in numar.					

    movzx edx , bl
    add eax, edx			; Si se adauga urmatoarea cifra in ebx

    pop edx
    inc ecx
    jmp atoi_val

atoi_remember_minus:
	mov edx, 1				; Se retine daca numarul este negativ.
	inc ecx
	jmp atoi_val

atoi_minus:
	cmp edx, 0				; In cazul in care numarul nu este negativ, se trece la final, altfel numarul negativ o sa fie chiar
	je atoi_end				; complementul lui eax adunat cu 1.

	not eax
	add eax, 1

atoi_end:
	pop esi
	pop edi					; Se refac parametrii necesari apelantului si se termina functia
	pop ebx
	pop edx
	pop ecx
	pop ebp
    ret

create_tree:
	enter 0,0
    xor eax, eax
	push ebx				; Se salveaza parametrii functiei
	push edi
	push esi

	push 12
	call malloc
	add esp, 4

	mov [root], eax			; Se aloca dinamic radacina, pointerul se adauga la root si se retine string-ul de date in ecx
    push root
    push eax
    mov ecx , [ebp + 8]

check_string:
	cmp byte [ecx], 0
	je end

	cmp byte [ecx], ' '		; Se verifica daca string-ul a ajuns la un delimitator sau nu mai are caractere
	je prepare_next

alloc_string:
	push ecx
	push 4
	call malloc				; Se aloca o zona de memorie pentru valoarea nodului
	add esp, 4
	pop ecx

	mov edx, 0

get_string:
	mov bl, byte[ecx]

	cmp bl, 0				; Se preia valoarea nodului iterand byte cu byte se verifica daca char-ul e eligibil
	je reset_adress			; si se adauga in zona de memorie alocata.

	cmp bl, ' '
	je reset_adress

	mov byte [eax],bl
	inc ecx
	inc eax
	inc edx

	jmp get_string

reset_adress:
	dec eax					; Se reseteaza pointerul in zona de memorie astfel incat sa pointeze la inceputul valorii...
	dec edx
	cmp edx, 0
	jne reset_adress

write_string:
	mov ebx, [esp]				; si se adauga valoarea in nod.
	mov [ebx], eax

look_left:
	mov eax, [esp]				; Se preia nodul principal din stack.
	mov ebx, [eax]

	cmp byte [ebx], 47			; Se verifica valoarea din radacinca si in functie de tipul valorii (operatie sau numar) se afla 
	jg prev_parent				; cum trebuie parcurs in continuare tree-ul

	cmp byte [ebx], 45
	je check_minus_left

	jmp look_left_2

check_minus_left:
	cmp byte [ebx + 1], 47
	jg prev_parent

look_left_2:
	mov eax, [eax + 4]			; Se verifica valoarea din nodul stang in functie de tip

	cmp eax, 0					; Daca nodul e gol atunci urmeaza alocarea acestui nod
	je create_node_left

	mov ebx, [eax]

	cmp byte [ebx], 47			; Se trece la verificarea nodului din dreapta daca nodul din stanga e numar si se actualizeaza nodul din stack
	jg prev_parent

	cmp byte [ebx], 45
	je check_minus_left_2

	jmp next_parent				; Altfel se trece la urmatorul nod din stanga.

check_minus_left_2:
	cmp byte [ebx + 1], 47
	jg prev_parent

	jmp next_parent

look_right:
	mov eax, [esp]
	mov eax, [eax + 8]			; Se retine adresa nodului drept.

	cmp eax, 0					
	je create_node_right		; Daca nodul e gol atunci urmeaza alocarea acestui nod.

	mov ebx, [eax]

	cmp byte [ebx], 47			; Se verifica valoarea din nodul drept in functie de tip.
	jg prev_parent				; Daca este numar atunci se trece la parintele parintelui nodului drept,

	cmp byte [ebx], 45
	je check_minus_right

	jmp next_parent				; Altfel trecem la copilul din stanga,

check_minus_right:
	cmp byte [ebx + 1], 47
	jg prev_parent

	jmp next_parent

next_parent:
	push eax				; Adaugam adresa nodului din eax e stiva si apoi ne uitam la nodul stang.
	jmp look_left

prev_parent:
	cmp dword[esp], root	; Daca in stiva s-a ajuns la root atunci se reverifica string-ul daca mai are caractere.
	je check_string 

	pop eax					; Scoatem din varful stivei adresa vechiului nod principal si apoi ne uitam la nodul drept al noului nod principal.
	mov ebx, [esp]
	mov ebx, [ebx + 8]

	cmp eax, ebx
	je prev_parent			; Vedem daca nu cumva noul nod are ca nod drept vechiul nod ca sa nu intram intr-o bucla infinita.

	jmp look_right

create_node_left:
	push ecx

	push 12					; Se aloca zona de memorie pentru nod.
	call malloc
	add esp, 4

	pop ecx

	mov ebx, [esp]			; Se scoate nodul din stiva.
	mov [ebx + 4], eax		; Se adauga in nodul drept al nodului din stiva zona de memorie.
	push eax				; Se adauga noul nod in stiva

	jmp prepare_next

create_node_right:
	push ecx

	push 12
	call malloc				; Se aloca zona de memorie.
	add esp, 4

	pop ecx

	mov ebx, [esp]
	mov [ebx + 8], eax		; Se scoate nodul din stiva si se pune zona de memorie in copilul drept
	push eax				; Se adauga copilul in stiva

prepare_next:
	inc ecx				; Se trece la urmatoarea valoare din string
	jmp check_string

end:
	add esp, 8			; Se elimina root-ul si nodul radacina din stiva
	
	pop esi
	pop edi
	pop ebx
    mov eax, [root]		; Se salveaza in eax adresa radacinii

    leave
    ret
