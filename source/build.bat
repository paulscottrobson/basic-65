@echo off
rem
rem		Build BASIC (EM4510)
rem
del \Q  memory.dump 
pushd scripts
rem python ftestgen.py >..\testing\script.inc
python fscript.py >..\testing\script.inc
popd
..\bin\64tass -x -Wall -b -f basic.asm  -L rom.lst -o rom.bin