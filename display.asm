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
    hexstr db '0x'
    binMem times 8 db 0x30 ; memory to store binary string
    

section .text
    global writeChar
    global writeHexDigit
    global writeHex
    global space
    global newline
    global writeString
    global writeBin
    global writeDec

;Function 
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
    call writeX

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

writeX:
    writeStr hexstr, 2
    ret

writeString:
    push ebp
    mov ebp, esp
    mov esi, [ebp + 8]
    mov ecx, [ebp + 12]
    writeStr esi, ecx
    leave
    ret

writeBin:
    push ebx
    push ecx
    push edx
    push esi
    push edi

    xor bx, bx
    mov cx, 2
_bin_disp_loop:
    mov esi, al
    and al, 0x01
    call writeChar

    inc byte[esi]
dl_zero:
    inc esi
    shr bl, 1
    loop _bin_disp_loop

    writeStr binMem, 8

    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    ret
    ret

writeDec:
    ;input ax;
    push ebx
    push ecx
    push edx

    xor bx, bx
    mov cx, 10
_div_loop:
    xor dx, dx
    div cx
    push edx
    inc bx
    cmp ax, 0
    jnz _div_loop
_div_loop_fin:
    mov cx, bx
_print_loop:
    pop eax
    add al, 0x30
    call writeChar
    loop _print_loop

    pop edx
    pop ecx
    pop ebx
    ret

