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
