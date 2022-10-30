.386
.model flat, stdcall
option casemap:none

include C:\masm32\include\windows.inc
include C:\masm32\include\kernel32.inc
includelib C:\masm32\lib\kernel32.lib

.data
string          db "Hello world", 0Ah, 0h
sConsoleTitle   db "My first project", 0

.data?
stdout          dd ?
cWritten        dd ?

.code
start:
    invoke SetConsoleTitle, offset sConsoleTitle
    invoke GetStdHandle, STD_OUTPUT_HANDLE
    
    mov stdout, eax
    mov cWritten, ebx
    
    invoke WriteConsole, stdout, offset string, sizeof string, offset cWritten, NULL
    invoke Sleep, INFINITE
    invoke ExitProcess, NULL
end start
