; *******************************************************************************************
; *******************************************************************************************
;
;		Name : 		interface_test.asm
;		Purpose :	Assembler Interface Test
;		Date :		16th August 2019
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; *******************************************************************************************
; *******************************************************************************************

		.as	
		.xs

		* = $0000
		nop
		* = $300		

IFT_XCursor:	.byte ?
IFT_YCursor:	.byte ?
IFT_Buffer:		.fill 90
IFT_LineBuffer:	.fill 90

		* = $E000

		.include 	"interface_65816.asm"
		.include 	"interface_tools.asm"

TestCode:
		clc
		xce	
		rep 	#$30
		.al
		lda 	#$01FF 						; empty stack
		tcs
		lda 	#$0000
		tax
		tay
		.as
		sep 	#$30
		
;		ldx 		#$FF 					; empty stack
;		txs

		jsr 		IF_Reset 				; reset external interface
		jsr 		IFT_ClearScreen
Next:	jsr 		IFT_NewLine
WaitKey:jsr 		IFT_ReadLine
		jsr 		IFT_NewLine
		ldx 		#0
_OutLine:
		lda 		IFT_LineBuffer,x
		beq 		Next
		jsr 		IFT_PrintCharacter
		lda 		#"_"
		jsr 		IFT_PrintCharacter
		inx
		bra 		_OutLine		

DummyRoutine:
		rti
		* = $FFFA
		.word		DummyRoutine
		.word 		TestCode
		.word 		DummyRoutine
