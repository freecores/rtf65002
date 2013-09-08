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
RW_READ_SD_BLOCK	EQU		0x02
RW_WRITE_SD_BLOCK	EQU		0x03

BITMAPSCR	EQU		0x00200000

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

CharColor	EQU		0x210
ScreenColor	EQU		0x211
CursorRow	EQU		0x212
CursorCol	EQU		0x213

	cpu		rtf65002
	code
	org		$FFFFC000
start
	sei						; disable interrupts
	cld						; disable decimal mode
	ldx		#$1000			; setup stack pointer
	txs
	lda		#$CE			; CE =blue on blue FB = grey on grey
	sta		ScreenColor
	sta		CharColor
	jsr		ClearScreen
	stz		CursorRow
	stz		CursorCol
	lda		#msgStart>>2	; convert to data address
	jsr		DisplayStringB

	stp
	bra		start
	
	align	4
msgStart
	db		"RTF65002 system starting.",$0d,$0a,00

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
	cmp		#'z'
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
	cmp		#26
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
	lda		(x)				; move string char into acc
	inx						; increment pointer
	pha
	and		#$FF
	cmp		#0				; is it end of string ?
	beq		dsretB
	jsr		DisplayChar		; display character
	pla
	m_lsr8
	pha
	and		#$FF
	cmp		#0
	beq		dsretB
	jsr		DisplayChar
	pla
	m_lsr8
	pha
	and		#$FF
	cmp		#0
	beq		dsretB
	jsr		DisplayChar
	pla
	m_lsr8
	pha
	and		#$FF
	cmp		#0
	beq		dsretB
	jsr		DisplayChar
	pla
	bra		dspj1B			; go back for next character
dsretB:
	pla
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
; Display nybble in r1
;------------------------------------------------------------------------------
;
DisplayNybble:
	pha
	and		#$0F
	add		#'0'
	cmp		#'9'
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
	lsr
	lsr
	lsr
	lsr
	jsr		DisplayNybble
	pla
	jmp		DisplayNybble	; tail rts 

;------------------------------------------------------------------------------
;------------------------------------------------------------------------------
ClearBmpScreen:
	pha
	phx
	phy
	ldx		#(1364*768)>>2		; x = # words to clear
	lda		#0x29292929			; acc = color for four pixels
	ldy		#BITMAPSCR			; y = screen address
csj4
	sta		(y)					; store pixel data
	iny							; advance screen address
	dex							; decrement pixel count and loop back
	bne		csj4
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
	lda		#spi_init_ok_msg>>2
	jsr		DisplayStringB
	lda		#0
	bra		spi_init_exit
spi_error
	jsr		DisplayByte
	lda		#spi_init_error_msg>>2
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
	m_lsr8
	sta		SPIMASTER+SPI_SD_SECT_15_8_REG
	m_lsr8
	sta		SPIMASTER+SPI_SD_SECT_23_16_REG
	m_lsr8
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
	sta		(x)
	inx
	dey
	bne		spi_read_sect2
	lda		#0
	bra		spi_read_ret
spi_read_error:
	sub		r4,r4,#1
	bne		spi_read_retry
	jsr		DisplayByte
	lda		#spi_read_error_msg>>2
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
	lda		(x)
	sta		SPIMASTER+SPI_TX_FIFO_DATA_REG
	nop			; give the I/O time to respond
	nop
	inx
	dey
	bne		spi_write_sect1

	; set the sector number in the spi master address registers
	pla
	sta		SPIMASTER+SPI_SD_SECT_7_0_REG
	m_lsr8
	sta		SPIMASTER+SPI_SD_SECT_15_8_REG
	m_lsr8
	sta		SPIMASTER+SPI_SD_SECT_23_16_REG
	m_lsr8
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
	lsr
	lsr
	lsr
	lsr
	and		#3
	cmp		#SPI_WRITE_NO_ERROR
	bne		spi_write_error
	lda		#0
	bra		spi_write_ret
spi_write_error:
	jsr		DisplayByte
	lda		#spi_write_error_msg>>2
	jsr		DisplayStringB
	lda		#1

spi_write_ret:
	ply
	plx
	rts

	align	4
msgJumpingToBoot:
	db	"Jumping to boot",0	
	align	4
msgNotBootable:
	db	"SD card not bootable.",0
	align	4
spi_init_ok_msg:
	db "SD card initialized okay.",0
	align	4
spi_init_error_msg:
	db	": error occurred initializing the SD card.",0
	align	4
spi_boot_error_msg:
	db	"SD card boot error",0
	align	4
spi_read_error_msg:
	db	"SD card read error",0
	align	4
spi_write_error_msg:
	db	"SD card write error",0

nmirout
	rti

	org $0FFFFFFF4		; NMI vector
	dw	nmirout

	org	$0FFFFFFF8		; reset vector, native mode
	dw	start
	
	end
	