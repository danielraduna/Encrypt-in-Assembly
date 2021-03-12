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
    cmp edi, 26             ;; comparam cheia cu 26 
    jg scadere_cheie        ;; daca este mai mare scadem cheia
    jl while                ;; daca este mai mic sarim in label-ul while unde se face totul

scadere_cheie:              ;;label pentru scaderea cheii pana la o valoare mai mica de 26
    sub edi, 26
    cmp edi, 26
    jg scadere_cheie
    jle while



while:                              ;;label principal
    mov al, [esi + ecx -1]          ;; punem in al un caracter din plaintext 
    mov ebx, edi                    ;;copiem cheia in ebx
    cmp al, 97                      ;;comparam caracterul cu 97 si daca este mai mare sau egal este primul pas in a fi o litera mica
    jge litera_mica0
    
    cmp al, 65                  ;;comparam litera cu 65 si daca este mai mare sau egal este primul pas in a fi o majuscula    
    jge majuscula0          
    jl adaugare                  ;;daca este mai mica adaugam acel caracter asa cum este el

litera_mica0:                   ;;label care verifica daca carecterul este litera mica
    cmp al, 122                 ;;il comparam cu 122 si daca este mai mic sau egal facem adunarea cu cheia
    jle adunare_litera_mica
    jg adaugare                 ;;daca este mai mare adaugam caracterul asa cum este el
    
    

majuscula0:                     ;;label care verifica daca carecterul este majuscula
    cmp al, 90                  ;;il comparam cu 90 si daca este mai mic sau egal facem adunarea cu cheia
    jle adunare_majuscula
    jg adaugare                 ;;daca este mai mare adaugam caracterul asa cum este el

transformare_A:                 ;;label care transforma majuscula in A daca se trece de Z la adunare 
    cmp ebx, 0                  ;;daca cheia devine 0 adaugam litera obtinuta
    je adaugare
    mov eax, 65                 ;;transformam litera in A
    sub ebx, 1 

adunare_majuscula:              ;;label care aduna cheia la majuscula noastra 
    cmp ebx, 0                   ;;daca cheia devine 0 adaugam litera obtinuta         
    je adaugare
    add eax, 1                  ;;adunam 1 la litera
    sub ebx, 1                  ;;si scadem 1 din cheie
    cmp al, 90                  ;;comparam litera cu Z si daca e egal facem un jump sa o transformam in A
    je transformare_A
    jmp adunare_majuscula

transformare_a:                  ;;label care transforma litera mica in a daca se trece de z la adunare 
    cmp ebx, 0                  ;;daca cheia devine 0 adaugam litera obtinuta
    je adaugare
    mov eax, 97                 ;;transformam litera in a
    sub ebx, 1

adunare_litera_mica:            ;;label care aduna cheia la litera noastra mica 
    cmp ebx, 0                  ;;daca cheia devine 0 adaugam litera obtinuta
    je adaugare
    add eax, 1                  ;;adunam 1 la litera
    sub ebx, 1                   ;;si scadem 1 din cheie
    cmp eax, 122                 ;;comparam litera cu z si daca e egal facem un jump sa o transformam in a  
    je transformare_a 
    jmp adunare_litera_mica 


adaugare:                        ;;label care face adaugarea in cyphertext
    mov[edx + ecx -1], al
    loop while
    



    ;; DO NOT MODIFY

    popa
    leave
    ret
    ;; DO NOT MODIFY