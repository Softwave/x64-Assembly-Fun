INCLUDE Irvine32.inc


.data 
prompt byte "Enter Fibonacci index: ", 0 

.code 
main proc 
	mov edx, offset prompt 
	call WriteString 
	call ReadInt 
	mov ecx, eax 
	call FibonacciSub 

	call WriteDec 
	exit
main endp

FibonacciSub proc
	dec ecx 
	mov ebx, 0
	mov eax, 1 

	test eax, eax 
	jnz FibLoop 
	ret 

FibLoop:
	push eax 
	add eax, ebx 
	pop ebx 
	jno Print 
Overflow:
	mov eax, 0 
	ret 

Print:
	dec ecx 
	jnz FibLoop 
	ret 

FibonacciSub endp 

END main 

