C:\masm32\bin\ml.exe /c /coff /Fl sal.asm
C:\masm32\bin\link.exe /SUBSYSTEM:CONSOLE /LIBPATH:C:\masm32\lib\ sal.obj
pause
del sal.obj
start sal.exe
