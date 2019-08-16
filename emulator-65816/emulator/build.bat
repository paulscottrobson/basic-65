@echo off
copy ..\core\65816.*  .
copy ..\core\65816core.c  .
copy ..\core\traps.h .
mingw32-make 
copy m65816.exe ..\..\bin

rem ..\..\bin\64tass -x -Wall --ascii -b -f  test.asm -o test.rom
rem if errorlevel 1 goto :x
rem ..\..\bin\m65816.exe test.rom
rem :x
