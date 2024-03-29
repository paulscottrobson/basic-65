; *******************************************************************************************
; *******************************************************************************************
;
;		Name : 		data.asm
;		Purpose :	Memory Allocation Program
;		Date :		16th August 2019
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; *******************************************************************************************
; *******************************************************************************************

; *******************************************************************************************
;
;										Zero Page
;
; *******************************************************************************************

		* = $10 							; 0-1 is mapping, 2-F is reserved for i/f.

zTemp1:		.word ?							; temporary pointers
zTemp2:		.word ?
zTemp3:		.word ?

zLTemp1:	.dword ?						; long word (used in multiply)
zGenPtr:	.word ? 						; general pointer.

		* = $200

; *******************************************************************************************
;
;							Memory used by the Interface Tools
;
; *******************************************************************************************

IFT_XCursor:.byte ?							; current logical position on screen
IFT_YCursor:.byte ?
IFT_Buffer:	.fill 100 						; scroll copy buffer.
IFT_LineBuffer: .fill 100 					; line input buffer.

; *******************************************************************************************
;
;									   Buffers etc.
;
; *******************************************************************************************

		* = $300 							; expression stack area.

XS_Mantissa .dword ? 						; 4 byte mantissa, bit 31 set.
XS_Exponent .byte ?							; 1 byte exponent, 128 == 2^0 (float only)
XS_Type 	.byte ? 						; bit 7 sign (float only)
											; bit 6 zero (float only)
											; bit 2-3 type flags (zero)
											; bit 1 string flag
											; bit 0 integer flag.
											; float type when all type bits 0-3 are zero.

XS2_Mantissa = XS_Mantissa+6
XS2_Exponent = XS_Exponent+6
XS2_Type = XS_Type+6

		* = $400

Num_Buffer	.fill 	32 						; buffer for numeric conversions
NumBufX 	.byte 	?						; buffer index position
NumSuppress	.byte 	?						; leading zero suppression flag
NumConvCount .byte 	? 						; count for conversions.

Tim_PC:		.word ?							; program counter on BRK (Hi/Lo order)
Tim_IRQ:	.word ?							; IRQ Vector (Hi/Lo order)
Tim_SR:		.byte ? 						; Processor Status
Tim_A:		.byte ? 						; Processor Registers
Tim_X:		.byte ?
Tim_Y:		.byte ?
Tim_SP:		.byte ?							; Stack Pointer

ExpTemp:	.byte ?							; Working temp for exponents.
ExpCount:	.byte ? 						; Count of decimal exponents.
