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
