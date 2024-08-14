extern printf, scanf
extern writeDec, newline, space, writeBin

section .data
    msg db "Enter x, y: ", 10, 0
    format db "%d %d", 0

section .bss
    x1 resb 2
    x2 resb 2

section .text
    global _start


_start:
    push msg
    call printf ;print a message
    add esp, 4

    push x2
    push x1
    push format ;scanf("%d %d", &x1, &x2)
    call scanf ;input value for x
    add esp, 12

_readup:
    mov ax, word[x1]
    call writeDec
    call space

    mov ax, word[x2]
    call writeDec
    call newline

_last:
    mov eax, 1
    int 0x80