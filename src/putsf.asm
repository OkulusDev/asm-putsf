; -----------------------------------------------------------------------------
;  ASM PUTSF Source Code
;  File: putsf.asm
;  Title: Работа кода putsf
;  Last Change Date: 2 November 2023, 14:10 (UTC)
;  Author: Okulus Dev
;  License: GNU GPL v3
; -----------------------------------------------------------------------------
; Description: null
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

public _start

section '.data' writeable				; метка данных, доступна для записи
	string db "Puts F ", 0xA, 0			; строка

section '.text' executable				; текстовая секция, выполняемая
_start:									; метка старта
	mov rax, string						; перемещаем в регистр rax строку
	call puts_string

	mov rax, 123
	call puts_decimal

	mov rax, 0xA
	call puts_char
exit:									; метка выхода
	mov rax, 60
	xor rdi, rdi
	syscall

section '.puts_char' executable			; секция вывода символа
; Ввод:
;  rax = char (регистр rax = символ)
puts_char:								; метка вывода символа
	push rax
	push rdx
	push rsi
	push rdi
	push rax

	mov rsi, rsp
	mov rdi, 1
	mov rdx, 1
	mov rax, 1
	call do_syscall						; вызываем метку do_syscall

	pop rax
	pop rdi
	pop rsi
	pop rdx
	pop rax

	ret

section '.puts_string' executable		; секция вывода строки
; Ввод:
;  rax = string (регистр rax = строка для вывода)
puts_string:							; метка вывода строки
	push rbx
	xor rbx, rbx

	.next_iter:
		cmp [rax+rbx], byte 0
		je .close
		push rax
		mov rax, [rax+rbx]
		call puts_char
		pop rax
		inc rbx
		jmp .next_iter
	.close:
		pop rbx
		ret

section '.puts_decimal' executable		; секция вывода числа
; Ввод:
;  rax - число
puts_decimal:							; метка вывода числа
	; Стоит учитывать, что данная метка работает только с 64-битными числами, и
	; следовательно, и отрицательное число она будет трактовать если оно будет
	; 64-битным. В противном случае, если число будет 32 битное, то оно со
	; стороны 64-битного числа будет трактоваться как unsigned (число без знака) 
	; Алгоритм:	
	; 1. Если число меньше нуля, то напечать символ минус.
	; 2. Разделить число на 10, взять частное и остаток от деления
	; 3. Положить остаток в стек
	; 4. Инкрементировать значение i (i++)
	; 5. Если частное не равно 0, тогда перейти на 2 пункт
	; 6. Если значение i равно 0, тогда закрыть выполнение
	; 7. Выгрузить число из стека (остаток)
	; 8. Привать к остатку символ '0' (число 48 по ASCII)
	; 9. Напечатать получившийся символ (puts_char)
	; 10. Декрементировать значение i (i--)
	; 11. Перейти на пункт 6
	push rax
    push rbx
    push rcx
    push rdx
    xor rcx, rcx
    cmp rax, 0
    
	jl .is_minus
    jmp .next_iter

    .is_minus:
        neg rax
        push rax
        mov rax, '-'
        call puts_char
        pop rax

    .next_iter:
        mov rbx, 10
        xor rdx, rdx
        div rbx
        push rdx
        inc rcx
        cmp rax, 0
        je .puts_iter
        jmp .next_iter

    .puts_iter:
        cmp rcx, 0
        je .close
        pop rax
        add rax, '0'
        call puts_char
        dec rcx
        jmp .puts_iter

    .close:
        pop rdx
        pop rcx
        pop rbx
        pop rax
        ret

section '.do_syscall' executable		; секция сисвызова
do_syscall:								; метка сисвызова
	push rcx
	push r11

	syscall
	
	pop r11
	pop rcx

	ret
