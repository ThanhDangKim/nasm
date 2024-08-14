section .data
    Bitstr db '11001110'
    
    BDstr db '01100011'
    lenBD equ $-BDstr
    
    ListB db 0x10, 0x20, 0x30, 0x40, 0x50, 0x60
    lenL equ $-ListB
    
    MangOriginal db 0x25, 0x99, 0xDF, 0x56, 0x00, 0x7E, 0x1D 
    lenMO equ $-MangOriginal
    
    Key equ 0x58
    StringDecode db 'Hello world', 10
    lenSD equ $-StringDecode

    TwoD db 12, 14, 15, 23, 34, 45, 64, 3, 5, 8, 9, 10
    rowTwoD equ 3
    colTwoD equ 4

section .bss
    regEBX resd 1

    regAL resb 1

    c5 resb 1

    count resb 1

    MangAfter resb 1

    ResultTwoD resw 1
    nho resb 1

section .text
global _start
_start:
    ; lab 4 - c2
    mov ax, 0x1234
    mov dx, 0x5678
    ror ax, 8
    ror dx, 8
    movsx ebx, dx
    shl ebx, 16
    mov bx, ax
    mov [regEBX], ebx
_end2:
    
    ; lab 4 - c3
    xor al, al
    xor esi, esi
    mov bl, 0x30
    mov ecx, 8
a_loop:
    mov dl, byte[Bitstr + esi]
    sub dl, bl
    shl al, 1
    add al, dl
    inc esi
    loop a_loop

    ; lab 4 -c4
    mov al, 0b11001010
    mov ecx, 8
    xor esi, esi
b_loop:
    shl al, 1
    jnc _else4
_if4:
    mov byte[regAL + esi], 0x31
    jmp _endif4
_else4:
    mov byte[regAL + esi], 0x30
_endif4:
    inc esi
    loop b_loop

    ; lab 4 - c5
    mov word[c5], 0
    mov eax, 1
    mov esi, lenBD - 1
    mov ecx, lenBD
    xor dl, dl
c_loop:
    mov dl, byte[BDstr + esi]
    sub dl, 0x30
    cmp dl, 0x1
    jb _else5
    add [c5], eax
_else5:
    dec esi
    shl eax, 1
    loop c_loop

    ; lab 4 - c6
    xor esi, esi
    mov ecx, lenL
    mov byte[count], 0
    mov dl, 1
d_loop:
    test byte[ListB + esi], 1 ; and với 1 
    jnz _else6
    add byte[count], dl
_else6:
    inc esi
    loop d_loop

    ; lab 4 - c7
    xor esi, esi
    mov edi, lenMO - 1
    mov ecx, lenMO
e_loop:
    mov al, byte[MangOriginal + esi]
    mov dl, byte[MangOriginal + edi]
    mov byte[MangAfter + esi], dl
    mov byte[MangAfter + edi], al
    inc esi
    dec edi
    cmp esi, edi
    ja _endif
    loop e_loop
_endif:

    ; lab 4 - c8
    xor esi, esi
    mov ecx, lenSD - 1
f_loopEn:
    mov al, byte[StringDecode + esi]
    xor al, Key
    mov byte[StringDecode + esi], al
    inc esi
    loop f_loopEn

    ; Print out StringDecode
    mov eax, 4
    mov ebx, 1
    mov ecx, StringDecode
    mov edx, lenSD
    int 0x80
_printEncode:

    xor esi, esi
    mov ecx, lenSD - 1
f_loopDe:
    xor byte[StringDecode + esi], Key
    inc esi
    loop f_loopDe

    ; Print out StringDecode
    mov eax, 4
    mov ebx, 1
    mov ecx, StringDecode
    mov edx, lenSD
    int 0x80

    ; lab 4 - c9
    xor si, si
    mov ecx, rowTwoD
gOut_loop:
    ; lấy edi
    mov ax, si
    mov bl, rowTwoD
    mul bl
    add ax, si
    mov di, ax
    movsx edi, di

    ; cbi vòng lặp
    mov ax, si
    add ax, 1
    mov bl, colTwoD
    mul bl
    movsx eax, ax
    xor dl, dl
    xor bx, bx

    ; lấy esi
    movsx esi, si
    
gIn_loop:
        mov bl, byte[TwoD + edi]
        movsx bx, bl
        add dx, bx 
        inc edi
        cmp edi, eax
        jb gIn_loop

    mov word[ResultTwoD + esi], dx
    inc si
    loop gOut_loop

    ; lab 4 - c10


last:
    mov eax, 1
    int 0x80
