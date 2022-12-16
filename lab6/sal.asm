;--------------------------------------------
; Программа на masm32 для Windows
; Исследование работы арифметического сопроцессора
; Вычислить 5 значений функции Yn = 4,3*(x^2 + 1)
; (x изменяется с шагом 1,7)
;--------------------------------------------
.686 					; в программе будут использоваться
						; команды процессора Pentium Pro
.model flat, stdcall 	; модель памяти и соглашение
						; о передаче параметров
option casemap :none 	; включается чувствительность
						; к регистру

; Библиотеки и подключаемые файлы проекта
;--------------------------------------------
include C:\masm32\include\windows.inc
include C:\masm32\include\kernel32.inc
include C:\masm32\include\user32.inc
include C:\masm32\include\fpu.inc
						; содержит прототип функции FpuFLtoA
includelib C:\masm32\lib\kernel32.lib
includelib C:\masm32\lib\user32.lib
includelib C:\masm32\lib\fpu.lib

; Сегмент даных
;--------------------------------------------
.data 					; инициализированные данные
MsgBoxTitle byte "Soproc x87 operations", 0
						; заголовок окна
MsgBoxText db "Function calculation Yn = 256*(3*x^2 + 31),", 13,
			  "where x changes with step 3", 13, 13,
			  "y1="
res1 db 14 DUP(0), 10, 13 	; зарезервировать 14 байт для первого
							; результата и поместить туда 0
	 db "y2="
res2 db 14 DUP(0), 10, 13
	 db "y3="
res3 db 14 DUP(0), 10, 13
	 db "y4="
res4 db 14 DUP(0), 10, 13
	 db "y5="
res5 db 14 DUP(0), 10, 13
	 db "y6="
res6 db 14 DUP(0), 10, 13

CrLf equ 0A0Dh
y1 TBYTE 0.0 				; тип 80 бит без знака (TBYTE = dt)
y2 dt 0.0
y3 dt 0.0
y4 dt 0.0
y5 dt 0.0
y6 dt 0.0
x DWORD 2.0 				; тип 32 бита без знака (DWORD = dd)
op1 dd 256.0
op2 dd 31.0
op3 dd 3.0
zero dd 0.0
step dd 3.0

.data? 						; неинициализированные данные

.const 						; константы

; Cегмент кода
;--------------------------------------------
.code
start: 						; метка (точка входа в программу)
	finit 					; инициализация регистров FPU
							; (CWR = 037Fh, SWR = 0h, TWR = FFFFh,
							; DPR = 0h, IPR = 0h)
	mov ecx, 6 				; счётчик X
m1: 						; метка начала цикла
	fld x 					; x^2
	fmul x
	fmul op3				; 3*x^2
	fadd op2 				; 3*x^2+31
	fdivr op1				; 256/(x^2+1)
	fld x 					; увеличение X на величину шага
	fadd step
	fstp x
	loop m1 				; если ecx = ecx - 1 != 0,
							; переходим на m1
	fstp y6					; сохраняем стек в память
	fstp y5 				
	fstp y4
	fstp y3
	fstp y2
	fstp y1
	
	; преобразование результатов вычислений в массив символов
	invoke FpuFLtoA, addr y1, 10, addr res1, SRC1_REAL or SRC2_DIMM
	mov word ptr res1 + 13, CrLf
	invoke FpuFLtoA, addr y2, 10, addr res2, SRC1_REAL or SRC2_DIMM
	mov word ptr res2 + 13, CrLf
	invoke FpuFLtoA, addr y3, 10, addr res3, SRC1_REAL or SRC2_DIMM
	mov word ptr res3 + 13, CrLf
	invoke FpuFLtoA, addr y4, 10, addr res4, SRC1_REAL or SRC2_DIMM
	mov word ptr res4 + 13, CrLf
	invoke FpuFLtoA, addr y5, 10, addr res5, SRC1_REAL or SRC2_DIMM
	mov word ptr res5 + 13, CrLf
	invoke FpuFLtoA, addr y6, 10, addr res6, SRC1_REAL or SRC2_DIMM
	
	; вывод результатов вычислений
	invoke MessageBox, NULL, addr MsgBoxText, addr MsgBoxTitle,
	MB_ICONINFORMATION
	
	invoke ExitProcess, NULL; функция завершения с параметром NULL
end start 					; окончание программы
