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

section '.text' executable				; текстовая секция, выполняемая
_start:									; метка старта
	mov rax, 'P'						; перемещаем в регистр rax символ P
	call puts_char

	; Повторяем данную операцию, пока не выведем всю строку (PUTSF)
	mov rax, 'u'
	call puts_char

	mov rax, 't'
	call puts_char

	mov rax, 's'
	call puts_char

	mov rax, 'F'
	call puts_char
	
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

section '.do_syscall' executable		; метка вызова сисвызова
do_syscall:
	push rcx
	push r11

	syscall
	
	pop r11
	pop rcx

	ret
