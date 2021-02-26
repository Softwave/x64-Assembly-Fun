; Arithmetic.asm, simple math routines in assembly 

.data 
number dq 10 
srresult dq 0 
.code 

DoubleSub proc 
	mov rax, 2 
	mul rcx 
	ret 
DoubleSub endp 

SumSub proc 
	mov rax, rcx 
	add rax, rdx 
	ret 
SumSub endp 

SquareSub proc 
	mov rax, rcx
	mul rcx 
	ret 
SquareSub endp 

FactorialSub proc 
	mov rax, 1
FactLoop:
	mul rcx 
	loop FactLoop 
	ret 
FactorialSub endp 

SquareRootSub proc 
	mov srresult, rcx 
	fild srresult 
	fsqrt 
	fistp srresult 
	mov rax, srresult 
	ret 
SquareRootSub endp 

END 