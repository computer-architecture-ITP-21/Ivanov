; Определяет набор инструкций, которые могут использоваться в программме
.386 
; .model flat (Директова ассемблера, определяющая сегментную модель памяти приложения как плоскость)
; stdcall - говорит MASM32 о порядке передачи параметров (справа налево) 
.model flat, stdcall 
; Говорит MASM сделать метки чуствительными к регистру (ExitProcess != exitprocess) 
option casemap:none

; Подключение Библиотек 
; Добавляет содержимое файла в данную директиву
include C:\masm32\include\windows.inc
include C:\masm32\include\kernel32.inc
; Сообщает ассемблеру какие библиотеки использует программа 
includelib C:\masm32\lib\kernel32.lib 

; .data - Секция инициализированных данных
.data
string          db "Hello world", 0Ah, 0h
sConsoleTitle   db "My first project", 0
; .data? - Секция неинициализированных данных
.data?
stdout          dd ?
cWritten        dd ?

; Директива определяющая секцию программы  
.code
start:
    ; Определяет загаловок консоли, который указан в переменной sConsoleTitle 
    push offset sConsoleTitle
    call SetConsoleTitle
    
    ; Получам дискриптор
    push STD_OUTPUT_HANDLE
    call GetStdHandle
    mov stdout, eax
    mov cWritten, ebx

    ; вывод строки в консоль 
    push NULL
    push offset cWritten ; Заносит в стек указатель на переменную
    push sizeof string ; Получаем число символов в строке string
    push offset string ; Получаем адрес переменной string
    push stdout ; Заносит дискриптер в стек 
    call WriteConsole ; Записывает строку на экранный буфер консоли

    ; Вызывается бесконечная задержка
    push INFINITE
    call Sleep
    
    ; Завершение процесса
    push NULL ; Задание параметров функции ExitProcess через стек
    call ExitProcess ; вызов API-функции завершения процесса  
end start
