section .data
    bNum db 5
    wNum dw -128
    dNum dd 0x1234567  
    List dw 0x1000, 0x2000, 0x3000, 0x4000, 0x5000
    Hello db 'Netwide Assembly',10
    len equ $-Hello
    line_of_a times 40 db 'a'

    ;Btap tiep theo
    n1 dw 0xf6
    n2 dw 25

section .bss
    bArr resb 5
    wArr resw 5
    cArr resb 20

    ;Btap tiep theo
    Tong resd 1
    Hieu resw 1
    Tich resd 1
    Thuong resw 1
    Sodu resw 1
    TongMang resd 1

section .text
global _start
_start:
    ;Tinh tong
    movsx eax, word[n1]
    movsx ebx, word[n2]
    add eax, ebx
    mov [Tong], eax
_Tong:

    ;Tinh hieu
    mov ax, [n1] 
    sub ax, [n2]
    mov [Hieu], ax
_Hieu:

    ;Tinh tich
    mov dx, 0
    mov ax, [n1]
    mov bx, [n2]
    mul bx
    mov [Tich], ax
    mov [Tich + 2], dx 
_Tich:

    ;Tinh thuong
    mov dx, 0   ; = xor dx,dx 
    mov ax, [n1]
    mov bx, [n2]
    div bx
    mov [Thuong], ax
    mov [Sodu], dx
_Thuong:

    ;4.5a Fill bArr with the value of bNum
    mov al, [bNum]
    xor esi, esi
    mov ecx, 5
a_loop:
    mov byte[bArr + esi], al
    inc esi
    loop a_loop

    ;4.5b Copy list to wArr
    xor esi, esi
    mov ecx, 5
b_loop:
    mov ax, [List + esi * 2]
    mov [wArr + esi * 2], ax
    inc esi
    loop b_loop
 
    ;4.5c Copy hello string to cArr
    xor esi, esi
    mov ecx, len
c_loop:
    mov al, [Hello + esi * 1]
    mov [cArr + esi * 1], al
    inc esi
    loop c_loop 

    ;4.5d Print out cArr to console
    mov eax, 4
    mov ebx, 1
    mov ecx, cArr
    mov edx, len
    int 0x80

    ;4.6 Compute the sum of elements from list array, load the program in gdb to check the result.
    xor esi, esi
    mov ecx, 5
    xor eax, eax
d_loop:
    movsx ebx, word[List + esi * 2]
    add eax, ebx
    inc esi
    loop d_loop 
    mov [TongMang], eax

last:
    mov eax, 1
    int 0x80