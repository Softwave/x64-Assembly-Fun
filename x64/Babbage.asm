; Babbage Problem
; Translated from AT&T syntax on RosettaCode 
; https://rosettacode.org/wiki/Babbage_problem#x86_Assembly

INCLUDE C:\masm32\include64\masm64rt.inc

.data 

.code 

main proc 
	conout "Babbage Problem",lf
	call babbage 
	mov r15, rax 
	conout "Answer: ", str$(rax),lf
	mov rax, r15 
	mul rax
	conout "Square: ", str$(rax)

	invoke ExitProcess
	ret 
main endp 

babbage proc 
	mov rbx, 1000000
	mov rcx, 1 
next: 
	mov rax, rcx 
	mul rax

	div rbx 

	cmp rdx, 269696 
	je done 
	inc rcx 
	jmp next 
done:
	; Return and print 
	mov rax, rcx 
	ret 

babbage endp 

end 