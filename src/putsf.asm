; -----------------------------------------------------------------------------
;  ASM PUTSF Source Code
;  File: putsf.asm
;  Title: Работа кода putsf
;  Last Change Date: 2 November 2023, 14:10 (UTC)
;  Author: Okulus Dev
;  License: GNU GPL v3
; -----------------------------------------------------------------------------
; Description: 
;   putsf - это альтернатива printf. PutsF минималичстичный, ограниченн символами
;  %c, %s, %d и %%. 
;   TODO: добавить реализации с %f (плавающие числа), %x (hex, 16-ые числа)
; -----------------------------------------------------------------------------

format ELF64							; указываем 64 битный линуксовый формат
; 64-битный формат означает, что ко всем регистрам будем добавлять букву r
; (например rax вместо ax). Буква R означает, что регистр 64-битный.
; Регистры бывают разных типов: AH, AL, AX, EAX, RAX - это все один регистр.
;  + RAX - 64 битный (8 байт)
;  + EAX - 32 битный (4 байта)
;  + AX - 16 битный (2 байта)
;  + AH, AL - 8 байтные (1 байт)
; Регистр RAX это дополнение EAX, EAX это дополнение AX, AX это дополнение 2
; регистров AH и AL

include "puts_decimal.asm"
include "puts_string.asm"
include "puts_char.asm"

public putsf

section '.putsf' executable				; секция putsf
; Ввод:
;  rax = format (rax = формат)
;  stack = values (stack = значения)
; Вывод:
;  rax = число, количество
putsf:									; метка putsf
	; Логика довольно простая, т.к. основные алгоритмы выполнены
	; Алгоритм:
	; 1. Прочитать i символ в строке
	; 2. Если символ равен %, тогда перейти на пункт 6
	; 3. Если символ равен нулю, тогда завершить выполнение
	; 4. Иначе, напечатать i символ
	; 5. Инкрементировать значение i (i++)
	; 6. Перейти на пункт 1
	; 7. Инкрементировать значение i (i++)
	; 8. Если i символ равен %, тогда напечатать его
	; 9. Если i символ равен d, тогда взять из стека значение и напечатать число
   	; 10. Если i символ равен s, тогда взять из стека значение и напечатать строку 	
	; 11. Если i символ равен c, тогда взять из стека значение и напечатать символ
	; 12. Иначе, вернуть ошибку и перейти на пункт 3
	; 13. Инкрементировать значение i
	; 14. Перейти на пункт 1
	push rbx
    push rcx

    ; call/ret    = 8byte
    ; rax+rbx+rcx = 24byte
    mov rbx, 32

    ; count of format elements
    xor rcx, rcx 
    .next_iter:
        cmp [rax], byte 0
        je .close
        cmp [rax], byte '%'
        je .special_char
        jmp .default_char
        .special_char:
            inc rax
            cmp [rax], byte 's'
            je .print_string
            cmp [rax], byte 'd'
            je .print_decimal
            cmp [rax], byte 'c'
            je .print_char
            cmp [rax], byte '%'
            je .default_char
            jmp .is_error
        .print_string:
            push rax
            mov rax, [rsp+rbx]
            call puts_string
            pop rax
            jmp .shift_stack
        .print_decimal:
            push rax
            mov rax, [rsp+rbx]
            call puts_decimal
            pop rax
            jmp .shift_stack
        .print_char:
            push rax
            mov rax, [rsp+rbx]
            call puts_char
            pop rax
            jmp .shift_stack
        .default_char:
            push rax
            mov rax, [rax]
            call puts_char
            pop rax
            jmp .next_step
        .shift_stack:
            inc rcx
            add rbx, 8
        .next_step:
            inc rax
            jmp .next_iter
    .is_error:
        mov rcx, -1
    .close:
        mov rax, rcx
        pop rcx
        pop rbx
        ret
