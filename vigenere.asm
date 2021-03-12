%include "io.mac"

section .text
    global vigenere
    extern printf

vigenere:
    
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     ecx, [ebp + 16]     ; plaintext_len
    mov     edi, [ebp + 20]     ; key
    mov     ebx, [ebp + 24]     ; key_len
 

	 mov DWORD [ebp - 4], 0     ;se initializeaza variabila-index pentru plaintext
	 mov DWORD [ebp - 8], 0     ;se initializeaza variabila-index pentru cheie
cheie_extinsa:					;label pentru a extinde cheia
 	mov DWORD [ebp - 8], 0		;indexul pentru cheie devine 0
while:
	cmp DWORD [ebp - 8], ebx	;daca indexul pentru cheie ajunge egal cu lungimea cheii
	je cheie_extinsa			;"extindem" cheia
	mov ecx, DWORD [ebp - 4]	;mutam indexul in varibila ecx
	mov al, [esi + ecx]			;mutam in al litera din plaintext
	inc DWORD [ebp - 4]			;crestem indexul pentru plaintext
	
	cmp al, 97					;;comparam caracterul cu 97 si daca este mai mare sau egal este primul pas in a fi o litera mica
    jge litera_mica0
    
    cmp al, 65					;;comparam litera cu 65 si daca este mai mare sau egal este primul pas in a fi o majuscula    
    jge majuscula0
    jl adaugare					;;daca este mai mica adaugam acel caracter asa cum este el

litera_mica0:					;;label care verifica daca carecterul este litera mica
    cmp al, 122					;;il comparam cu 122 si daca este mai mic sau egal inseamna ca este litera
    jle litera
    jg adaugare					;;daca este mai mare adaugam caracterul asa cum este el
  
majuscula0:						;;label care verifica daca carecterul este majuscula
    cmp al, 90
    jle litera					;;il comparam cu 90 si daca este mai mic sau egal inseamna ca este litera
    jg adaugare					;;daca este mai mare adaugam caracterul asa cum este el

 litera:						
 	mov ebx, DWORD [ebp - 8]	;mutam indexul in varibila ecx
 	mov ah, [edi + ebx]			;mutam in ah litera din cheie
 	inc DWORD [ebp - 8]			;crestem indexul pentru cheie	
 	mov ebx, [ebp + 24]			;mutam inapoi in ebx cu lungimea cheii
 
	sub ah, 65					;scadem 65 din litera noastra pentru a determina pozitia din alfabet a literii din cheie
	jmp calcul					

transformare_A:					;label care transforma majuscula in A daca trece de Z
	cmp ah, 0
	je adaugare
	mov al, 65
	dec ah
	jmp calcul

transformare_a:					;label care transforma litera mica in a daca trece de z
	cmp ah, 0
	je adaugare 
	mov al, 97
	dec ah


calcul:							;label care face adunarea cu cheia
	cmp ah, 0					;daca cheia devine 0 adaugam
	je adaugare
	inc al 						;incrementam litera
	dec ah 						;decrementam cheia
	cmp al, 122					;daca litera noastra este z sarim in labelul pentru transformare in a
	je transformare_a
	cmp al, 90					;daca litera noastra este Z sarim in labelul pentru transformare in A
	je transformare_A
	jmp calcul

adaugare:						;label care facec adaugarea in cyphertext
	mov[edx + ecx ], al 		;adaugam litera in cyphertext
	mov ecx, [ebp + 16] 		;mutam inapoi in ecx lungimea plaintext-ului
	sub ecx, DWORD [ebp - 4]	;scadem din ecx indexul pentru plaintext si dupa adunam 1, si se repeta acest lable atat timp cat ecx este mai mare ca 0
	add ecx, 1
	cmp ecx, 0
	jg while
    
    
    popa
    leave
    ret
    PRINTF32 `\n`
    
