section .data
SYS_EXIT equ 1
a db 17
b db 9 
c db 0 
d dw 4096
hello db 'Hello world',10   ; có 12 ô nhớ
len equ $-hello ;lấy chiều dài ô nhớ
section .text
global _start
_start:
    mov al, [a]
    add al, [b]
    mov [c], al
    mov eax, 4  ;4 lệnh để ghi
    mov ebx, 1
    mov ecx, hello
    mov edx, len    
    int 0x80    ;kết thúc lệnh ghi ra
last:
    mov eax, SYS_EXIT
    int 0x80