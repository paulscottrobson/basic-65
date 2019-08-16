@echo off
rem
rem		Build BASIC
rem
del /Q  memory.dump 
pushd scripts
python ftestgen.py >..\testing\script.inc
rem python fscript.py >..\testing\script.inc
popd
echo "Building for 65c02"
..\bin\64tass -D CPU=\"65C02\"  -q -Wall -b -f basic.asm  -L rom.lst -o rom.bin
echo "Building for 65816"
..\bin\64tass -D CPU=\"65816\" -q -Wall -b -f basic.asm  -L rom.lst -o rom.bin
if errorlevel 1 goto x
..\bin\m65816.exe rom.bin go
python scripts\showxs.py
:x
