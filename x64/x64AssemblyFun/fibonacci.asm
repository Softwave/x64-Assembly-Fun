; Fibonacci.asm, program to calculate Fibonacci numbers 

.data 

.code 

FibonacciSub proc 
	dec rcx 
	mov rbx, 0 
	mov rax, 1

	test rcx, rcx 
	jnz FibLoop  
	ret 

FibLoop:
	push rax 
	add rax, rbx
	pop rbx 
	jno Print 
Overflow:
	mov rax, 0
	ret 

Print: 
	dec rcx 
	jnz FibLoop
	ret 

FibonacciSub endp 

END 