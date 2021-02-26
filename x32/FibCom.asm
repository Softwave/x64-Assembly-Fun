; FibCom.asm, small command-line utility for finding nth fibonacci numbers 
; Written in x86 assembly language 

.386 
.model flat, stdcall 
option casemap :none

include \masm32\include\kernel32.inc 
include \masm32\include\masm32.inc 

includelib \masm32\lib\kernel32.lib 
includelib \masm32\lib\masm32.lib 

; Prototypes 
FibonacciSub proto 

.data 
    OutputBuffer db 12 dup (?)
    ComArg db 10 dup (?)
.code 

start:
    invoke GetCL, 1, addr ComArg
    push offset ComArg
    call atol 
    mov ecx, eax
    call FibonacciSub
    invoke dwtoa, eax, addr OutputBuffer 
    invoke StdOut, addr OutputBuffer

    invoke ExitProcess, 0 


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

end start 
