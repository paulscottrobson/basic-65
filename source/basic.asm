; *******************************************************************************************
; *******************************************************************************************
;
;		Name : 		basic.asm
;		Purpose :	Basic Main Program
;		Date :		16th August 2019
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; *******************************************************************************************
; *******************************************************************************************

		.if 		CPU=="65C02"
		.cpu 		"65c02"
		.endif

		.if 		CPU=="65816"
		.cpu 		"65816"
		.as
		.xs
		.endif

		* = $0000
		nop
		.include 	"data.asm"

		* = $A000
		.include 	"utility/tim.asm"
		
		* = $C000
		.include 	"integer/inttostr.asm"
		.include 	"integer/intfromstr.asm"
		.include 	"float/fpmacros.asm"
		.include 	"float/fputils.asm"
		.include 	"float/fpadd.asm"
		.include 	"float/fpmultiply.asm"
		.include 	"float/fpdivide.asm"
		.include 	"float/fpcompare.asm"
		.include 	"float/fpparts.asm"
		.include 	"float/fpfromstr.asm"
		.include 	"float/fptostr.asm"

		* = $E000
		.if 		CPU=="65C02"
		.include 	"interface/interface_6502.asm"
		.endif
		.if 		CPU=="65816"
		.include 	"interface/interface_65816.asm"
		.endif
		.include 	"interface/interface_tools.asm"

StartROM:
		.if 		CPU=="65816"
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
		.endif

		.if 		CPU=="65C02"
		ldx 		#$FF 					; empty stack
		txs
		.endif

		jsr 	IF_Reset 					; reset external interface
		jsr 	IFT_ClearScreen
;		jmp 	TIM_Start
		jsr 	FPTTest
		.byte 	$02
freeze:	bra 	freeze		

ERR_Handler:
		bra 	ERR_Handler

NMIHandler:
		rti

		.include 	"testing/fptest.asm"	

		* = $FFFA
		.word	NMIHandler
		.word 	StartROM
		.word 	TIM_BreakVector
