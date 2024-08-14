%macro writeStr 2
    push eax
    push ebx   
    push ecx
    push edx

    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 0x80

    pop edx
    pop ecx
    pop ebx
    pop eax
%endmacro

section .data
    cMem db 0
    hex_char db '0123456789ABCDEF'

section .text
global _start
_start:
    mov al, 255
    call writeHex
    call newline

    call writeHexStr
_exit:
    mov eax, 1
    int 0x80

writeChar:
    ; input al
    mov [cMem], al
    writeStr cMem, 1
    ret

writeHexDigit:
    ; input al (0 -> 15)
    push ebx
    mov ebx, hex_char
    xlat
    call writeChar
    pop ebx
    ret

writeHex:
    ; input al
    push ebx
    ; c2 dùng phép chia 
    ;xor ah, ah
    ;movsx ax, al
    ;mov bl, 16
    ;div bl
    ;call writeHexDigit
    ;mov al, ah
    ;call writeHexDigit
    
    ; c1  
    mov bl, al
    shr al, 4
    call writeHexDigit
    mov al, bl
    and al, 0x0f
    call writeHexDigit

    pop ebx
    ret

writeHexStr:
    mov esi, hex_char
    mov ecx, 16
    cld
HS_loop:
    lodsb
    call writeHex
    call space
    loop HS_loop
    call newline

space:
    push eax
    mov al, 0x20
    call writeChar
    pop eax
    ret

newline:
    push eax
    mov al, 10
    call writeChar
    pop eax
    ret