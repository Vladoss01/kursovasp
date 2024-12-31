.386
.model flat, stdcall
option casemap :none

include masm32\include\windows.inc
include masm32\include\kernel32.inc
include masm32\include\masm32.inc
include masm32\include\user32.inc
include masm32\include\msvcrt.inc
includelib masm32\lib\kernel32.lib
includelib masm32\lib\masm32.lib
includelib masm32\lib\user32.lib
includelib masm32\lib\msvcrt.lib

.DATA
;===User Data================================================================================
	_aaaaa2_	dw	0
	_aaaaaa_	dw	0
	_bbbbbb_	dw	0
	_ccccc1_	dw	0
	_ccccc2_	dw	0
	_xxxxxx_	dw	0

	String_0	db	"Read _aaaaaa: ", 0
	String_1	db	"Read _bbbbbb: ", 0
	String_2	db	"For To do", 0
	String_3	db	13, 10, 0
	String_4	db	13, 10, "For Downto do", 0
	String_5	db	13, 10, 0
	String_6	db	13, 10, "While _aaaaaa * _bbbbbb: ", 0
	String_7	db	13, 10, "Repeat Until _aaaaaa * _bbbbbb: ", 0

;===Addition Data============================================================================
	hConsoleInput	dd	?
	hConsoleOutput	dd	?
	endBuff			db	5 dup (?)
	msg1310			db	13, 10, 0

	CharsReadNum	dd	?
	InputBuf		db	15 dup (?)
	OutMessage		db	"%hd", 0
	ResMessage		db	20 dup (?)

.CODE
start:
invoke AllocConsole
invoke GetStdHandle, STD_INPUT_HANDLE
mov hConsoleInput, eax
invoke GetStdHandle, STD_OUTPUT_HANDLE
mov hConsoleOutput, eax
	invoke WriteConsoleA, hConsoleOutput, ADDR String_0, SIZEOF String_0 - 1, 0, 0
	call Input_
	mov _aaaaaa_, ax
	invoke WriteConsoleA, hConsoleOutput, ADDR String_1, SIZEOF String_1 - 1, 0, 0
	call Input_
	mov _bbbbbb_, ax
	invoke WriteConsoleA, hConsoleOutput, ADDR String_2, SIZEOF String_2 - 1, 0, 0
	push _aaaaaa_
	pop _aaaaa2_
forPasStart1:
	push _bbbbbb_
	push _aaaaa2_
	call Less_
	call Not_
	pop ax
	cmp ax, 0
	je forPasEnd1
	invoke WriteConsoleA, hConsoleOutput, ADDR String_3, SIZEOF String_3 - 1, 0, 0
	push _aaaaa2_
	push _aaaaa2_
	call Mul_
	call Output_
	push _aaaaa2_
	push word ptr 1
	call Add_
	pop _aaaaa2_
	jmp forPasStart1
forPasEnd1:
	invoke WriteConsoleA, hConsoleOutput, ADDR String_4, SIZEOF String_4 - 1, 0, 0
	push _bbbbbb_
	pop _aaaaa2_
forPasStart2:
	push _aaaaaa_
	push _aaaaa2_
	call Greate_
	call Not_
	pop ax
	cmp ax, 0
	je forPasEnd2
	invoke WriteConsoleA, hConsoleOutput, ADDR String_5, SIZEOF String_5 - 1, 0, 0
	push _aaaaa2_
	push _aaaaa2_
	call Mul_
	call Output_
	push _aaaaa2_
	push word ptr 1
	call Sub_
	pop _aaaaa2_
	jmp forPasStart2
forPasEnd2:
	invoke WriteConsoleA, hConsoleOutput, ADDR String_6, SIZEOF String_6 - 1, 0, 0
	push word ptr 0
	pop _xxxxxx_
	push word ptr 0
	pop _ccccc1_
whileStart2:
	push _ccccc1_
	push _aaaaaa_
	call Less_
	pop ax
	cmp ax, 0
	je whileEnd2
	push word ptr 0
	pop _ccccc2_
whileStart1:
	push _ccccc2_
	push _bbbbbb_
	call Less_
	pop ax
	cmp ax, 0
	je whileEnd1
	jmp whileEnd1
	push _xxxxxx_
	push word ptr 1
	call Add_
	pop _xxxxxx_
	push _ccccc2_
	push word ptr 1
	call Add_
	pop _ccccc2_
	jmp whileStart1
whileEnd1:
	push _ccccc1_
	push word ptr 1
	call Add_
	pop _ccccc1_
	jmp whileStart2
whileEnd2:
	push _xxxxxx_
	call Output_
	invoke WriteConsoleA, hConsoleOutput, ADDR String_7, SIZEOF String_7 - 1, 0, 0
	push word ptr 0
	pop _xxxxxx_
	push word ptr 1
	pop _ccccc1_
repeatStart2:
	push word ptr 1
	pop _ccccc2_
repeatStart1:
	push _xxxxxx_
	push word ptr 1
	call Add_
	pop _xxxxxx_
	push _ccccc2_
	push word ptr 1
	call Add_
	pop _ccccc2_
	push _ccccc2_
	push _bbbbbb_
	call Greate_
	call Not_
	pop ax
	cmp ax, 0
	je repeatEnd1
	jmp repeatStart1
repeatEnd1:
	push _ccccc1_
	push word ptr 1
	call Add_
	pop _ccccc1_
	push _ccccc1_
	push _aaaaaa_
	call Greate_
	call Not_
	pop ax
	cmp ax, 0
	je repeatEnd2
	jmp repeatStart2
repeatEnd2:
	push _xxxxxx_
	call Output_
exit_label:
invoke WriteConsoleA, hConsoleOutput, ADDR msg1310, SIZEOF msg1310 - 1, 0, 0
invoke ReadConsoleA, hConsoleInput, ADDR endBuff, 5, 0, 0
invoke ExitProcess, 0


;===Procedure Add============================================================================
Add_ PROC
	mov ax, [esp + 6]
	add ax, [esp + 4]
	mov [esp + 6], ax
	pop ecx
	pop ax
	push ecx
	ret
Add_ ENDP
;============================================================================================


;===Procedure Greate=========================================================================
Greate_ PROC
	pushf
	pop cx

	mov ax, [esp + 6]
	cmp ax, [esp + 4]
	jle greate_false
	mov ax, 1
	jmp greate_fin
greate_false:
	mov ax, 0
greate_fin:
	push cx
	popf

	mov [esp + 6], ax
	pop ecx
	pop ax
	push ecx
	ret
Greate_ ENDP
;============================================================================================


;===Procedure Input==========================================================================
Input_ PROC
	invoke ReadConsoleA, hConsoleInput, ADDR InputBuf, 13, ADDR CharsReadNum, 0
	invoke crt_atoi, ADDR InputBuf
	ret
Input_ ENDP
;============================================================================================


;===Procedure Less===========================================================================
Less_ PROC
	pushf
	pop cx

	mov ax, [esp + 6]
	cmp ax, [esp + 4]
	jge less_false
	mov ax, 1
	jmp less_fin
less_false:
	mov ax, 0
less_fin:
	push cx
	popf

	mov [esp + 6], ax
	pop ecx
	pop ax
	push ecx
	ret
Less_ ENDP
;============================================================================================


;===Procedure Mul============================================================================
Mul_ PROC
	mov ax, [esp + 6]
	imul word ptr [esp + 4]
	mov [esp + 6], ax
	pop ecx
	pop ax
	push ecx
	ret
Mul_ ENDP
;============================================================================================


;===Procedure Not============================================================================
Not_ PROC
	pushf
	pop cx

	mov ax, [esp + 4]
	cmp ax, 0
	jnz not_false
not_t1:
	mov ax, 1
	jmp not_fin
not_false:
	mov ax, 0
not_fin:
	push cx
	popf

	mov [esp + 4], ax
	ret
Not_ ENDP
;============================================================================================


;===Procedure Output=========================================================================
Output_ PROC value: word
	invoke wsprintf, ADDR ResMessage, ADDR OutMessage, value
	invoke WriteConsoleA, hConsoleOutput, ADDR ResMessage, eax, 0, 0
	ret 2
Output_ ENDP
;============================================================================================


;===Procedure Sub============================================================================
Sub_ PROC
	mov ax, [esp + 6]
	sub ax, [esp + 4]
	mov [esp + 6], ax
	pop ecx
	pop ax
	push ecx
	ret
Sub_ ENDP
;============================================================================================
end start
