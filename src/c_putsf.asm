; -----------------------------------------------------------------------------
;  ASM PUTSF Source Code
;  File: cputsf.asm
;  Title: Связка putsf с C
;  Last Change Date: 2 November 2023, 14:10 (UTC)
;  Author: Okulus Dev
;  License: GNU GPL v3
; -----------------------------------------------------------------------------
; Description: 
;   putsf - это альтернатива printf. PutsF минималичстичный, ограниченн символами
;  %c, %s, %d и %%. 
;   TODO: добавить реализации с %f (плавающие числа), %x (hex, 16-ые числа)
; -----------------------------------------------------------------------------
format ELF64

extrn putsf

public c_putsf

section '.c_putsf' executable
c_putsf:
    pop r10

    push r9
    push r8
    push rcx
    push rdx
    push rsi

    mov rax, rdi
    call putsf

    pop rsi
    pop rdx
    pop rcx
    pop r8
    pop r9

    push r10 
    ret 

