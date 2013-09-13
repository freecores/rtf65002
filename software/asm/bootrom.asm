; ============================================================================
;        __
;   \\__/ o\    (C) 2013  Robert Finch, Stratford
;    \  __ /    All rights reserved.
;     \/_//     robfinch<remove>@opencores.org
;       ||
;  
;
; This source file is free software: you can redistribute it and/or modify 
; it under the terms of the GNU Lesser General Public License as published 
; by the Free Software Foundation, either version 3 of the License, or     
; (at your option) any later version.                                      
;                                                                          
; This source file is distributed in the hope that it will be useful,      
; but WITHOUT ANY WARRANTY; without even the implied warranty of           
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            
; GNU General Public License for more details.                             
;                                                                          
; You should have received a copy of the GNU General Public License        
; along with this program.  If not, see <http://www.gnu.org/licenses/>.    
;                                                                          
; ============================================================================
;
CR	EQU	0x0D		;ASCII equates
LF	EQU	0x0A
TAB	EQU	0x09
CTRLC	EQU	0x03
CTRLH	EQU	0x08
CTRLI	EQU	0x09
CTRLJ	EQU	0x0A
CTRLK	EQU	0x0B
CTRLM   EQU 0x0D
CTRLS	EQU	0x13
CTRLX	EQU	0x18
XON		EQU	0x11
XOFF	EQU	0x13

TEXTSCR		EQU		0xFFD00000
COLORSCR	EQU		0xFFD10000
TEXTREG		EQU		0xFFDA0000
TEXT_COLS	EQU		0x0
TEXT_ROWS	EQU		0x1
TEXT_CURPOS	EQU		11
KEYBD		EQU		0xFFDC0000
KEYBDCLR	EQU		0xFFDC0001
PIC			EQU		0xFFDC0FF0
PIC_IE		EQU		0xFFDC0FF1

SPIMASTER	EQU		0xFFDC0500
SPI_MASTER_VERSION_REG	EQU	0x00
SPI_MASTER_CONTROL_REG	EQU	0x01
SPI_TRANS_TYPE_REG	EQU		0x02
SPI_TRANS_CTRL_REG	EQU		0x03
SPI_TRANS_STATUS_REG	EQU	0x04
SPI_TRANS_ERROR_REG		EQU	0x05
SPI_DIRECT_ACCESS_DATA_REG		EQU	0x06
SPI_SD_SECT_7_0_REG		EQU	0x07
SPI_SD_SECT_15_8_REG	EQU	0x08
SPI_SD_SECT_23_16_REG	EQU	0x09
SPI_SD_SECT_31_24_REG	EQU	0x0a
SPI_RX_FIFO_DATA_REG	EQU	0x10
SPI_RX_FIFO_DATA_COUNT_MSB	EQU	0x12
SPI_RX_FIFO_DATA_COUNT_LSB  EQU 0x13
SPI_RX_FIFO_CTRL_REG		EQU	0x14
SPI_TX_FIFO_DATA_REG	EQU	0x20
SPI_TX_FIFO_CTRL_REG	EQU	0x24
SPI_RESP_BYTE1			EQU	0x30
SPI_RESP_BYTE2			EQU	0x31
SPI_RESP_BYTE3			EQU	0x32
SPI_RESP_BYTE4			EQU	0x33
SPI_INIT_SD			EQU		0x01
SPI_TRANS_START		EQU		0x01
SPI_TRANS_BUSY		EQU		0x01
SPI_INIT_NO_ERROR	EQU		0x00
SPI_READ_NO_ERROR	EQU		0x00
SPI_WRITE_NO_ERROR	EQU		0x00
RW_READ_SD_BLOCK	EQU		0x02
RW_WRITE_SD_BLOCK	EQU		0x03

BITMAPSCR	EQU		0x04000000
SECTOR_BUF	EQU		0x05FFEC00
BYTE_SECTOR_BUF	EQU	SECTOR_BUF<<2
PROG_LOAD_AREA	EQU		0x4080000<<2

macro m_lsr8
lsr
lsr
lsr
lsr
lsr
lsr
lsr
lsr
endm

macro m_asl8
asl
asl
asl
asl
asl
asl
asl
asl
endm

; BIOS vars at the top of the 8kB scratch memory
;
JMPTMP		EQU		0x7A0
SP8Save		EQU		0x7AE
SRSave		EQU		0x7AF
R1Save		EQU		0x7B0
R2Save		EQU		0x7B1
R3Save		EQU		0x7B2
R4Save		EQU		0x7B3
R5Save		EQU		0x7B4
R6Save		EQU		0x7B5
R7Save		EQU		0x7B6
R8Save		EQU		0x7B7
R9Save		EQU		0x7B8
R10Save		EQU		0x7B9
R11Save		EQU		0x7BA
R12Save		EQU		0x7BB
R13Save		EQU		0x7BC
R14Save		EQU		0x7BD
R15Save		EQU		0x7BE
SPSave		EQU		0x7BF

CharColor	EQU		0x7C0
ScreenColor	EQU		0x7C1
CursorRow	EQU		0x7C2
CursorCol	EQU		0x7C3
CursorFlash	EQU		0x7C4
Milliseconds	EQU		0x7C5
IRQFlag		EQU		0x7C6

KeybdHead	EQU		0x7D0
KeybdTail	EQU		0x7D1
KeybdEcho	EQU		0x7D2
KeybdBad	EQU		0x7D3
KeybdAck	EQU		0x7D4
KeybdBuffer	EQU		0x7D5	; buffer is 16 chars
KeybdLocks	EQU		0x7E5

startSector	EQU		0x7F0


	cpu		rtf65002
	code

	; jump table of popular BIOS routines
	org		$FFFFC000
	dw	DisplayChar
	dw	KeybdCheckForKeyDirect
	dw	KeybdGetCharDirect

	org		$FFFFC200		; leave room for 128 vectors
KeybdRST
start
	sei						; disable interrupts
	cld						; disable decimal mode
	ldx		#$05FFFFF8		; setup stack pointer top of memory
	txs
	trs		r0,dp			; set direct page register
	trs		r0,dp8			; and 8 bit mode direct page
	trs		r0,abs8			; and 8 bit mode absolute address offset

	; setup interrupt vectors
	ldx		#$05FFF001		; interrupt vector table from $5FFF000 to $5FFF1FF
							; also sets nmoi policy (native mode on interrupt)
	trs		r2,vbr
	dex
	lda		#brk_rout
	sta		(x)
	lda		#slp_rout
	sta		1,x
	lda		#KeybdRST
	sta		448+1,x
	lda		#p1000Hz
	sta		448+2,x
	lda		#p100Hz
	sta		448+3,x
	lda		#KeybdIRQ
	sta		448+15,x

	emm
	cpu		W65C02
	ldx		#$FF			; set 8 bit stack pointer
	txs
	nat
	cpu		rtf65002
	lda		#$CE			; CE =blue on blue FB = grey on grey
	sta		ScreenColor
	sta		CharColor
	jsr		ClearScreen
	jsr		ClearBmpScreen
	stz		CursorRow
	stz		CursorCol
	lda		#msgStart
	jsr		DisplayStringB
	jsr		KeybdInit
	lda		#1
	sta		KeybdEcho
	jsr		PICInit
	cli						; enable interrupts
	jmp		Monitor
st1
	jsr		KeybdGetCharDirect
	bra		st1
	stp
	bra		start
	
msgStart
	db		"RTF65002 system starting.",$0d,$0a,00

;----------------------------------------------------------
; Initialize programmable interrupt controller (PIC)
;  0 = nmi (parity error)
;  1 = keyboard reset
;  2 = 1000Hz pulse (context switcher)
;  3 = 100Hz pulse (cursor flash)
;  4 = ethmac
;  8 = uart
; 13 = raster interrupt
; 15 = keyboard char
;----------------------------------------------------------
PICInit:
	; enable: raster irq,
	lda		#$000F			; enable nmi,kbd_rst,and kbd_irq
	; A10F enable serial IRQ
	sta		PIC_IE
PICret:
	rts

;------------------------------------------------------------------------------
; Clear the screen and the screen color memory
; We clear the screen to give a visual indication that the system
; is working at all.
;------------------------------------------------------------------------------
;
ClearScreen:
	pha							; holds a space character
	phx							; loop counter
	phy							; memory addressing
	push	r4					; holds the screen color
	lda		TEXTREG+TEXT_COLS	; calc number to clear
	ldx		TEXTREG+TEXT_ROWS
	mul		r2,r1,r2			; r2 = # chars to clear
	lda		#' '				; space char
	ld		r4,ScreenColor
	jsr		AsciiToScreen
	ldy		#TEXTSCR			; text screen address
csj4:
	sta		(y)
	st		r4,$10000,y			; color screen is 0x10000 higher
	iny
	dex
	bne		csj4
	pop		r4
	ply
	plx
	pla
	rts

;------------------------------------------------------------------------------
; Scroll text on the screen upwards
;------------------------------------------------------------------------------
;
ScrollUp:
	pha
	phx
	phy
	push	r4
	push	r5
	lda		TEXTREG+TEXT_COLS	; acc = # text columns
	ldx		TEXTREG+TEXT_ROWS
	mul		r2,r1,r2			; calc number of chars to scroll
	sub		r2,r2,r1			; one less row
	ldy		#TEXTSCR
scrup1:
	add		r5,r3,r1
	ld		r4,(r5)				; move character
	st		r4,(y)
	ld		r4,$10000,r5		; and move color code
	st		r4,$10000,y
	iny
	dex
	bne		scrup1
	lda		TEXTREG+TEXT_ROWS
	dea
	jsr		BlankLine
	pop		r5
	pop		r4
	ply
	plx
	pla
	rts

;------------------------------------------------------------------------------
; Blank out a line on the display
; line number to blank is in acc
;------------------------------------------------------------------------------
;
BlankLine:
	pha
	phx
	phy
	ldx		TEXTREG+TEXT_COLS	; x = # chars to blank out from video controller
	mul		r3,r2,r1			; y = screen index (row# * #cols)
	add		r3,r3,#TEXTSCR		; y = screen address
	lda		#' '
blnkln1:
	sta		(y)
	iny
	dex
	bne		blnkln1
	ply
	plx
	pla
	rts

;------------------------------------------------------------------------------
; Convert ASCII character to screen display character.
;------------------------------------------------------------------------------
;
AsciiToScreen:
	and		#$FF
	cmp		#'A'
	bcc		atoscr1		; blt
	cmp		#'Z'
	bcc		atoscr1
	beq		atoscr1
	cmp		#'z'+1
	bcs		atoscr1
	cmp		#'a'
	bcc		atoscr1
	sub		#$60
atoscr1:
	or		#$100
	rts

;------------------------------------------------------------------------------
; Convert screen character to ascii character
;------------------------------------------------------------------------------
;
ScreenToAscii:
	and		#$FF
	cmp		#26+1
	bcs		stasc1
	add		#$60
stasc1:
	rts

;------------------------------------------------------------------------------
; Calculate screen memory location from CursorRow,CursorCol.
; Also refreshes the cursor location.
; Returns:
; r1 = screen location
;------------------------------------------------------------------------------
;
CalcScreenLoc:
	phx
	lda		CursorRow
	ldx		TEXTREG+TEXT_COLS
	mul		r2,r2,r1
	add		r2,r2,CursorCol
	stx		TEXTREG+TEXT_CURPOS
	add		r1,r2,#TEXTSCR	; r1 = screen location	
	plx
	rts

;------------------------------------------------------------------------------
; Display a character on the screen
; r1 = char to display
;------------------------------------------------------------------------------
;
DisplayChar:
	cmp		#'\r'				; carriage return ?
	bne		dccr
	stz		CursorCol			; just set cursor column to zero on a CR
	jsr		CalcScreenLoc
	rts
dccr:
	cmp		#$91				; cursor right ?
	bne		dcx6
	pha
	lda		CursorCol
	cmp		#83
	bcs		dcx7
	ina
	sta		CursorCol
dcx7:
	jsr		CalcScreenLoc
	pla
	rts
dcx6:
	cmp		#$90				; cursor up ?
	bne		dcx8		
	pha
	lda		CursorRow
	beq		dcx7
	dea
	sta		CursorRow
	bra		dcx7
dcx8:
	cmp		#$93				; cursor left ?
	bne		dcx9
	pha
	lda		CursorCol
	beq		dcx7
	dea
	sta		CursorCol
	bra		dcx7
dcx9:
	cmp		#$92				; cursor down ?
	bne		dcx10
	pha
	lda		CursorRow
	cmp		#46
	beq		dcx7
	ina
	sta		CursorRow
	bra		dcx7
dcx10:
	cmp		#$94				; cursor home ?
	bne		dcx11
	pha
	lda		CursorCol
	beq		dcx12
	stz		CursorCol
	bra		dcx7
dcx12:
	stz		CursorRow
	bra		dcx7
dcx11:
	pha
	phx
	phy
	cmp		#$99				; delete ?
	bne		dcx13
	jsr		CalcScreenLoc
	tay							; y = screen location
	lda		CursorCol			; acc = cursor column
	bra		dcx5
dcx13	
	cmp		#CTRLH				; backspace ?
	bne		dcx3
	lda		CursorCol
	beq		dcx4
	dea
	sta		CursorCol
	jsr		CalcScreenLoc		; acc = screen location
	tay							; y = screen location
	lda		CursorCol
dcx5:
	ldx		$4,y
	stx		(y)
	iny
	ina
	cmp		TEXTREG+TEXT_COLS
	bcc		dcx5
	lda		#' '
	jsr		AsciiToScreen
	dey
	sta		(y)
	bra		dcx4
dcx3:
	cmp		#'\n'			; linefeed ?
	beq		dclf
	tax						; save acc in x
	jsr 	CalcScreenLoc	; acc = screen location
	tay						; y = screen location
	txa						; restore r1
	jsr		AsciiToScreen	; convert ascii char to screen char
	sta		(y)
	lda		CharColor
	sta		$10000,y
	jsr		IncCursorPos
	bra		dcx4
dclf:
	jsr		IncCursorRow
dcx4:
	ply
	plx
	pla
	rts

;------------------------------------------------------------------------------
; Increment the cursor position, scroll the screen if needed.
;------------------------------------------------------------------------------
;
IncCursorPos:
	pha
	phx
	lda		CursorCol
	ina
	sta		CursorCol
	ldx		TEXTREG+TEXT_COLS
	cmp		r1,r2
	bcc		icc1
	stz		CursorCol		; column = 0
	bra		icr1
IncCursorRow:
	pha
	phx
icr1:
	lda		CursorRow
	ina
	sta		CursorRow
	ldx		TEXTREG+TEXT_ROWS
	cmp		r1,r2
	bcc		icc1
	beq		icc1
	dex							; backup the cursor row, we are scrolling up
	stx		CursorRow
	jsr		ScrollUp
icc1:
	jsr		CalcScreenLoc
	plx
	pla
	rts

;------------------------------------------------------------------------------
; Display a string on the screen.
; The characters are packed 4 per word
;------------------------------------------------------------------------------
;
DisplayStringB:
	pha
	phx
	tax						; r2 = pointer to string
dspj1B:
	lb		r1,0,x			; move string char into acc
	inx						; increment pointer
	cmp		#0				; is it end of string ?
	beq		dsretB
	jsr		DisplayChar		; display character
	bra		dspj1B
dsretB:
	plx
	pla
	rts

;------------------------------------------------------------------------------
; Display a string on the screen.
; The characters are packed 1 per word
;------------------------------------------------------------------------------
;
DisplayStringW:
	pha
	phx
	tax						; r2 = pointer to string
dspj1W:
	lda		(x)				; move string char into acc
	inx						; increment pointer
	cmp		#0				; is it end of string ?
	beq		dsretW
	jsr		DisplayChar		; display character
	bra		dspj1W			; go back for next character
dsretW:
	plx
	pla
	rts

DisplayStringCRLFB:
	jsr		DisplayStringB
CRLF:
	pha
	lda		#'\r'
	jsr		DisplayChar
	lda		#'\n'
	jsr		DisplayChar
	pla
	rts

;------------------------------------------------------------------------------
; Initialize keyboard
;
; Issues a 'reset keyboard' command to the keyboard, then selects scan code
; set #2 (the most common one). Also sets up the keyboard buffer and
; initializes the keyboard semaphore.
;------------------------------------------------------------------------------
;
KeybdInit:
	lda		#1			; setup semaphore
;	sta		KEYBD_SEMA
	stz		KeybdHead		; setup keyboard buffer
	stz		KeybdTail
	lda		#1			; turn on keyboard echo
	sta		KeybdEcho
	stz		KeybdBad
	
	lda		#$ff		; issue keyboard reset
	jsr		SendByteToKeybd
	lda		#1000000		; delay a bit
kbdi5:
	dea
	bne		kbdi5
	lda		#0xf0		; send scan code select
	jsr		SendByteToKeybd
	ldx		#0xFA
	jsr		WaitForKeybdAck
	cmp		#$FA
	bne		kbdi2
	lda		#2			; select scan code set#2
	jsr		SendByteToKeybd
kbdi2:
	rts

msgBadKeybd:
	db		"Keyboard not responding.",0

SendByteToKeybd:
	sta		KEYBD
	tsr		TICK,r3
kbdi4:						; wait for transmit complete
	tsr		TICK,r4
	sub		r4,r4,r3
	cmp		r4,#1000000
	bcs		kbdbad
	lda		KEYBD+3
	bit		#64
	beq		kbdi4
	bra		sbtk1
kbdbad:
	lda		KeybdBad
	bne		sbtk1
	lda		#1
	sta		KeybdBad
	lda		#msgBadKeybd
	jsr		DisplayStringCRLFB
sbtk1:
	rts
	
; Wait for keyboard to respond with an ACK (FA)
;
WaitForKeybdAck:
	tsr		TICK,r3
wkbdack1:
	tsr		TICK,r4
	sub		r4,r4,r3
	cmp		r4,#1000000
	bcs		wkbdbad
	lda		KEYBD
	bit		#$8000
	beq		wkbdack1
;	lda		KEYBD+8
	and		#$ff
wkbdbad:
	rts

; Wait for keyboard to respond with an ACK (FA)
; This routine picks up the ack status left by the
; keyboard IRQ routine.
; r2 = 0xFA (could also be 0xEE for echo command)
;
WaitForKeybdAck2:
	lda		KeybdAck
	cmp		r1,r2
	bne		WaitForKeybdAck2
	stz		KeybdAck
	rts

;------------------------------------------------------------------------------
; Normal keyboard interrupt, the lowest priority interrupt in the system.
; Grab the character from the keyboard device and store it in a buffer.
; Doesn't use the stack.
;------------------------------------------------------------------------------
;
KeybdIRQ:
	pha
	phx
	phy
	ldx		KEYBD				; get keyboard character
	ld		r0,KEYBD+1			; clear keyboard strobe (turns off the IRQ)
	txy							; check for a keyboard ACK code
	and		r3,r3,#$ff
	cmp		r3,#$FA
	bne		KeybdIrq1
	sty		KeybdAck
	bra		KeybdIRQc
KeybdIrq1:
	bit		r2,#$800				; test bit #11
	bne		KeybdIRQc				; ignore keyup messages for now
	lda		KeybdHead			
	ina								; increment head pointer
	and		#$f						; limit
	ldy		KeybdTail				; check for room in the keyboard buffer
	cmp		r1,r3
	beq		KeybdIRQc				; if no room, the newest char will be lost
	sta		KeybdHead
	dea
	and		#$f
	stx		KeybdBuffer,r1			; store character in buffer
	stx		KeybdLocks
KeybdIRQc:
	ply
	plx
	pla
	rti

KeybdRstIRQ:
	jmp		ColdStart

;------------------------------------------------------------------------------
; r1 0=echo off, non-zero = echo on
;------------------------------------------------------------------------------
SetKeyboardEcho:
	sta		KeybdEcho
	rts

;-----------------------------------------
; Get character from keyboard buffer
; return character in acc or -1 if no
; characters available
;-----------------------------------------
KeybdGetChar:
	phx
	ldx		KeybdTail	; if keybdTail==keybdHead then there are no 
	lda		KeybdHead	; characters in the keyboard buffer
	cmp		r1,r2
	beq		nochar
	lda		KeybdBuffer,x
	and		r1,r1,#$ff		; mask off control bits
	inx						; increment index
	and		r2,r2,#$0f
	stx		KeybdTail
	ldx		KeybdEcho
	beq		kgc3
	cmp		#CR
	bne		kgc2
	jsr		CRLF			; convert CR keystroke into CRLF
	bra		kgc3
kgc2:
	jsr		DisplayChar
	bra		kgc3
nochar:
	lda		#-1
kgc3:
	plx
	rts

;------------------------------------------------------------------------------
; Check if there is a keyboard character available in the keyboard buffer.
;------------------------------------------------------------------------------
;
KeybdCheckForKey:
	phx
	lda		KeybdTail
	ldx		KeybdHead
	sub		r1,r1,r2
	bne		kcfk1
	plx
	rts
kcfk1
	lda		#1
	plx
	rts
message "668"
;------------------------------------------------------------------------------
; Check if there is a keyboard character available. If so return true (1)
; otherwise return false (0) in r1.
;------------------------------------------------------------------------------
;
KeybdCheckForKeyDirect:
	lda		KEYBD
	and		#$8000
	beq		kcfkd1
	lda		#1
kcfkd1
	rts

;------------------------------------------------------------------------------
; Get character directly from keyboard. This routine blocks until a key is
; available.
;------------------------------------------------------------------------------
;
KeybdGetCharDirect:
	phx
kgc1:
	lda		KEYBD
	bit		#$8000
	beq		kgc1
	ld		r0,KEYBD+1		; clear keyboard strobe
	bit		#$800			; is it a keydown event ?
	bne		kgc1
	and		#$ff			; remove strobe bit
	ldx		KeybdEcho		; is keyboard echo on ?
	beq		gk1
	cmp		#CR
	bne		gk2				; convert CR keystroke into CRLF
	jsr		CRLF
	bra		gk1
gk2:
	jsr		DisplayChar
gk1:
	plx
	rts


;------------------------------------------------------------------------------
; Display nybble in r1
;------------------------------------------------------------------------------
;
DisplayNybble:
	pha
	and		#$0F
	add		#'0'
	cmp		#'9'+1
	bcc		dispnyb1
	add		#7
dispnyb1:
	jsr		DisplayChar
	pla
	rts

;------------------------------------------------------------------------------
; Display the byte in r1
;------------------------------------------------------------------------------
;
DisplayByte:
	pha
	lsr		r1,r1,#4
	jsr		DisplayNybble
	pla
	jmp		DisplayNybble	; tail rts 
message "785"
;------------------------------------------------------------------------------
; Display the half-word in r1
;------------------------------------------------------------------------------
;
DisplayHalf:
	pha
	lsr		r1,r1,#8
	jsr		DisplayByte
	pla
	jsr		DisplayByte
	rts

message "797"
;------------------------------------------------------------------------------
; Display the half-word in r1
;------------------------------------------------------------------------------
;
DisplayWord:
	pha
	lsr		r1,r1,#16
	jsr		DisplayHalf
	pla
	jsr		DisplayHalf
	rts
message "810"
;------------------------------------------------------------------------------
; Display memory pointed to by r2.
; destroys r1,r3
;------------------------------------------------------------------------------
;
DisplayMemW:
	pha
	lda		#':'
	jsr		DisplayChar
	txa
	jsr		DisplayWord
	lda		#' '
	jsr		DisplayChar
	lda		(x)
	jsr		DisplayWord
	inx
	lda		#' '
	jsr		DisplayChar
	lda		(x)
	jsr		DisplayWord
	inx
	lda		#' '
	jsr		DisplayChar
	lda		(x)
	jsr		DisplayWord
	inx
	lda		#' '
	jsr		DisplayChar
	lda		(x)
	jsr		DisplayWord
	inx
	jsr		CRLF
	pla
	rts
message "845"
;==============================================================================
; System Monitor Program
;==============================================================================
;
Monitor:
	ldx		#$05FFFFF8		; setup stack pointer top of memory
	txs
	stz		KeybdEcho		; turn off keyboard echo
PromptLn:
	jsr		CRLF
	lda		#'$'
	jsr		DisplayChar

; Get characters until a CR is keyed
;
Prompt3:
;	lw		r1,#2			; get keyboard character
;	syscall	#417
	jsr		KeybdCheckForKeyDirect
	cmp		#0
	beq		Prompt3
	jsr		KeybdGetCharDirect
	cmp		#CR
	beq		Prompt1
	jsr		DisplayChar
	bra		Prompt3

; Process the screen line that the CR was keyed on
;
Prompt1:
	stz		CursorCol		; go back to the start of the line
	jsr		CalcScreenLoc	; r1 = screen memory location
	tay
	lda		(y)
	iny
	jsr		ScreenToAscii
	cmp		#'$'
	bne		Prompt2			; skip over '$' prompt character
	lda		(y)
	iny
	jsr		ScreenToAscii

; Dispatch based on command character
;
Prompt2:
	cmp		#':'
	beq		EditMem
	cmp		#'D'
	bne		Prompt8
	lda		(y)
	iny
	jsr		ScreenToAscii
	cmp		#'R'
	beq		DumpReg
	dey
	bra		DumpMem
Prompt8:
	cmp		#'F'
	beq		FillMem
Prompt7:
	cmp		#'B'			; $B - start tiny basic
	bne		Prompt4
	jsr		CSTART
	bra		Monitor
Prompt4:
	cmp		#'b'
	bne		Prompt5
	emm
	cpu		W65C02
	jml		$0C000
	cpu		rtf65002
Prompt5:
	cmp		#'J'			; $J - execute code
	beq		ExecuteCode
	cmp		#'L'			; $L - load S19 file
	bne		Prompt9
	jmp		LoadSector
Prompt9:
	cmp		#'?'			; $? - display help
	bne		Prompt10
	lda		#HelpMsg
	jsr		DisplayStringB
	jmp		Monitor
Prompt10:
	cmp		#'C'			; $C - clear screen
	beq		TestCLS
	cmp		#'R'
	bne		Prompt12
	jmp		RandomLinesCall
Prompt12:
Prompt13:
	cmp		#'P'
	bne		Prompt14
	jmp		Piano
Prompt14:
	cmp		#'T'
	bne		Prompt15
	call	tmp_read
Prompt15:
	cmp		#'S'
	bne		Prompt16
	jsr		spi_init
	cmp		#0
	bne		Monitor
	jsr		spi_read_part
	cmp		#0
	bne		Monitor
	jsr		spi_read_boot
	cmp		#0
	bne		Monitor
	jsr		loadBootFile
	jmp		Monitor
Prompt16:
	jmp		Monitor
message "Prompt16"
RandomLinesCall:
	jsr		RandomLines
	jmp		Monitor

TestCLS:
	lda		(y)
	iny
	jsr		ScreenToAscii
	cmp		#'L'
	bne		Monitor
	lda		(y)
	iny
	jsr		ScreenToAscii
	cmp		#'S'
	bne		Monitor
	jsr 	ClearScreen
	stz		CursorCol
	stz		CursorRow
	jsr		CalcScreenLoc
	jmp		Monitor

HelpMsg:
	db	"? = Display help",CR,LF
	db	"CLS = clear screen",CR,LF
	db	"S = Boot from SD Card",CR,LF
	db	": = Edit memory bytes",CR,LF
	db	"L = Load S19 file",CR,LF
	db  "DR = Dump registers",CR,LF
	db	"D = Dump memory",CR,LF
	db	"F = Fill memory",CR,LF
	db	"B = start tiny basic",CR,LF
	db	"b = start EhBasic 6502",CR,LF
	db	"J = Jump to code",CR,LF
	db	"R[n] = Set register value",CR,LF
	db	"T = get temperature",CR,LF
	db	"P = Piano",CR,LF,0

;------------------------------------------------------------------------------
; Ignore blanks in the input
; r3 = text pointer
; r1 destroyed
;------------------------------------------------------------------------------
;
ignBlanks:
ignBlanks1:
	lda		(y)
	iny
	jsr		ScreenToAscii
	cmp		#' '
	beq		ignBlanks1
	dey
	rts

;------------------------------------------------------------------------------
; Edit memory byte(s).
;------------------------------------------------------------------------------
;
EditMem:
	jsr		ignBlanks
	jsr		GetHexNumber
	or		r5,r1,r0
	ld		r4,#3
edtmem1:
	jsr		ignBlanks
	jsr		GetHexNumber
	sta		(r5)
	add		r5,r5,#1
	dec		r4
	bne		edtmem1
	jmp		Monitor

;------------------------------------------------------------------------------
; Execute code at the specified address.
;------------------------------------------------------------------------------
;
ExecuteCode:
	jsr		ignBlanks
	jsr		GetHexNumber
	st		r1,JMPTMP
	lda		#xcret			; push return address so we can do an indirect jump
	pha
	ld		r1,R1Save
	ld		r2,R2Save
	ld		r3,R3Save
	ld		r4,R4Save
	ld		r5,R5Save
	ld		r6,R6Save
	ld		r7,R7Save
	ld		r8,R8Save
	ld		r9,R9Save
	ld		r10,R10Save
	ld		r11,R11Save
	ld		r12,R12Save
	ld		r13,R13Save
	ld		r14,R14Save
	ld		r15,R15Save
	jmp		(JMPTMP)
xcret:
	php
	st		r1,R1Save
	st		r2,R2Save
	st		r3,R3Save
	st		r4,R4Save
	st		r5,R5Save
	st		r6,R6Save
	st		r7,R7Save
	st		r8,R8Save
	st		r9,R9Save
	st		r10,R10Save
	st		r11,R11Save
	st		r12,R12Save
	st		r13,R13Save
	st		r14,R14Save
	st		r15,R15Save
	tsr		sp,r1
	st		r1,SPSave
	tsr		sp8,r1
	st		r1,SP8Save
	pla
	sta		SRSave
	jmp     Monitor

LoadSector:
	jsr		ignBlanks
	jsr		GetHexNumber
	ld		r2,#0x3800
	jsr		spi_read_sector
	jmp		Monitor

;------------------------------------------------------------------------------
; Dump the register set.
;------------------------------------------------------------------------------
DumpReg:
	ldy		#0
DumpReg1:
	jsr		CRLF
	lda		#':'
	jsr		DisplayChar
	lda		#'R'
	jsr		DisplayChar
	ldx		#0
	tya
	jsr		PRTNUM
	lda		#' '
	jsr		DisplayChar
	lda		R1Save,y
	jsr		DisplayWord
	iny
	cpy		#15
	bne		DumpReg1
	jsr		CRLF
	lda		#':'
	jsr		DisplayChar
	lda		#'S'
	jsr		DisplayChar
	lda		#'P'
	jsr		DisplayChar
	lda		#' '
	jsr		DisplayChar
	lda		SPSave
	jsr		DisplayWord
	jsr		CRLF
	rts
		
;------------------------------------------------------------------------------
; Do a memory dump of the requested location.
;------------------------------------------------------------------------------
;
DumpMem:
	jsr		ignBlanks
	jsr		GetHexNumber	; get start address of dump
	tax
	jsr		ignBlanks
	jsr		GetHexNumber	; get number of words to dump
	lsr						; 1/4 as many dump rows
	lsr
	bne		Dumpmem2
	lda		#1				; dump at least one row
Dumpmem2:
	jsr		CRLF
	bra		DumpmemW
DumpmemW:
	jsr		DisplayMemW
	dea
	bne		DumpmemW
	jmp		Monitor


	bra		Monitor

FillMem:
	jsr		ignBlanks
	jsr		GetHexNumber	; get start address of dump
	tax
	jsr		ignBlanks
	jsr		GetHexNumber	; get number of bytes to fill
	or		r5,r1,r0
	jsr		ignBlanks
	jsr		GetHexNumber	; get the fill byte
FillmemW:
	sta		(x)
	inx
	dec		r5
	bne		FillmemW
	jmp		Monitor

;------------------------------------------------------------------------------
; Get a hexidecimal number. Maximum of eight digits.
; R3 = text pointer (updated)
; R1 = hex number
;------------------------------------------------------------------------------
;
GetHexNumber:
	phx
	push	r4
	ldx		#0
	ld		r4,#8
gthxn2:
	lda		(y)
	iny
	jsr		ScreenToAscii
	jsr		AsciiToHexNybble
	cmp		#-1
	beq		gthxn1
	asl		r2,r2,#4
	and		#$0f
	or		r2,r2,r1
	dec		r4
	bne		gthxn2
gthxn1:
	txa
	pop		r4
	plx
	rts

;------------------------------------------------------------------------------
; Convert ASCII character in the range '0' to '9', 'a' to 'f' or 'A' to 'F'
; to a hex nybble.
;------------------------------------------------------------------------------
;
AsciiToHexNybble:
	cmp		#'0'
	bcc		gthx3
	cmp		#'9'+1
	bcs		gthx5
	sub		#'0'
	rts
gthx5:
	cmp		#'A'
	bcc		gthx3
	cmp		#'F'+1
	bcs		gthx6
	sub		#'A'
	add		#10
	rts
gthx6:
	cmp		#'a'
	bcc		gthx3
	cmp		#'z'+1
	bcs		gthx3
	sub		#'a'
	add		#10
	rts
gthx3:
	lda		#-1		; not a hex number
	rts

;------------------------------------------------------------------------------
;------------------------------------------------------------------------------
ClearBmpScreen:
	pha
	phx
	phy
	ldx		#(1364*768)>>2		; x = # words to clear
	lda		#0x29292929			; acc = color for four pixels
	ldy		#BITMAPSCR			; y = screen address
cbsj4
	sta		(y)					; store pixel data
	iny							; advance screen address
	dex							; decrement pixel count and loop back
	bne		cbsj4
	ply
	plx
	pla
	rts

;==============================================================================
;==============================================================================
;
; Initialize the SD card
; Returns
; acc = 0 if successful, 1 otherwise
;
spi_init
	lda		#SPI_INIT_SD
	sta		SPIMASTER+SPI_TRANS_TYPE_REG
	lda		#SPI_TRANS_START
	sta		SPIMASTER+SPI_TRANS_CTRL_REG
	nop
spi_init1
	lda		SPIMASTER+SPI_TRANS_STATUS_REG
	nop
	nop
	cmp		#SPI_TRANS_BUSY
	beq		spi_init1
	lda		SPIMASTER+SPI_TRANS_ERROR_REG
	and		#3
	cmp		#SPI_INIT_NO_ERROR
	bne		spi_error
	lda		#spi_init_ok_msg
	jsr		DisplayStringB
	lda		#0
	bra		spi_init_exit
spi_error
	jsr		DisplayByte
	lda		#spi_init_error_msg
	jsr		DisplayStringB
	lda		SPIMASTER+SPI_RESP_BYTE1
	jsr		DisplayByte
	lda		SPIMASTER+SPI_RESP_BYTE2
	jsr		DisplayByte
	lda		SPIMASTER+SPI_RESP_BYTE3
	jsr		DisplayByte
	lda		SPIMASTER+SPI_RESP_BYTE4
	jsr		DisplayByte
	lda		#1
spi_init_exit
	rts



; SPI read sector
;
; r1= sector number to read
; r2= address to place read data
; Returns:
; r1 = 0 if successful
;
spi_read_sector:
	phx
	phy
	push	r4
	
	sta		SPIMASTER+SPI_SD_SECT_7_0_REG
	lsr		r1,r1,#8
	sta		SPIMASTER+SPI_SD_SECT_15_8_REG
	lsr		r1,r1,#8
	sta		SPIMASTER+SPI_SD_SECT_23_16_REG
	lsr		r1,r1,#8
	sta		SPIMASTER+SPI_SD_SECT_31_24_REG

	ld		r4,#20	; retry count

spi_read_retry:
	; Force the reciever fifo to be empty, in case a prior error leaves it
	; in an unknown state.
	lda		#1
	sta		SPIMASTER+SPI_RX_FIFO_CTRL_REG

	lda		#RW_READ_SD_BLOCK
	sta		SPIMASTER+SPI_TRANS_TYPE_REG
	lda		#SPI_TRANS_START
	sta		SPIMASTER+SPI_TRANS_CTRL_REG
	nop
spi_read_sect1:
	lda		SPIMASTER+SPI_TRANS_STATUS_REG
	nop					; just a delay between consecutive status reg reads
	nop
	cmp		#SPI_TRANS_BUSY
	beq		spi_read_sect1
	lda		SPIMASTER+SPI_TRANS_ERROR_REG
	lsr
	lsr
	and		#3
	cmp		#SPI_READ_NO_ERROR
	bne		spi_read_error
	ldy		#512		; read 512 bytes from fifo
spi_read_sect2:
	lda		SPIMASTER+SPI_RX_FIFO_DATA_REG
	sb		r1,0,x
	inx
	dey
	bne		spi_read_sect2
	lda		#0
	bra		spi_read_ret
spi_read_error:
	dec		r4
	bne		spi_read_retry
	jsr		DisplayByte
	lda		#spi_read_error_msg
	jsr		DisplayStringB
	lda		#1
spi_read_ret:
	pop		r4
	ply
	plx
	rts

; SPI write sector
;
; r1= sector number to write
; r2= address to get data from
; Returns:
; r1 = 0 if successful
;
spi_write_sector:
	phx
	phy
	pha
	; Force the transmitter fifo to be empty, in case a prior error leaves it
	; in an unknown state.
	lda		#1
	sta		SPIMASTER+SPI_TX_FIFO_CTRL_REG
	nop			; give I/O time to respond
	nop

	; now fill up the transmitter fifo
	ldy		#512
spi_write_sect1:
	lb		r1,0,x
	sta		SPIMASTER+SPI_TX_FIFO_DATA_REG
	nop			; give the I/O time to respond
	nop
	inx
	dey
	bne		spi_write_sect1

	; set the sector number in the spi master address registers
	pla
	sta		SPIMASTER+SPI_SD_SECT_7_0_REG
	lsr		r1,r1,#8
	sta		SPIMASTER+SPI_SD_SECT_15_8_REG
	lsr		r1,r1,#8
	sta		SPIMASTER+SPI_SD_SECT_23_16_REG
	lsr		r1,r1,#8
	sta		SPIMASTER+SPI_SD_SECT_31_24_REG

	; issue the write command
	lda		#RW_WRITE_SD_BLOCK
	sta		SPIMASTER+SPI_TRANS_TYPE_REG
	lda		#SPI_TRANS_START
	sta		SPIMASTER+SPI_TRANS_CTRL_REG
	nop
spi_write_sect2:
	lda		SPIMASTER+SPI_TRANS_STATUS_REG
	nop							; just a delay between consecutive status reg reads
	nop
	cmp		#SPI_TRANS_BUSY
	beq		spi_write_sect2
	lda		SPIMASTER+SPI_TRANS_ERROR_REG
	lsr		r1,r1,#4
	and		#3
	cmp		#SPI_WRITE_NO_ERROR
	bne		spi_write_error
	lda		#0
	bra		spi_write_ret
spi_write_error:
	jsr		DisplayByte
	lda		#spi_write_error_msg
	jsr		DisplayStringB
	lda		#1

spi_write_ret:
	ply
	plx
	rts

; read the partition table to find out where the boot sector is.
;
spi_read_part:
	phx
	stz		startSector						; default starting sector
	lda		#0								; r1 = sector number (#0)
	ldx		#SECTOR_BUF<<2					; r2 = target address (word to byte address)
	jsr		spi_read_sector
	cmp		#0
	bne		spi_rp1
	lb		r1,BYTE_SECTOR_BUF+$1C9
	asl		r1,r1,#8
	orb		r1,r1,BYTE_SECTOR_BUF+$1C8
	asl		r1,r1,#8
	orb		r1,r1,BYTE_SECTOR_BUF+$1C7
	asl		r1,r1,#8
	orb		r1,r1,BYTE_SECTOR_BUF+$1C6
	sta		startSector						; r1 = 0, for okay status
	plx
	lda		#0
	rts
spi_rp1:
	plx
	lda		#1
	rts

; Read the boot sector from the disk.
; Make sure it's the boot sector by looking for the signature bytes 'EB' and '55AA'.
;
spi_read_boot:
	phx
	phy
	push	r5
	lda		startSector					; r1 = sector number
	ldx		#BYTE_SECTOR_BUF			; r2 = target address
	jsr		spi_read_sector
	lb		r1,BYTE_SECTOR_BUF
	cmp		#$EB
	beq		spi_read_boot2
spi_read_boot3:
	lda		#1							; r1 = 1 for error
	bra		spi_read_boot4
spi_read_boot2:
	lda		#msgFoundEB
	jsr		DisplayStringB
	lb		r1,BYTE_SECTOR_BUF+$1FE		; check for 0x55AA signature
	cmp		#$55
	bne		spi_read_boot3
	lb		r1,BYTE_SECTOR_BUF+$1FF		; check for 0x55AA signature
	cmp		#$AA
	bne		spi_read_boot3
	lda		#0						; r1 = 0, for okay status
spi_read_boot4:
	pop		r5
	ply
	plx
	rts

msgFoundEB:
	db	"Found EB code.",CR,LF,0


; Load the root directory from disk
; r2 = where to place root directory in memory
;
loadBootFile:
	lb		r1,BYTE_SECTOR_BUF+$17			; sectors per FAT
	asl		r1,r1,#8
	orb		r1,r1,BYTE_SECTOR_BUF+$16
	bne		loadBootFile7
	lb		r1,BYTE_SECTOR_BUF+$27			; sectors per FAT, FAT32
	asl		r1,r1,#8
	orb		r1,r1,BYTE_SECTOR_BUF+$26
	asl		r1,r1,#8
	orb		r1,r1,BYTE_SECTOR_BUF+$25
	asl		r1,r1,#8
	orb		r1,r1,BYTE_SECTOR_BUF+$24
loadBootFile7:
	lb		r4,BYTE_SECTOR_BUF+$10			; number of FATs
	mul		r3,r1,r4						; offset
	lb		r1,BYTE_SECTOR_BUF+$F			; r1 = # reserved sectors before FAT
	asl		r1,r1,#8
	orb		r1,r1,BYTE_SECTOR_BUF+$E
	add		r3,r3,r1						; r3 = root directory sector number
	ld		r6,startSector
	add		r5,r3,r6						; r5 = root directory sector number
	lb		r1,BYTE_SECTOR_BUF+$D			; sectors per cluster
	add		r3,r1,r5						; r3 = first cluster after first cluster of directory
	bra		loadBootFile6

loadBootFile6:
	; For now we cheat and just go directly to sector 512.
	bra		loadBootFileTmp

loadBootFileTmp:
	; We load the number of sectors per cluster, then load a single cluster of the file.
	; This is 16kib
	ld		r5,r3							; r5 = start sector of data area	
	ld		r2,#PROG_LOAD_AREA				; where to place file in memory
	lb		r3,BYTE_SECTOR_BUF+$D			; sectors per cluster
loadBootFile1:
	ld		r1,r5							; r1=sector to read
	jsr		spi_read_sector
	inc		r5						; r5 = next sector
	add		r2,r2,#512
	dec		r3
	bne		loadBootFile1
	lda		(PROG_LOAD_AREA>>2)+$80	; make sure it's bootable
	cmp		#$544F4F42
	bne		loadBootFile2
	lda		#msgJumpingToBoot
	jsr		DisplayStringB
	lda		(PROG_LOAD_AREA>>2)+$81
	jsr		(r1)
	jmp		Monitor
loadBootFile2:
	lda		#msgNotBootable
	jsr		DisplayStringB
	ldx		#PROG_LOAD_AREA>>2
	jsr		DisplayMemW
	jsr		DisplayMemW
	jsr		DisplayMemW
	jsr		DisplayMemW
	jmp		Monitor

msgJumpingToBoot:
	db	"Jumping to boot",0	
msgNotBootable:
	db	"SD card not bootable.",0
spi_init_ok_msg:
	db "SD card initialized okay.",0
spi_init_error_msg:
	db	": error occurred initializing the SD card.",0
spi_boot_error_msg:
	db	"SD card boot error",0
spi_read_error_msg:
	db	"SD card read error",0
spi_write_error_msg:
	db	"SD card write error",0

;------------------------------------------------------------------------------
; 100 Hz interrupt
; - takes care of "flashing" the cursor
;------------------------------------------------------------------------------
;
p100Hz:
	inc		IRQFlag			; support tiny basic's IRQ rout
	inc		TEXTSCR+83
	stz		0xFFDCFFFC		; clear interrupt
	rti

;------------------------------------------------------------------------------
; 1000 Hz interrupt
; This IRQ must be fast.
; Increments the millisecond counter, and switches to the next context
;------------------------------------------------------------------------------
;
p1000Hz:
	stz		0xFFDCFFFD				; acknowledge interrupt
	inc		Milliseconds			; increment milliseconds count
	rti

slp_rout:
	rti
brk_rout:
	rti
nmirout
	rti
message "1298"
include "TinyBasic65002.asm"
message "1640"
	org $0FFFFFFF4		; NMI vector
	dw	nmirout

	org	$0FFFFFFF8		; reset vector, native mode
	dw	start
	
	end
	