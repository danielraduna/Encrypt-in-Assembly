%include "io.mac"

section .text
    global otp
    extern printf

otp:
   
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    
while:
	mov al, [esi + ecx  -1]  ;;pun in al litera din plaintext
	mov ah, [edi + ecx - 1]  ;;pun in ah litera din key
	xor al, ah				 ;;fac xor intre cele doua litere
	mov [edx + ecx - 1], al	 ;;pun in ciphertext rezultatul operatiei xor
	loop while				
   
    popa
    leave
    ret
    
