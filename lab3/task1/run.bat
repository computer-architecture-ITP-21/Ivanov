C:\masm32\bin\ml.exe /c /coff /Fl Test.asm
C:\masm32\bin\link.exe /SUBSYSTEM:CONSOLE /LIBPATH:C:\masm32\lib\ Test.obj
pause
del Test.obj
start Test.exe
