@echo off
rem
rem		Test interface 
rem
..\..\bin\64tass -x -Wall -b -f  -b interface_test.asm  -L rom.lst -o rom.bin
if errorlevel 1 goto x
..\..\bin\m65816.exe rom.bin go
:x