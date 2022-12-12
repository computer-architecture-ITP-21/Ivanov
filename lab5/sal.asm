.386
.model flat, stdcall
option casemap:none

include C:\masm32\include\windows.inc
include C:\masm32\include\kernel32.inc
includelib C:\masm32\lib\kernel32.lib

.data
a sword 25
b sword -6

.data?

.code
start:
	mov ax, b
	imul ax, b
	mov bx, b
	imul bx, 2
	sub ax, bx
	mov cx, a
	imul cx, 3
	add cx, b
	idiv cx
	
    invoke ExitProcess, NULL
end start