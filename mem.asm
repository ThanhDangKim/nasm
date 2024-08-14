section .data
    extern writeHex
    extern space
    extern newline
    extern writeChar
    extern writeBin
    extern writeDec

section .text
    global mem_display
    global val_display
    global mem_swap

mem_display:
    push ebp
    mov ebp, esp
    push esi
    push ecx
    mov esi, dword[ebp + 8]
    mov ecx, dword[ebp + 12]
    cld
    mov dx, 0
memdisplay_loop:
    lodsb 
    call writeHex
    call space
    inc dx
    cmp dx, 16
    je _newline
    jmp _next
    _newline:
        mov dx, 0
        call newline
    _next:
    loop memdisplay_loop
    call newline
    pop ecx
    pop esi
    leave
    ret

val_display:
    push ebp
    mov ebp, esp
    push esi
    push ecx
    mov esi, dword[ebp + 8]
    mov ecx, dword[ebp + 12]
valdisplay_loop:
    call writeHex
    call space
    call writeDec
    call space
    call writeBin
    loop valdisplay_loop
    call newline
    pop ecx
    pop esi
    leave
    ret

mem_swap:
    push ebp
    mov ebp, esp
    push esi
    push ecx
    push edi
    push ebx
    mov esi, dword[ebp + 8]
    mov ecx, dword[ebp + 12]
    mov edi, dword[ebp + 16]
    mov ebx, dword[ebp + 20] 
    cld
memswap_loop:
    lodsb
    mov byte[edi + ebx], al
    dec ebx
    loop memswap_loop
        
    pop ebx
    pop edi
    pop ecx
    pop esi
    leave
    ret



