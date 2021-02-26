; FibCom64.asm, small command-line utility for finding nth fibonacci numbers 
; Written in x86 assembly language 


include \masm32\include64\masm64rt.inc 

.data 
	ArgPointer dq 0 
	ArgCount dq 0
.code 

main proc
	; Get command line 
	CmdBegin ArgPointer, ArgCount 
	mov r12, ArgPointer 
	mov r13, ArgCount 
Loopy:
	add r12, 8
	sub r13, 1
	jnz Loopy 
	mov r12, ArgPointer

	invoke vc__atoi64, qword ptr [r12] 
	mov rcx, rax
    call FibonacciSub
	conout str$(rax)

	CmdEnd
    invoke ExitProcess, 0 

main endp


FibonacciSub proc 
	dec rcx 
	mov rbx, 0
	mov rax, 1 

	test rax, rax 
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

end