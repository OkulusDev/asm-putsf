section '.puts_char' executable			; секция вывода символа
; Ввод:
;  rax = char (регистр rax = символ)
puts_char:
    push rax
    push rdx
    push rsi
    push rdi

    push rax
    
    mov rsi, rsp
    mov rdi, 1
    mov rdx, 1
    mov rax, 1
    call do_syscall

    pop rax

    pop rdi
    pop rsi
    pop rdx
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
