INCLUDE C:\masm32\include64\masm64rt.inc

.data?
      hInstance     dq ?
      hIcon         dq ?
      hList         dq ?
      lpListProc    dq ?
      hFont         dq ? 
      hEdit         dq ?

.code 

entry_point proc
    GdiPlusBegin 

    mov hInstance, rv(GetModuleHandle,0)

    invoke DialogBoxParam,hInstance,100,0,ADDR main
    

    GdiPlusEnd 

    invoke ExitProcess,0
    ret
entry_point endp

main proc hWin:QWORD,uMsg:QWORD,wParam:QWORD,lParam:QWORD
    LOCAL doodad :QWORD
    LOCAL buffer[64]:BYTE
    .switch uMsg 
        .case WM_INITDIALOG 
        invoke SetWindowText,hWin,"Fibonacci Calculator" 

        ; Setup list box 
        mov hList, rv(GetDlgItem, hWin, 104)
        invoke SetWindowLongPtr,hList,GWL_WNDPROC, ADDR ListProc 
        mov lpListProc, rax 
        ; End setup list box 
        
        ; Set font 
        mov hFont, rv(font_handle, "fixedsys", 9, 200)
        invoke SendMessage, hList, WM_SETFONT,hFont,TRUE
        

        ; Setup input box 
        mov hEdit, rv(GetDlgItem, hWin, 103) 

        mov hFont, rv(font_handle, "fixedsys", 9, 200)
        invoke SendMessage, hEdit, WM_SETFONT, hFont, TRUE

        ; End setup input box 


        .case WM_COMMAND
            .switch wParam 
                .case 101 
                    ; Reset box 
                    invoke SendMessage,hList,LB_RESETCONTENT,0,0
                    ; Get text 
                    invoke SendMessage,hEdit,WM_GETTEXT, 64, addr buffer
                    ;
                    invoke vc__atoi64, addr buffer ; Now the number is in rax
                    test rax, rax
                    jz InvalidInput
                    js InvalidInput
                    mov rcx, rax
                    mov rdx, 0 
loopo:
                    mov r15, rcx 
                    
                    call FibonacciSub 
contloopo:
                    invoke SendMessage,hList,LB_INSERTSTRING,0,str$(rax)

                    mov rcx, r15 
                    inc rdx 
                    loop loopo 
                    jmp EndZero 

InvalidInput:
                    ;invoke SendMessage,hList,LB_ADDSTRING,0,str$(-1)
                    invoke MessageBox,hWin, chr$("You have entered invalid input",0), "Error", MB_OK
EndZero: 



                .case 102 
                    invoke MessageBox,hWin, chr$("Program that calculates Fibonacci numbers",13,10,"By Jessica Leyba, 2021",0), "About", MB_OK

            .endsw 

        .case WM_CLOSE 
            exit_dialog:
                invoke EndDialog,hWin,0
    .endsw 
    .return 0
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

ListProc proc hWin:QWORD,uMsg:QWORD,wParam:QWORD,lParam:QWORD
invoke CallWindowProc,lpListProc,hWin,uMsg,wParam,lParam
    ret 
ListProc endp



end 