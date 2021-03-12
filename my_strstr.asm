%include "io.mac"

section .text
    global my_strstr
    extern printf

my_strstr:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edi, [ebp + 8]      ; substr_index
    mov     esi, [ebp + 12]     ; haystack
    mov     ebx, [ebp + 16]     ; needle
    mov     ecx, [ebp + 20]     ; haystack_len
    mov     edx, [ebp + 24]     ; needle_len
    ;; DO NOT MODIFY
    mov DWORD [ebp - 4], 0     ;se initializeaza variabila-index pentru haystack
    mov DWORD [ebp - 8], 1     ;se initializeaza variabila-index pentru needle
    
    mov edx, DWORD [ebp - 8]    ;punem in edx indexul pentru needle
    mov ah, [ebx + edx - 1]     ; punem in ah prima litera din needle
    jmp while

resetare:                       ;label in care se ajunge daca gasim o parte din needle in haystack dar pe parcurs ceva e se schimba
    mov DWORD [ebp - 8], 1     
    mov edx, DWORD [ebp - 8]
    mov ah, [ebx + edx - 1]
    inc DWORD [ebp - 4]         ;crestem indexul pentru haystack ca sa nu se produca un loop infinit


while:
    mov ecx, DWORD [ebp - 4]    ;punem in ecx indexul pentru haystack
    mov al, [esi + ecx]         ;punem in al caracterul din haystack
    cmp al, ah                  ;daca gasim o litera egala cu prima litera din needle  sarim in labelul subsir
    je subsir
    inc DWORD [ebp - 4]
    jne while

subsir:                         ;label in care verificam daca needle se afla in haystack
    mov edx, [ebp + 24]         ;daca indexul pentru cheie ajunge la sfarsiti sarim in adaugare
    cmp  DWORD [ebp - 8], edx 
    je adaugare         
    inc ecx                     ;crestem indexul in haystack
    inc  DWORD [ebp - 8]        ;crestem indexul in needle
    mov edx, DWORD [ebp - 8]
    mov al, [esi + ecx]         ;punem in al si ah literele din needle si haystack
    mov ah, [ebx + edx - 1]
    cmp al, ah                  ;le comparam
    je subsir                   ;daca sunt egale repetam aceste operatii
    jne resetare                ;daca nu, resetam 


adaugare:                       ;label pentru a adauga in edi pozitia primei aparitii
    mov edx, [ebp + 20]         ;punem in edx lungimea lui haystack pentru ca nu o folosim in acest moment
    cmp DWORD [ebp - 4], edx    ;comparam indexul cu lungimea totala
    jge subsir_nonexistent               ;daca este mai mare sau egal inseamna ca nu am gasit subsirul
    sub ecx, DWORD [ebp - 8]    ;scadem din indexul pentru haystack lungimea cheii  si adunam 1
    inc ecx
    mov [edi], ecx              ;punem in edi pozitia obtinuta
    jmp out

subsir_nonexistent:             ;label pentru cazul in care nu exista subsir
    inc edx                     ;incrementam lungimea haystack
    mov [edi], edx              ;si o punem in edi 
    
out:                            ;pentru ca a trebuit sa pun edx lungimea haystack am facut un label care sa le puna la sfarsit lungimile cum erau la inceput 
    mov     ecx, [ebp + 20]     
    mov     edx, [ebp + 24]
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
