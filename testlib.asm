section .data
    aStr db 'Toi la Thanh va           '
    len_aStr equ $-aStr
    valStr db 120, 254, 65, 72

section .bss
    swapStr db 1
    memBin equ 8
    
section .text
    extern mem_display
    extern mem_swap
    global _start

_start:
    push len_aStr
    push aStr
    call mem_display
    add esp, 8

    push memBin
    push swapStr
    push len_aStr
    push aStr
    call mem_swap
    add esp, 16
_last:
    mov eax, 1
    int 0x80