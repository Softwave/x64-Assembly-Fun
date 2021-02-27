; Work-in-progress program to display Fibonacci numbers in a GUI 

    include C:\masm32\include64\masm64rt.inc

    .data?
      hInstance     dq ?
      hIcon         dq ?
      hList         dq ?
      lpListProc    dq ?
      hFont         dq ?

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
    .switch uMsg 
        .case WM_INITDIALOG 

        invoke SetWindowText,hWin,"Factorial Program"
        ; Setup list box 
        mov hList, rv(GetDlgItem,hWin,103) 
        ; Subclass 
        invoke SetWindowLongPtr,hList,GWL_WNDPROC, ADDR ListProc
        mov lpListProc, rax 

  
        
        ; Set font 
        mov hFont, rv(font_handle, "fixedsys", 9, 200)
        invoke SendMessage, hList, WM_SETFONT,hFont,TRUE
        
        
        ; Add items 
        mov rcx, 20
        mov rdx, 0
loopo:
        mov r15, rcx 
        call FactProc 
contloopo:
        ;invoke SendMessage, hList, LB_ADDSTRING, 0, str$(rax)
        invoke SendMessage, hList, LB_INSERTSTRING, 0, str$(rax)
         
        mov rcx, r15 
        inc rdx 
        loop loopo



        .return TRUE 

        .case WM_COMMAND 
            .switch wParam 
                .case 101 
                    jmp exit_dialog
                .case 102 
                    invoke MessageBox,hWin, chr$("Program that graphically displays Fibonacci numbers",13,10,"By Jessica Leyba, 2021",0), "About", MB_OK
                    

            .endsw 

        .case WM_CLOSE 
            exit_dialog:
            invoke EndDialog,hWin,0 
  
    .endsw 

    .return 0 
   
main endp

ListProc proc hWin:QWORD,uMsg:QWORD,wParam:QWORD,lParam:QWORD
    LOCAL csel  :QWORD
    LOCAL lbuf  :QWORD
    LOCAL lbuffr[64]:BYTE

    .switch uMsg 
        .case WM_LBUTTONDBLCLK
            mov csel, rv(SendMessage, hWin, LB_GETCURSEL, 0, 0)
            mov lbuf, ptr$(lbuffr)
            invoke SendMessage, hWin, LB_GETTEXT,csel,lbuf 
            inc csel 
            mcat lbuf, "Fibonacci number: ", str$(csel)
            invoke MessageBox,hWin,lbuf,"You Selected",MB_OK
    .endsw 

    invoke CallWindowProc,lpListProc,hWin,uMsg,wParam,lParam
    ret 
ListProc endp 

FactProc proc 
    mov rax, 1 
FactLoop:
    mul rcx 
    loop FactLoop 
    ret 
FactProc endp 



end
