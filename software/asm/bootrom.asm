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

; error codes
E_Ok		=		0x00
E_Arg		=		0x01
E_BadMbx	=		0x04
E_QueFull	=		0x05
E_NoThread	=		0x06
E_NotAlloc	=		0x09
E_NoMsg		=		0x0b
E_Timeout	=		0x10
E_BadAlarm	=		0x11
E_NotOwner	=		0x12
; resource errors
E_NoMoreMbx	=		0x40
E_NoMoreMsgBlks	=	0x41
E_NoMoreAlarmBlks	=0x44
E_NoMoreTCBs	=	0x45

; task status
TS_NONE     =0
TS_TIMEOUT	=1
TS_WAITMSG	=2
TS_PREEMP	=4
TS_RUNNING	=8
TS_READY	=16
TS_WAITFOCUS	= 32


; message queuing strategy
MQS_UNLIMITED	=0	; unlimited queue size
MQS_NEWEST		=1	; buffer queue size newest messages
MQS_OLDEST		=2	; buffer queue size oldest messages


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
TASK_SELECT	EQU		0xFFDD0008
RQ_SEMA		EQU		0xFFDB0000
TO_SEMA		EQU		0xFFDB0010
SERIAL_SEMA	EQU		0xFFDB0020
KEYBD_SEMA	EQU		0xFFDB0030
IOF_LIST_SEMA	EQU	0xFFDB0040
MBX_SEMA	EQU		0xFFDB0050

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

UART		EQU		0xFFDC0A00
UART_LS		EQU		0xFFDC0A01
UART_MS		EQU		0xFFDC0A02
UART_IS		EQU		0xFFDC0A03
UART_IE		EQU		0xFFDC0A04
UART_MC		EQU		0xFFDC0A06
UART_CM1	EQU		0xFFDC0A09
UART_CM2	EQU		0xFFDC0A0A
UART_CM3	EQU		0xFFDC0A0B
txempty		EQU		0x40
rxfull		EQU		0x01

CONFIGREC	EQU		0xFFDCFFF0
CR_CLOCK	EQU		0xFFDCFFF4
GACCEL		EQU		0xFFDAE000

ETHMAC		EQU		0xFFDC2000
ETH_MODER		EQU		0x00
ETH_INT_SOURCE	EQU		0x01
ETH_INT_MASK	EQU		0x02
ETH_IPGT		EQU		0x03
ETH_IPGR1		EQU		0x04
ETH_IPGR2		EQU		0x05
ETH_PACKETLEN	EQU		0x06
ETH_COLLCONF	EQU		0x07
ETH_TX_BD_NUM	EQU		0x08
ETH_CTRLMODER	EQU		0x09
ETH_MIIMODER	EQU		0x0A
ETH_MIICOMMAND	EQU		0x0B
ETH_MIIADDRESS	EQU		0x0C
ETH_MIITX_DATA	EQU		0x0D
ETH_MIIRX_DATA	EQU		0x0E
ETH_MIISTATUS	EQU		0x0F
ETH_MAC_ADDR0	EQU		0x10
ETH_MAC_ADDR1	EQU		0x11
ETH_HASH0_ADDR	EQU		0x12
ETH_HASH1_ADDR	EQU		0x13
ETH_TXCTRL		EQU		0x14

SPRITEREGS	EQU		0xFFDAD000
SPRRAM		EQU		0xFFD80000

THRD_AREA	EQU		0x04000000	; threading area 0x04000000-0x40FFFFF
BITMAPSCR	EQU		0x04100000
SECTOR_BUF	EQU		0x05FBEC00
BIOS_STACKS	EQU		0x05FC0000	; room for 256 1kW stacks
BIOS_SCREENS	EQU	0x05C00000	; 0x05C00000 to 0x05DFFFFF

BYTE_SECTOR_BUF	EQU	SECTOR_BUF<<2
PROG_LOAD_AREA	EQU		0x4180000<<2
INPUT_FOCUS		EQU		0x05FBE000
OUTPUT_FOCUS	EQU		0x05FBE001

eth_rx_buffer	EQU		0x5F80000
eth_tx_buffer	EQU		0x5F84000

; Mailboxes, room for 2048
MBX_LINK	EQU		0x05F90000
MBX_TQ_HEAD	EQU		0x05F90800
MBX_TQ_TAIL	EQU		0x05F91000
MBX_MQ_HEAD	EQU		0x05F91800
MBX_MQ_TAIL	EQU		0x05F92000
MBX_TQ_COUNT	EQU	0x05F92800
MBX_MQ_SIZE	EQU		0x05F93000
MBX_MQ_COUNT	EQU	0x05F93800
MBX_MQ_MISSED	EQU	0x05F94000
MBX_OWNER		EQU	0x05F94800
MBX_MQ_STRATEGY	EQU	0x05F95000
MBX_RESV		EQU	0x05F95800

; Messages, room for 8kW (8,192) messages
MSG_LINK	EQU		0x05FA0000
MSG_D1		EQU		0x05FA2000
MSG_D2		EQU		0x05FA4000
MSG_TYPE	EQU		0x05FA6000

; Task control blocks, room for 256 tasks
TCB_NxtRdy		EQU		0x05FBE100	; next task on ready / timeout list
TCB_PrvRdy		EQU		0x05FBE200	; previous task on ready / timeout list
TCB_NxtTCB		EQU		0x05FBE300
TCB_Timeout		EQU		0x05FBE400
TCB_Priority	EQU		0x05FBE500
TCB_MSGPTR_D1	EQU		0x05FBE600
TCB_MSGPTR_D2	EQU		0x05FBE700
TCB_hJCB		EQU		0x05FBE800
TCB_Status		EQU		0x05FBE900
TCB_SP8Save		EQU		0x500		; TCB_SP8Save area $500 to $5FF
TCB_SPSave		EQU		0x600		; TCB_SPSave area $600 to $6FF
TCB_CursorRow	EQU		0x05FBD100
TCB_CursorCol	EQU		0x05FBD200
TCB_hWaitMbx	EQU		0x05FBD300	; handle of mailbox task is waiting at
TCB_mbq_next	EQU		0x05FBD400	; mailbox queue next
TCB_mbq_prev	EQU		0x05FBD500	; mailbox queue previous

KeybdHead	EQU		0x05FBEA00
KeybdTail	EQU		0x05FBEB00
KeybdEcho	EQU		0x05FBEC00
KeybdBad	EQU		0x05FBED00
KeybdAck	EQU		0x05FBEE00
KeybdLocks	EQU		0x05FBEF00
KeybdBuffer	EQU		0x05FBF000	; buffer is 16 chars

IOFocusList	EQU		0x05FBD000


; BIOS vars at the top of the 8kB scratch memory
;
NmiBase		EQU		0xDC
IrqBase		EQU		0xDF




; TinyBasic AREA = 0x700 to 0x77F

HeadRdy0	EQU		0x780
HeadRdy1	EQU		HeadRdy0+1
HeadRdy2	EQU		HeadRdy1+1
HeadRdy3	EQU		HeadRdy2+1
HeadRdy4	EQU		HeadRdy3+1
TailRdy0	EQU		HeadRdy4+1
TailRdy1	EQU		TailRdy0+1
TailRdy2	EQU		TailRdy1+1
TailRdy3	EQU		TailRdy2+1
TailRdy4	EQU		TailRdy3+1
FreeTCB		EQU		TailRdy4+1
TimeoutList	EQU		FreeTCB+1
RunningTCB		EQU		TimeoutList+1
FreeMbx		EQU		RunningTCB + 1
nMailbox	EQU		FreeMbx + 1
FreeMsg		EQU		nMailbox + 1
nMsgBlk		EQU		FreeMsg + 1

IrqSource	EQU		0x798

JMPTMP		EQU		0x7A0
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

CharColor	EQU		0x7C0
ScreenColor	EQU		0x7C1
CursorRow	EQU		0x7C2
CursorCol	EQU		0x7C3
CursorFlash	EQU		0x7C4
Milliseconds	EQU		0x7C5
IRQFlag		EQU		0x7C6
RdyQueTick	EQU		0x7C7
eth_unique_id	EQU		0x7C8
LineColor	EQU		0x7C9

Uart_rxfifo		EQU		0x05FBC000
Uart_rxhead		EQU		0x7D0
Uart_rxtail		EQU		0x7D1
Uart_ms			EQU		0x7D2
Uart_rxrts		EQU		0x7D3
Uart_rxdtr		EQU		0x7D4
Uart_rxxon		EQU		0x7D5
Uart_rxflow		EQU		0x7D6
Uart_fon		EQU		0x7D7
Uart_foff		EQU		0x7D8
Uart_txrts		EQU		0x7D9
Uart_txdtr		EQU		0x7DA
Uart_txxon		EQU		0x7DB
Uart_txxonoff	EQU		0x7DC

startSector	EQU		0x7F0


	cpu		rtf65002
	code

message "jump table"
	; jump table of popular BIOS routines
	org		$FFFFC000
	dw	DisplayChar
	dw	KeybdCheckForKeyDirect
	dw	KeybdGetCharDirect
	dw	KeybdGetChar
	dw	KeybdCheckForKey
	dw	RequestIOFocus
	dw	ReleaseIOFocus
	dw	ClearScreen
	dw	HomeCursor
	dw	ExitTask
	dw	SetKeyboardEcho

	org		$FFFFC200		; leave room for 128 vectors
message "cold start point"
KeybdRST
start
	sei						; disable interrupts
	cld						; disable decimal mode
	ldx		#BIOS_STACKS+0x03FF	; setup stack pointer top of memory
	txs
	trs		r0,dp			; set direct page register
	trs		r0,dp8			; and 8 bit mode direct page
	trs		r0,abs8			; and 8 bit mode absolute address offset

	; setup interrupt vectors
	ldx		#$05FB0001		; interrupt vector table from $5FB0000 to $5FB01FF
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
	lda		#SerialIRQ
	sta		448+8,x
	lda		#bus_err_rout
	sta		508,x
	sta		509,x

	emm
	cpu		W65C02
	ldx		#$FF			; set 8 bit stack pointer
	txs
	nat
	cpu		rtf65002
	
	ldx		#0
	stz		IrqBase			; support for EhBASIC's interrupt mechanism
	stz		NmiBase
	; Initialize the BIOS task
	lda		#TS_RUNNING|TS_READY
	sta		TCB_Status
	stz		TCB_Priority	; set task#0 priority
	lda		#-1
	sta		TCB_NxtRdy		; set task#0 next and previous fields
	sta		TCB_PrvRdy
	stz		TCB_Timeout
	stz		RunningTCB		; the BIOS task is the running task

	sta		TimeoutList		; no entries in timeout list
	stz		HeadRdy0		; task zero (the BIOS task) is always present
	sta		HeadRdy1
	sta		HeadRdy2
	sta		HeadRdy3
	sta		HeadRdy4
	stz		TailRdy0
	sta		TailRdy1
	sta		TailRdy2
	sta		TailRdy3
	sta		TailRdy4

	; Initialize IO Focus List
	;
	ldx		#0
st5:
	stz		IOFocusList,x
	inx
	cpx		#8
	bne		st5

	; Initialize free message list
	lda		#8192
	sta		nMsgBlk
	stz		FreeMsg
	ldx		#0
	lda		#1
st4:
	sta		MSG_LINK,x
	ina
	inx
	cpx		#8192
	bne		st4
	lda		#-1
	sta		MBX_LINK+8191
	
	; Initialize free mailbox list
	lda		#2048
	sta		nMailbox
	
	stz		FreeMbx
	ldx		#0
	lda		#1
st3:
	sta		MBX_LINK,x
	ina
	inx
	cpx		#2048
	bne		st3
	lda		#-1
	sta		MBX_LINK+2047

	; Initialize the FreeTCB list
	lda		#1				; the next available TCB
	sta		FreeTCB
	ldx		#1
	lda		#2
st2:
	sta		TCB_NxtTCB,x
	ina
	inx
	cpx		#256
	bne		st2
	lda		#-1
	sta		TCB_NxtTCB+255

	stz		INPUT_FOCUS
	stz		OUTPUT_FOCUS
	lda		#1
	sta		MBX_SEMA
	sta		IOF_LIST_SEMA
	sta		RQ_SEMA			; set ready queue semaphore
	sta		TO_SEMA			; set timeout list semaphore
	jsr		RequestIOFocus		; Get the IO focus for the BIOS (must be after semaphore is initialized)
	lda		#$CE			; CE =blue on blue FB = grey on grey
	sta		ScreenColor
	sta		CharColor
	sta		CursorFlash
	jsr		ClearScreen
	jsr		ClearBmpScreen
	lda		#$3FFF			; turn on sprites
	sta		SPRITEREGS+120
	jsr		RandomizeSprram
	jsr		HomeCursor
	lda		#msgStart
	jsr		DisplayStringB
	jsr		KeybdInit
	lda		#1
	sta		KeybdEcho
	; 19200 * 16
	;-------------
	; 25MHz / 2^32
	lda		#$03254E6E		; constant for 19,200 baud at 25MHz
;	jsr		SerialInit
	lda		#4
	ldx		#0
	ldy		#IdleTask
	jsr		StartTask
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
message "PICInit"
PICInit:
	; enable: raster irq,
	lda		#$810F			; enable nmi,kbd_rst,and kbd_irq
	; A10F enable serial IRQ
	sta		PIC_IE
PICret:
	rts

;------------------------------------------------------------------------------
;------------------------------------------------------------------------------
message "DumpTaskList"
DumpTaskList:
	pha
	phx
	phy
	push	r4
	lda		#msgTaskList
	jsr		DisplayStringB
	ldy		#0
	php
	sei
dtl2:
	lda		HeadRdy0,y
	ld		r4,r1
	bmi		dtl1
dtl3:
	ldx		#3
	tya
	jsr		PRTNUM
	lda		#' '
	jsr		DisplayChar
	ld		r1,r4
	ldx		#3
	jsr		PRTNUM
	lda		#' '
	jsr		DisplayChar
	jsr		DisplayChar
	jsr		DisplayChar
	ld		r1,r4
	lda		TCB_Status,r1
	jsr		DisplayByte
	lda		#' '
	jsr		DisplayChar
	ldx		#3
	lda		TCB_PrvRdy,r4
	jsr		PRTNUM
	lda		#' '
	jsr		DisplayChar
	ldx		#3
	lda		TCB_NxtRdy,r4
	jsr		PRTNUM
	lda		#' '
	jsr		DisplayChar
	lda		TCB_Timeout,r4
	jsr		DisplayWord
	jsr		CRLF
	ld		r4,TCB_NxtRdy,r4
	bpl		dtl3
dtl1:
	iny
	cpy		#5
	bne		dtl2
	plp
	pop		r4
	ply
	plx
	pla
	rts

msgTaskList:
	db	CR,LF,"Pri Task Stat Prv Nxt Timeout",CR,LF,0

;------------------------------------------------------------------------------
; IdleTask is a low priority task that is always running. It runs when there
; is nothing else to run.
;------------------------------------------------------------------------------
IdleTask:
	inc		TEXTSCR+167		; increment IDLE active flag
	cli						; enable interrupts
	wai						; wait for one to happen
	bra		IdleTask

;------------------------------------------------------------------------------
; r1 = task priority
; r2 = start flags
; r3 = start address
;------------------------------------------------------------------------------
message "StartTask"
StartTask:
	pha
	phx
	phy
	push	r4
	push	r5
	push	r6
	push	r7
	push	r8
	tsr		sp,r4				; save off current stack pointer
	ld		r6,r1				; r6 = task priority
	ld		r8,r2
	
	; get a free TCB
	;
	sei
	lda		FreeTCB				; get free tcb list pointer
	bmi		stask1
	tax
	lda		TCB_NxtTCB,x
	sta		FreeTCB				; update the FreeTCB list pointer
	cli
	txa
	
	; setup the stack for the task
	ld		r7,r2
	asl		r2,r2,#10			; 1kW stack per task
	add		r2,r2,#BIOS_STACKS+0x3ff	; add in stack base
	txs
	ldx		#$FF
	stx		TCB_SP8Save,r7
	st		r6,TCB_Priority,r7
	stz		TCB_Status,r7
	stz		TCB_Timeout,r7

	; setup the initial stack image for the task
	; Cause a return to the ExitTask routine when the task does a 
	; final rts.
	; fake an IRQ call by stacking the return address and processor
	; flags on the stack
	ldx		#ExitTask			; save the address of the task exit routine
	phx
	phy							; save start address on stack
	push	r8					; save processor status reg on stack
	
	; now fake pushing the register set onto the stack. Registers start up
	; in an undefined state.
	sub		sp,#15				; 15 registers
	tsx
	stx		TCB_SPSave,r7

	; now restore the current stack pointer
	trs		r4,sp

	; Insert the task into the ready list
	jsr		AddTaskToReadyList
stask2:
	pop		r8
	pop		r7
	pop		r6
	pop		r5
	pop		r4
	ply
	plx
	pla
	rts
stask1:
	cli
	lda		#msgNoTCBs
	jsr		DisplayStringB
	bra		stask2

msgNoTCBs:
	db		"No more task control blocks available.",CR,LF,0

;------------------------------------------------------------------------------
; This routine is called when the task exits with an rts instruction. OR
; it may be invoked with a JMP ExitTask.
;------------------------------------------------------------------------------
message "ExitTask"
ExitTask:
	sei
	; release any aquired resources
	; - mailboxes
	; - messages
	lda		RunningTCB
	jsr		RemoveTaskFromReadyList
	stz		TCB_Status,r1				; set task status to TS_NONE
	ldx		FreeTCB
	stx		TCB_NxtTCB,r1
	sta		FreeTCB
	jmp		SelectTaskToRun

;------------------------------------------------------------------------------
; AddTaskToReadyList
; This subroutine is called from the timer ISR so it must be relatively
; fast.
; Parameters:
; r1 = task number
;
;------------------------------------------------------------------------------
message "AddTaskToReadyList"
AddTaskToReadyList:
	phx
	phy
	php
	sei
	ldy		TCB_Priority,r1	; make sure the priority value isn't screwy.
	cpy		#5
	bpl		arl3
arl2:
	ldx		TCB_Status,r1	; set the task status to ready
	or		r2,r2,#TS_READY
	stx		TCB_Status,r1
	ldx 	TailRdy0,y		; insert the task at the list tail
	sta		TCB_NxtRdy,x
	stx		TCB_PrvRdy,r1
	sta		TailRdy0,y
	ldx		#-1
	stx		TCB_NxtRdy,r1
	ldx		HeadRdy0,y		; check if the head of the ready list needs to be updated
	bpl		arl3
	sta		HeadRdy0,y
	ldx		#-1
	stx		TCB_PrvRdy,r1	
arl3:	
	plp
	ply
	plx
	rts


;------------------------------------------------------------------------------
; RemoveTaskFromReadyList
; This subroutine removes a task from the ready list.
; This can be called from within an ISR.
;
; r1 = task number
;------------------------------------------------------------------------------
message "RemoveTaskFromReadyList"
RemoveTaskFromReadyList:
	cmp		#0				
	bmi		rfr9			; bad task number, must be >= 0
	cmp		#255			; and must be <= 255
	bpl		rfr9
	pha
	phy
	push	r4
	push	r5

	php						; save off interrupt mask state
	sei
	ld		r4,TCB_NxtRdy,r1	; Get previous and next fields.
	ld		r5,TCB_PrvRdy,r1	; if there is no previous task, then this is
	bmi		rfr1			; the head of the list. Update.
	st		r4,TCB_NxtRdy,r5
	cmp		r4,#0			; is there a next task to update ?
	bmi		rfr8
	st		r5,TCB_PrvRdy,r4
	ld		r5,#-1
	st		r5,TCB_NxtRdy,r1
	st		r5,TCB_PrvRdy,r1
	bra		rfr8

	; Update the head of the list
rfr1:
	ldy		TCB_Priority,r1
	st		r4,HeadRdy0,y
	cmp		r4,#0			; did we empty the list ?
	bmi		rfr8
	ld		r5,#-1			; flag no previous task for head of list
	st		r5,TCB_PrvRdy,r4
	st		r5,TCB_NxtRdy,r1
	st		r5,TCB_PrvRdy,r1
rfr8:
	plp
	pop		r5
	pop		r4
	ply
	pla
rfr9:
	rts
	
;------------------------------------------------------------------------------
; r1 = task
; r2 = timeout value
;------------------------------------------------------------------------------
message "AddToTimeoutList"
AddToTimeoutList:
	phx
	push	r4
	push	r5
	php
	sei

	ld		r5,#-1
	ld		r4,TimeoutList	; are there any tasks on the timeout list ?
	bmi		attl1
attl_check_next:
	sub		r2,r2,TCB_Timeout,r4	; is this timeout > next
	bmi		attl_insert_before
	ld		r5,r4
	ld		r4,TCB_NxtRdy,r4
	bpl		attl_check_next

	; Here we scanned until the end of the timeout list and didn't find a 
	; timeout of a greater value. So we add the task to the end of the list.
attl_add_at_end:
	st		r4,TCB_NxtRdy,r1	; r4 was = -1
	st		r1,TCB_NxtRdy,r5
	st		r5,TCB_PrvRdy,r1
	st		r2,TCB_Timeout,r1
	bra		attl_exit

attl_insert_before:
	cmp		r5,#-1
	beq		attl2
	st		r4,TCB_NxtRdy,r1	; next on list goes after this task
	st		r5,TCB_PrvRdy,r1	; set previous link
	st		r1,TCB_NxtRdy,r5
	st		r1,TCB_PrvRdy,r4
	bra		attl3

	; Here there is no previous entry in the timeout list
	; Add at start
attl2:
	sta		TCB_PrvRdy,r4
	st		r5,TCB_PrvRdy,r1	; r5 = -1
	st		r4,TCB_NxtRdy,r1
	sta		TimeoutList		; update the head pointer
attl3:
	add		r2,r2,TCB_Timeout,r4	; get back timeout
	stx		TCB_Timeout,r1
	ld		r5,TCB_Timeout,r4	; adjust the timeout of the next task
	sub		r5,r5,r2
	st		r5,TCB_Timeout,r4
	bra		attl_exit

	; Here there were no tasks on the timeout list, so we add at the
	; head of the list.
attl1:
	sta		TimeoutList		; set the head of the timeout list
	stx		TCB_Timeout,r1
	ldx		#-1				; flag no more entries in timeout list
	stx		TCB_NxtRdy,r1		; no next entries
	stx		TCB_PrvRdy,r1		; and no prev entries
attl_exit:
	plp
	pop		r5
	pop		r4
	plx
	rts

;------------------------------------------------------------------------------
; This subroutine is called from within the timer ISR and already has the
; timeout list locked. Any other caller must lock the timeout list first
; before calling this routine.
;
; r1 = task number
;------------------------------------------------------------------------------
message "RemoveFromTimeoutList"
RemoveFromTimeoutList:
	pha
	phx
	push	r4
	push	r5
	php
	sei

	ld		r4,TCB_PrvRdy,r1		; adjust the links of the next and previous
	bmi		rftl2
	ld		r5,TCB_NxtRdy,r1		; tasks on the list to point around the task
	st		r5,TCB_NxtRdy,r4
	bmi		rftl1
	st		r4,TCB_PrvRdy,r5
	ldx		TCB_Timeout,r1			; update the timeout of the next on list
	add		r2,r2,TCB_Timeout,r5	; with any remaining timeout in the task
	stx		TCB_Timeout,r5			; removed from the list
	
	; Here there is no next item on the list
rftl1:
	bra		rftl3

	; Here there is no previous item on the list, so update the head of
	; the list.
rftl2:
	ld		r5,TCB_NxtRdy,r1
	st		r5,TimeoutList		; store next field into list head
	bmi		rftl3
	lda		#-1					; there is no previous item to the head
	sta		TCB_PrvRdy,r5
	
	; Here there is no previous or next items in the list, so the list
	; will be empty once this task is removed from it.
rftl3:
	plp
	pop		r5
	pop		r4
	plx
	pla
	rts
;------------------------------------------------------------------------------
; Allocate a mailbox
; r1 = pointer to place to store handle
;------------------------------------------------------------------------------
message "AllocMbx"
AllocMbx:
	cmp		#0
	beq		ambx1
	phx
	phy
	push	r4
	ld		r4,r1
	php
	sei
	lda		FreeMbx			; Get mailbox off of free mailbox list
	sta		(r4)			; store off the mailbox number
	bmi		ambx2
	ldx		MBX_LINK,r1		; and update the head of the list
	stx		FreeMbx
	dec		nMailbox		; decrement number of available mailboxes
	tax
	ldy		RunningTCB			; set the mailbox owner
	lda		TCB_hJCB,y
	sta		MBX_OWNER,x
	lda		#-1				; initialize the head and tail of the queues
	sta		MBX_TQ_HEAD,x
	sta		MBX_TQ_TAIL,x
	sta		MBX_MQ_HEAD,x
	sta		MBX_MQ_TAIL,x
	stz		MBX_TQ_COUNT,x	; initialize counts to zero
	stz		MBX_MQ_COUNT,x
	stz		MBX_MQ_MISSED,x
	lda		#8				; set the max queue size
	sta		MBX_MQ_SIZE,x	; and
	lda		#MQS_NEWEST		; queueing strategy
	sta		MBX_MQ_STRATEGY,x
	plp
	pop		r4
	ply
	plx
	lda		#E_Ok
	rts
ambx1:
	lda		#E_Arg
	rts
ambx2:
	plp
	pop		r4
	ply
	plx
	lda		#E_NoMoreMbx
	rts

;------------------------------------------------------------------------------
; r1 = message
; r2 = mailbox
;------------------------------------------------------------------------------
message "QueueMsgAtMbx"
QueueMsgAtMbx:
	pha
	phx
	phy
	php
	sei
	ldy		MBX_MQ_TAIL,x
	bmi		qmam1
	sta		MBX_LINK,y
	bra		qmam2
qmam1:
	sta		MBX_MQ_HEAD,x
qmam2:
	sta		MBX_MQ_TAIL,x
	inc		MBX_MQ_COUNT,x		; increase the queued message count
	ldx		#-1
	stx		MSG_LINK,r1
	plp
	ply
	plx
	pla
	rts

;------------------------------------------------------------------------------
; Returns
; r1 = message number
;------------------------------------------------------------------------------
message "DequeueMsgFromMbx"
DequeueMsgFromMbx:
	phx
	phy
	php
	sei
	tax						; x = mailbox index
	lda		MBX_MQ_COUNT,x		; are there any messages available ?
	beq		dmfm1
	dea
	sta		MBX_MQ_COUNT,x		; update the message count
	lda		MBX_MQ_HEAD,x		; Get the head of the list, this should not be -1
	bmi		dmfm1			; since the message count > 0
	ldy		MSG_LINK,r1		; get the link to the next message
	sty		MBX_MQ_HEAD,x		; update the head of the list
	bpl		dmfm2			; if there was no more messages then update the
	sty		MBX_MQ_TAIL,x		; tail of the list as well.
dmfm2:
	sta		MSG_LINK,r1		; point the link to the messahe itself to indicate it's dequeued
dmfm1:
	plp
	ply
	plx
	rts
	
;------------------------------------------------------------------------------
;------------------------------------------------------------------------------
DequeueThreadFromMbx:
	cpx		#0
	beq		dtfm1
	php
	sei
	push	r4
	ld		r4,MBX_TQ_HEAD,r1
	bpl		dtfm2
		pop		r4
		stz		(x)
		plp
		lda		#E_NoThread
		rts
dtfm2:
	push	r5
	dec		MBX_TQ_COUNT,r1
	st		r4,(x)
	ld		r4,TCB_mbq_next,r4
	st		r4,MBX_TQ_HEAD,r1
	bmi		dtfm3
		ld		r5,#-1
		st		r5,TCB_mbq_prev,r4
		bra		dtfm4
dtfm3:
		ld		r5,#-1
		st		r5,MBX_TQ_TAIL,r1
dtfm4:
	stz		MBX_SEMA+1
	ld		r5,(x)
	lda		TCB_Status,r5
	bit		#TS_TIMEOUT
	beq		dtfm5
		ld		r1,r5
		jsr		RemoveFromTimeoutList
dtfm5:
	ld		r4,#-1
	st		r4,TCB_mbq_next,r5
	st		r4,TCB_mbq_prev,r5
	stz		TCB_hWaitMbx,r5
	lda		TCB_Status,r5
	and		#~TS_WAITMSG
	sta		TCB_Status,r5
	pop		r5
	pop		r4
	plp
	lda		#E_Ok
	rts
dtfm1:
	lda		#E_Arg
	rts

;------------------------------------------------------------------------------
; r1 = handle to mailbox
; r2 = message D1
; r3 = message D2
;------------------------------------------------------------------------------
message "SendMsg"
SendMsg:
	cmp		#0						; check the mailbox number to make sure
	bmi		smsg1					; that it's sensible
	cmp		#2047
	bpl		smsg1
	push	r4
	push	r5
	push	r6
	php
	sei
	ld		r4,MBX_OWNER,r1
	bmi		smsg2					; error: no owner
	pha
	phx
	jsr		DequeueThreadFromMbx	; r1=mbx, r2=thread (returned)
	ld		r6,r2					; r6 = thread
	plx
	pla
	cmp		r6,#0
	bpl		smsg3
		; Here there was no thread waiting at the mailbox, so a message needs to
		; be allocated
		ld		r4,FreeMsg
		bmi		smsg4		; no more messages available
		ld		r5,MSG_LINK,r4
		st		r5,FreeMsg
		dec		nMsgBlk		; decrement the number of available messages
		stx		MSG_D1,r4
		sty		MSG_D2,r4
		pha
		phx
		tax						; x = mailbox
		ld		r1,r4			; acc = message
		jsr		QueueMsgAtMbx
		plx
		pla
		cmp		r6,#0			; check if there is a thread waiting for a message
		bmi		smsg5
smsg3:
	ld		r5,TCB_MSGPTR_D1,r6
	beq		smsg6
	stx		(r5)
smsg6:
	ld		r5,TCB_MSGPTR_D2,r6
	beq		smsg7
	sty		(r5)
smsg7:
	ld		r5,TCB_Status,r6
	and		r5,r5,#TS_TIMEOUT
	beq		smsg8
	ld		r1,r6
	jsr		RemoveFromTimeoutList
smsg8:
	ld		r1,r6
	jsr		AddTaskToReadyList
smsg5:
	plp
	pop		r6
	pop		r5
	pop		r4
	lda		#E_Ok
	rts
smsg1:
	lda		#E_BadMbx
	rts
smsg2:
	plp
	pop		r6
	pop		r5
	pop		r4
	lda		#E_NotAlloc
	rts
smsg4:
	plp
	pop		r6
	pop		r5
	pop		r4
	lda		#E_NoMsg
	rts

;------------------------------------------------------------------------------
; WaitMsg
; Wait at a mailbox for a message to arrive. This subroutine will block the
; task until a message is available or the task times out on the timeout
; list.
;
; Parameters
;	r1=mailbox
;	r2=pointer to D1
;	r3=pointer to D2
;	r4=timeout
; Returns:
;	r1=E_Ok			if everything is ok
;	r1=E_BadMbx		for a bad mailbox number
;	r1=E_NotAlloc	for a mailbox that isn't allocated
;------------------------------------------------------------------------------
WaitMsg:
	cmp		#0						; check the mailbox number to make sure
	bmi		wmsg1					; that it's sensible
	cmp		#2047
	bpl		wmsg1
	phx
	phy
	push	r4
	push	r5
	push	r6
	push	r7
	ld		r6,r1
	php
	sei
	ld		r5,MBX_OWNER,r1
	bmi		wmsg2					; error: no owner
	jsr		DequeueMsgFromMbx
	cmp		#0
	bpl		wmsg3

	; Here there was no message available, remove the task from
	; the ready list, and optionally add it to the timeout list.
	; Queue the task at the mailbox.
	lda		RunningTCB				; remove the task from the ready list
	jsr		RemoveTaskFromReadyList
	ld		r7,TCB_Status,r1			; set task status to waiting
	or		r7,r7,#TS_WAITMSG
	st		r7,TCB_Status,r1
	st		r6,TCB_hWaitMbx,r1			; set which mailbox is waited for
	ld		r7,#-1
	st		r7,TCB_mbq_next,r1			; adding at tail, so there is no next
	stx		TCB_MSGPTR_D1,r1			; save off the message pointers
	sty		TCB_MSGPTR_D2,r1
	ld		r7,MBX_TQ_HEAD,r1			; is there a task que setup at the mailbox ?
	bmi		wmsg6
	ld		r7,MBX_TQ_TAIL,r6
	st		r7,TCB_mbq_prev,r1
	sta		TCB_mbq_next,r7
	sta		MBX_TQ_TAIL,r6
	inc		MBX_TQ_COUNT,r6				; increment number of tasks queued
wmsg7:
	cmp		r4,#0						; check for a timeout
	beq		wmsg10
	ld		r2,r4
	jsr		AddToTimeoutList
wmsg10:
	ld		r2,#wmsg8					; save the return address
	phx
	php									; save status register
	pha									; and save the register set
	phx
	phy
	push	r4
	push	r5
	push	r6
	push	r7
	push	r8
	push	r9
	push	r10
	push	r11
	push	r12
	push	r13
	push	r14
	push	r15
	jmp		SelectTaskToRun
	
	; Here there were no prior tasks queued at the mailbox
wmsg6:
	ld		r7,#-1
	st		r7,TCB_mbq_prev,r1		; no previous tasks
	st		r7,TCB_mbq_next,r1
	sta		MBX_TQ_HEAD,r6			; set both head and tail indexes
	sta		MBX_TQ_TAIL,r6
	ld		r7,#1
	st		r7,MBX_TQ_COUNT,r6		; one task queued
	bra		wmsg7					; check for a timeout value
	
	; Store message D1 to pointer
wmsg3:
	cpx		#0
	beq		wmsg4
	ld		r7,MSG_D1,r1
	st		r7,(x)
	; Store message D2 to pointer
wmsg4:
	cpy		#0
	beq		wmsg5
	ld		r7,MSG_D2,r1
	st		r7,(y)
	; Add the newly dequeued message to the free messsage list
wmsg5:
	ld		r7,FreeMsg
	st		r7,MSG_LINK,r1
	sta		FreeMsg
	inc		nMsgBlk
wmsg8:
	plp
	pop		r7
	pop		r6
	pop		r5
	pop		r4
	ply
	plx
	lda		#E_Ok
	rts
wmsg1:
	lda		#E_BadMbx
	rts
wmsg2:
	plp
	pop		r7
	pop		r6
	pop		r5
	pop		r4
	ply
	plx
	lda		#E_NotAlloc
	rts

;------------------------------------------------------------------------------
; CheckMsg
; Check for a message at a mailbox. Does not block.
;
; Parameters
;	r1=mailbox
;	r2=pointer to D1
;	r3=pointer to D2
;	r4=remove from queue if present
; Returns:
;	r1=E_Ok			if everything is ok
;	r1=E_NoMsg		if no message is available
;	r1=E_BadMbx		for a bad mailbox number
;	r1=E_NotAlloc	for a mailbox that isn't allocated
;------------------------------------------------------------------------------
CheckMsg:
	cmp		#0						; check the mailbox number to make sure
	bmi		cmsg1					; that it's sensible
	cmp		#2047
	bpl		cmsg1
	phx
	phy
	push	r4
	push	r5
	php
	sei
	ld		r5,MBX_OWNER,r1
	bmi		cmsg2					; error: no owner
	cmp		r4,#0					; are we to dequeue the message ?
	beq		cmsg3
	jsr		DequeueMsgFromMbx
	bra		cmsg4
cmsg3:
	lda		MBX_MQ_HEAD,r1
cmsg4:
	cmp		#0
	bmi		cmsg5
	cpx		#0
	beq		cmsg6
	ld		r5,MSG_D1,r1
	st		r5,(x)
cmsg6:
	cpy		#0
	beq		cmsg7
	ld		r5,MSG_D2,r1
	st		r5,(y)
cmsg7:
	cmp		r4,#0
	beq		cmsg8
	ld		r5,FreeMsg
	st		r5,MSG_LINK,r1
	sta		FreeMsg
	inc		nMsgBlk
cmsg8:
	plp
	pop		r5
	pop		r4
	ply
	plx
	lda		#E_Ok
	rts
cmsg1:
	lda		#E_BadMbx
	rts
cmsg2:
	plp
	pop		r5
	pop		r4
	ply
	plx
	lda		#E_NotAlloc
	rts
cmsg5:
	plp
	pop		r5
	pop		r4
	ply
	plx
	lda		#E_NoMsg
	rts

;------------------------------------------------------------------------------
; r1 = task number
; r2 = timeout
;------------------------------------------------------------------------------
PutTaskToSleep:
	jsr		RemoveTaskFromReadyList
	jsr		AddToTimeoutList
	rts

;------------------------------------------------------------------------------
; The I/O focus list is an array indicating which tasks are requesting the
; I/O focus. The I/O focus is user controlled by pressing ALT-TAB on the
; keyboard.
;------------------------------------------------------------------------------
message "RequestIOFocus"
RequestIOFocus:
	pha
	phx
	phy
	php
	sei
	ldx		RunningTCB
	and		r1,r2,#$1F		; get bit index 0 to 31
	ldy		#1
	asl		r3,r3,r1		; shift bit to proper place
	lsr		r2,r2,#5		; get word index /32 bits per word
	lda		IOFocusList,x
	or		r1,r1,r3
	sta		IOFocusList,x
	plp
	ply
	plx
	pla
	rts
	
message "ReleaseIOFocus"	
ReleaseIOFocus:
	pha
	phx
	phy
	php
	sei
	ldx		RunningTCB
	and		r1,r2,#$1F		; get bit index 0 to 31
	ldy		#1
	asl		r3,r3,r1		; shift bit to proper place
	eor		r3,r3,#-1		; invert bit mask
	lsr		r2,r2,#5		; get word index /32 bits per word
	lda		IOFocusList,x
	and		r1,r1,r3
	sta		IOFocusList,x
	plp
	ply
	plx
	pla
	rts

;------------------------------------------------------------------------------
;------------------------------------------------------------------------------
GetScreenLocation:
	lda		RunningTCB
	cmp		OUTPUT_FOCUS
	beq		gsl1
	asl		r1,r1,#13			; 8192 words per screen
	add		r1,r1,#BIOS_SCREENS
	rts
gsl1:
	lda		#TEXTSCR
	rts

GetColorCodeLocation:
	lda		RunningTCB
	cmp		OUTPUT_FOCUS
	beq		gccl1
	asl		r1,r1,#13			; 8192 words per screen
	add		r1,r1,#BIOS_SCREENS+4096
	rts
gccl1:
	lda		#TEXTSCR+$10000
	rts

;------------------------------------------------------------------------------
;------------------------------------------------------------------------------
message "CopyVirtualScreenToScreen"
CopyVirtualScreenToScreen
	pha
	phx
	phy
	lda		#4095				; number of words to copy-1
	ldx		OUTPUT_FOCUS		; compute virtual screen location
	asl		r2,r2,#13			; 8192 words per screen
	add		r2,r2,#BIOS_SCREENS	; add in screens array base address
	ldy		#TEXTSCR
;	mvn
cvss1:
	ld		r4,(x)
	st		r4,(y)
	inx
	iny
	dea
	bne		cvss1
	; now copy the color codes
	lda		#4095
	ldx		OUTPUT_FOCUS
	asl		r2,r2,#13
	add		r2,r2,#BIOS_SCREENS+4096	; virtual char color array
	ldy		#TEXTSCR+$10000
cvss2:
	ld		r4,(x)
	st		r4,(y)
	inx
	iny
	dea
	bne		cvss2
	ply
	plx
	pla
	rts
message "CopyScreenToVirtualScreen"
CopyScreenToVirtualScreen
	pha
	phx
	phy
	lda		#4095
	ldx		#TEXTSCR
	ldy		OUTPUT_FOCUS
	asl		r3,r3,#13
	add		r3,r3,#BIOS_SCREENS
csvs1:
	ld		r4,(x)
	st		r4,(y)
	inx
	iny
	dea
	bne		csvs1
	lda		#4095
	ldx		#TEXTSCR+$10000
	ldy		OUTPUT_FOCUS
	asl		r3,r3,#13
	add		r3,r3,#BIOS_SCREENS+4096
csvs2:
	ld		r4,(x)
	st		r4,(y)
	inx
	iny
	dea
	bne		csvs2
	ply
	plx
	pla
	rts

;------------------------------------------------------------------------------
; Clear the screen and the screen color memory
; We clear the screen to give a visual indication that the system
; is working at all.
;------------------------------------------------------------------------------
;
message "ClearScreen"
ClearScreen:
	pha							; holds a space character
	phx							; loop counter
	phy							; memory addressing
	push	r4					; holds the screen color
	push	r5
	lda		TEXTREG+TEXT_COLS	; calc number to clear
	ldx		TEXTREG+TEXT_ROWS
	mul		r2,r1,r2			; r2 = # chars to clear
	jsr		GetScreenLocation
	tay
	jsr		GetColorCodeLocation
	ld		r5,r1
	lda		#' '				; space char
	ld		r4,ScreenColor
	jsr		AsciiToScreen
csj4:
	sta		(y)
	iny
	st		r4,(r5)
	inc		r5
	dex
	bne		csj4
	pop		r5
	pop		r4
	ply
	plx
	pla
	rts

;------------------------------------------------------------------------------
; Scroll text on the screen upwards
;------------------------------------------------------------------------------
;
message "ScrollUp"
ScrollUp:
	pha
	phx
	phy
	push	r4
	push	r5
	push	r6
	lda		TEXTREG+TEXT_COLS	; acc = # text columns
	ldx		TEXTREG+TEXT_ROWS
	mul		r2,r1,r2			; calc number of chars to scroll
	sub		r2,r2,r1			; one less row
	pha
	jsr		GetScreenLocation
	tay
	jsr		GetColorCodeLocation
	ld		r6,r1
	pla
scrup1:
	add		r5,r3,r1
	ld		r4,(r5)				; move character
	st		r4,(y)
	add		r5,r6,r1
	ld		r4,(r5)				; and move color code
	st		r4,(r6)
	iny
	inc		r6
	dex
	bne		scrup1
	lda		TEXTREG+TEXT_ROWS
	dea
	jsr		BlankLine
	pop		r6
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
	push	r4
	ldx		TEXTREG+TEXT_COLS	; x = # chars to blank out from video controller
	mul		r3,r2,r1			; y = screen index (row# * #cols)
	pha
	jsr		GetScreenLocation
	ld		r4,r1
	pla
	add		r3,r3,r4		; y = screen address
	lda		#' '
	jsr		AsciiToScreen
blnkln1:
	sta		(y)
	iny
	dex
	bne		blnkln1
	pop		r4
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
; HomeCursor
; Set the cursor location to the top left of the screen.
;------------------------------------------------------------------------------
HomeCursor:
	phx
	ldx		RunningTCB
	stz		TCB_CursorRow,x
	stz		TCB_CursorCol,x
	plx
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
	push	r4
	ld		r4,RunningTCB
	lda		TCB_CursorRow,r4
	ldx		TEXTREG+TEXT_COLS
	mul		r2,r2,r1
	add		r2,r2,TCB_CursorCol,r4
	cmp		r4,OUTPUT_FOCUS			; update cursor position in text controller
	bne		csl1					; only for the task with the output focus
	stx		TEXTREG+TEXT_CURPOS
csl1:
	jsr		GetScreenLocation
	add		r1,r2,r1
csl2:
	pop		r4
	plx
	rts

;------------------------------------------------------------------------------
; Display a character on the screen.
; If the task doesn't have the I/O focus then the character is written to
; the virtual screen.
; r1 = char to display
;------------------------------------------------------------------------------
;
message "DisplayChar"
DisplayChar:
	push	r4
	ld		r4,RunningTCB
	and		#$FF				; mask off any higher order bits (called from eight bit mode).
	cmp		#'\r'				; carriage return ?
	bne		dccr
	stz		TCB_CursorCol,r4	; just set cursor column to zero on a CR
	jsr		CalcScreenLoc
	pop		r4
	rts
dccr:
	cmp		#$91				; cursor right ?
	bne		dcx6
	pha
	lda		TCB_CursorCol,r4
	cmp		#83
	bcs		dcx7
	ina
	sta		TCB_CursorCol,r4
dcx7:
	jsr		CalcScreenLoc
	pla
	pop		r4
	rts
dcx6:
	cmp		#$90				; cursor up ?
	bne		dcx8		
	pha
	lda		TCB_CursorRow,r4
	beq		dcx7
	dea
	sta		TCB_CursorRow,r4
	bra		dcx7
dcx8:
	cmp		#$93				; cursor left ?
	bne		dcx9
	pha
	lda		TCB_CursorCol,r4
	beq		dcx7
	dea
	sta		TCB_CursorCol,r4
	bra		dcx7
dcx9:
	cmp		#$92				; cursor down ?
	bne		dcx10
	pha
	lda		TCB_CursorRow,r4
	cmp		#46
	beq		dcx7
	ina
	sta		TCB_CursorRow,r4
	bra		dcx7
dcx10:
	cmp		#$94				; cursor home ?
	bne		dcx11
	pha
	lda		TCB_CursorCol,r4
	beq		dcx12
	stz		TCB_CursorCol,r4
	bra		dcx7
dcx12:
	stz		TCB_CursorRow,r4
	bra		dcx7
dcx11:
	pha
	phx
	phy
	cmp		#$99				; delete ?
	bne		dcx13
	jsr		CalcScreenLoc
	tay							; y = screen location
	lda		TCB_CursorCol,r4	; acc = cursor column
	bra		dcx5
dcx13	
	cmp		#CTRLH				; backspace ?
	bne		dcx3
	lda		TCB_CursorCol,r4
	beq		dcx4
	dea
	sta		TCB_CursorCol,r4
	jsr		CalcScreenLoc		; acc = screen location
	tay							; y = screen location
	lda		TCB_CursorCol,r4
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
	jsr		GetScreenLocation
	sub		r3,r3,r1		; make y an index into the screen
	jsr		GetColorCodeLocation
	add		r3,r3,r1
	lda		CharColor
	sta		(y)
	jsr		IncCursorPos
	bra		dcx4
dclf:
	jsr		IncCursorRow
dcx4:
	ply
	plx
	pla
	pop		r4
	rts

;------------------------------------------------------------------------------
; Increment the cursor position, scroll the screen if needed.
;------------------------------------------------------------------------------
;
IncCursorPos:
	pha
	phx
	push	r4
	ld		r4,RunningTCB
	lda		TCB_CursorCol,r4
	ina
	sta		TCB_CursorCol,r4
	ldx		TEXTREG+TEXT_COLS
	cmp		r1,r2
	bcc		icc1
	stz		TCB_CursorCol,r4		; column = 0
	bra		icr1
IncCursorRow:
	pha
	phx
	push	r4
	ld		r4,RunningTCB
icr1:
	lda		TCB_CursorRow,r4
	ina
	sta		TCB_CursorRow,r4
	ldx		TEXTREG+TEXT_ROWS
	cmp		r1,r2
	bcc		icc1
	beq		icc1
	dex							; backup the cursor row, we are scrolling up
	stx		TCB_CursorRow,r4
	jsr		ScrollUp
icc1:
	jsr		CalcScreenLoc
	pop		r4
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
message "KeybdInit"
KeybdInit:
	lda		#1			; setup semaphore
	sta		KEYBD_SEMA
	ldx		#0
kbdi1:
	stz		KeybdHead,x		; setup keyboard buffer
	stz		KeybdTail,x
	lda		#1			; turn on keyboard echo
	sta		KeybdEcho,x
	stz		KeybdBad,x
	inx
	cpx		#256
	bne		kbdi1
	
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
	phx
	ldx		RunningTCB
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
	lda		KeybdBad,x
	bne		sbtk1
	lda		#1
	sta		KeybdBad,x
	lda		#msgBadKeybd
	jsr		DisplayStringCRLFB
sbtk1:
	plx
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
	phx
	ldx		RunningTCB
WaitForKeybdAck2a:
	lda		KeybdAck,x
	cmp		r1,r2
	bne		WaitForKeybdAck2a
	stz		KeybdAck,x
	plx
	rts

;------------------------------------------------------------------------------
; Normal keyboard interrupt, the lowest priority interrupt in the system.
; Grab the character from the keyboard device and store it in a buffer.
; The buffer of the task with the input focus is updated.
;------------------------------------------------------------------------------
;
message "KeybdIRQ"
KeybdIRQ:
	cld
	pha
	phx
	phy
	push	r4

	; support EhBASIC's IRQ functionality
	; code derived from minimon.asm
	lda		#15				; Keyboard is IRQ #15
	sta		IrqSource	
	lb		r1,IrqBase		; get the IRQ flag byte
;	or		#$20			; set the pending bit
	lsr		r2,r1
	or		r1,r1,r2
	and		#$E0
	sb		r1,IrqBase		; save the new IRQ flag byte

	ld		r4,INPUT_FOCUS	; get the task with the input focus

	ldx		KEYBD				; get keyboard character
	ld		r0,KEYBD+1			; clear keyboard strobe (turns off the IRQ)
	txy							; check for a keyboard ACK code
	and		r3,r3,#$ff
	cmp		r3,#$FA
	bne		KeybdIrq1
	sty		KeybdAck,r4
	bra		KeybdIRQc
KeybdIrq1:
	bit		r2,#$800				; test bit #11
	bne		KeybdIRQc				; ignore keyup messages for now
KeybdIrq2:
	lda		KeybdHead,r4			
	ina								; increment head pointer
	and		#$f						; limit
	ldy		KeybdTail,r4			; check for room in the keyboard buffer
	cmp		r1,r3
	beq		KeybdIRQc				; if no room, the newest char will be lost
	sta		KeybdHead,r4
	dea
	and		#$f
	stx		KeybdLocks,r4
	asl		r4,r4,#4					; * 16
	add		r1,r1,r4
	stx		KeybdBuffer,r1			; store character in buffer
KeybdIRQc:
	pop		r4
	ply
	plx
	pla
	rti

KeybdRstIRQ:
	jmp		start

;------------------------------------------------------------------------------
; r1 0=echo off, non-zero = echo on
;------------------------------------------------------------------------------
SetKeyboardEcho:
	phx
	ldx		RunningTCB
	sta		KeybdEcho,x
	plx
	rts

;------------------------------------------------------------------------------
; Get a bit from the I/O focus table.
;------------------------------------------------------------------------------
GetIOFocusBit:
	phx
	phy
	tax
	and		r1,r1,#$1F		; get bit index into word
	lsr		r2,r2,#5		; get word index into table
	ldy		IOFocusList,x
	lsr		r3,r3,r1		; extract bit
	and		r1,r3,#1
	ply
	plx
	rts
	
;------------------------------------------------------------------------------
; SwitchIOFocus
; Switches the IO focus to the next task requesting the I/O focus.
; Destroys acc,x,y
;------------------------------------------------------------------------------
;
SwitchIOFocus:
	phx
	; Copy the current task's screen to it's virtual screen buffer.
	jsr		CopyScreenToVirtualScreen

	ldy		INPUT_FOCUS
	lda		TCB_Status,y
	or		r1,r1,#TS_WAITFOCUS
	sta		TCB_Status,y
	tya
	jsr		RemoveTaskFromReadyList

	; Cycle through the focus list to find the next task
	; requesting the IO Focus
	ldx		#257			; we want to cycle all the way around
	ldy		INPUT_FOCUS		; back to the original INPUT_FOCUS
	bra		kgc9			; enter the loop at the next possible requester
kgc5:
	tya
	jsr		GetIOFocusBit	; get the focus request status
	cmp		#0
	bne		kgc6			; if requesting focus, break loop
kgc9:
	iny						; move to test in array
	and		r3,r3,#$FF		; limit y to 0 to 255 array elements
	dex
	bne		kgc5
	ldy		INPUT_FOCUS		; We cycled through the whole list and there wasn't another
;							; task requesting focus, so stick with the same task.
kgc6:
	sty		INPUT_FOCUS
	sty		OUTPUT_FOCUS
	lda		TCB_Status,y
	and		#~TS_WAITFOCUS
	sta		TCB_Status,y
	tya
	jsr		AddTaskToReadyList

	; Copy the virtual screen of the task recieving the I/O focus to the
	; text screen.
	jsr		CopyVirtualScreenToScreen
	plx
	rts
	
;------------------------------------------------------------------------------
; Get character from keyboard buffer
; return character in acc or -1 if no
; characters available.
; Also check for ALT-TAB and switch the I/O focus.
;------------------------------------------------------------------------------
message "KeybdGetChar"
KeybdGetChar:
	phx
	push	r4
	php
	sei
	ld		r4,RunningTCB
	ldx		KeybdTail,r4	; if keybdTail==keybdHead then there are no 
	lda		KeybdHead,r4	; characters in the keyboard buffer
	cmp		r1,r2
	beq		nochar
	asl		r4,r4,#4			; * 16
	phx
	add		r2,r2,r4
	lda		KeybdBuffer,x
	plx
	bit		#$200					; check for ALT-tab
	beq		kgc4
	and		#$FF
	cmp		#TAB					; if we find an ALT-tab
	bne		kgc4
	jsr		SwitchIOFocus
	; Now eat up the ALT-TAB character
	inx						; increment index
	and		r2,r2,#$0f
	lsr		r4,r4,#4			; / 16
	stx		KeybdTail,r4
	bra		nochar
kgc4:
	and		r1,r1,#$ff		; mask off control bits
	inx						; increment index
	and		r2,r2,#$0f
	lsr		r4,r4,#4			; / 16
	stx		KeybdTail,r4
	ldx		KeybdEcho,r4
	beq		kgc3
	cmp		#CR
	bne		kgc8
	jsr		CRLF			; convert CR keystroke into CRLF
	bra		kgc3
kgc8:
	jsr		DisplayChar
	bra		kgc3
nochar:
	lda		#-1
kgc3:
	plp
	pop		r4
	plx
	rts

;------------------------------------------------------------------------------
; Check if there is a keyboard character available in the keyboard buffer.
; Returns
; r1 = 1, Z=0 if there is a key available, otherwise
; r1 = 0, Z=1 if there is not a key available
;------------------------------------------------------------------------------
;
message "KeybdCheckForKey"
KeybdCheckForKey:
	phx
	push	r4
	php
	sei
	ld		r4,RunningTCB
	lda		KeybdTail,r4
	ldx		KeybdHead,r4
	sub		r1,r1,r2
	bne		kcfk1
	plp
	pop		r4
	plx
	lda		#0
	rts
kcfk1
	plp
	pop		r4
	plx
	lda		#1
	rts
;------------------------------------------------------------------------------
; Check if there is a keyboard character available. If so return true (1)
; otherwise return false (0) in r1.
;------------------------------------------------------------------------------
;
message "KeybdCheckForKeyDirect"
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
	bit		#$200				; check for ALT-tab
	bne		kgc2
	and		r2,r1,#$7f
	cmp		r2,#TAB					; if we find an ALT-tab
	bne		kgc2
	jsr		SwitchIOFocus
	bra		kgc1
kgc2:
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


;==============================================================================
; Serial port
;==============================================================================
;------------------------------------------------------------------------------
; Initialize the serial port
; r1 = low 28 bits = baud rate
; r2 = other settings
; The desired baud rate must fit in 28 bits or less.
;------------------------------------------------------------------------------
;
SerialInit:
;	asl		r1,r1,#4			; * 16
;	shlui	r1,r1,#32			; * 2^32
;	inhu	r2,CR_CLOCK			; get clock frequency from config record
;	divu	r1,r1,r2			; / clock frequency

	lsr		r1,r1,#8			; drop the lowest 8 bits
	sta		UART_CM1			; set LSB
	lsr		r1,r1,#8
	sta		UART_CM2			; set middle bits
	lsr		r1,r1,#8
	sta		UART_CM3			; set MSB
	stz		Uart_rxhead			; reset buffer indexes
	stz		Uart_rxtail
	lda		#0x1f0
	sta		Uart_foff			; set threshold for XOFF
	lda		#0x010
	sta		Uart_fon			; set threshold for XON
	lda		#1
	sta		UART_IE				; enable receive interrupt only
	stz		Uart_rxrts			; no RTS/CTS signals available
	stz		Uart_txrts			; no RTS/CTS signals available
	stz		Uart_txdtr			; no DTR signals available
	stz		Uart_rxdtr			; no DTR signals available
	lda		#1
	sta		Uart_txxon			; for now
	lda		#1
	sta		SERIAL_SEMA
	rts

;---------------------------------------------------------------------------------
; Get character directly from serial port. Blocks until a character is available.
;---------------------------------------------------------------------------------
;
SerialGetCharDirect:
sgc1:
	lda		UART_LS		; uart status
	and		#rxfull		; is there a char available ?
	beq		sgc1
	lda		UART
	rts

;------------------------------------------------
; Check for a character at the serial port
; returns r1 = 1 if char available, 0 otherwise
;------------------------------------------------
;
SerialCheckForCharDirect:
	lda		UART_LS			; uart status
	and		#rxfull			; is there a char available ?
	rts

;-----------------------------------------
; Put character to serial port
; r1 = char to put
;-----------------------------------------
;
SerialPutChar:
	phx
	phy
	push	r4
	push	r5

	ldx		UART_MC
	or		r2,r2,#3		; assert DTR / RTS
	stx		UART_MC
	ldx		Uart_txrts
	beq		spcb1
	ld		r4,Milliseconds
	ldy		#1000			; delay count (1 s)
spcb3:
	ldx		UART_MS
	and		r2,r2,#$10		; is CTS asserted ?
	bne		spcb1
	ld		r5,Milliseconds
	cmp		r4,r5
	beq		spcb3
	ld		r4,r5
	dey
	bne		spcb3
	bra		spcabort
spcb1:
	ldx		Uart_txdtr
	beq		spcb2
	ld		r4,Milliseconds
	ldy		#1000			; delay count
spcb4:
	ldx		UART_MS
	and		r2,r2,#$20		; is DSR asserted ?
	bne		spcb2
	ld		r5,Milliseconds
	cmp		r4,r5
	beq		spcb4
	ld		r4,r5
	dey
	bne		spcb4
	bra		spcabort
spcb2:	
	ldx		Uart_txxon
	beq		spcb5
spcb6:
	ldx		Uart_txxonoff
	beq		spcb5
	ld		r4,UART_MS
	and		r4,r4,#0x80			; DCD ?
	bne		spcb6
spcb5:
	ld		r4,Milliseconds
	ldy		#1000				; wait up to 1s
spcb8:
	ldx		UART_LS
	and		r2,r2,#0x20			; tx not full ?
	bne		spcb7
	ld		r5,Milliseconds
	cmp		r4,r5
	beq		spcb8
	ld		r4,r5
	dey
	bne		spcb8
	bra		spcabort
spcb7:
	sta		UART
spcabort:
	pop		r5
	pop		r4
	ply
	plx
	rts

;-------------------------------------------------
; Compute number of characters in recieve buffer.
; r4 = number of chars
;-------------------------------------------------
CharsInRxBuf:
	ld		r4,Uart_rxhead
	ldx		Uart_rxtail
	sub		r4,r4,r2
	bpl		cirxb1
	ld		r4,#0x200
	add		r4,r4,r2
	ldx		Uart_rxhead
	sub		r4,r4,r2
cirxb1:
	rts

;----------------------------------------------
; Get character from rx fifo
; If the fifo is empty enough then send an XON
;----------------------------------------------
;
SerialGetChar:
	phx
	phy
	push	r4

	ldy		Uart_rxhead
	ldx		Uart_rxtail
	cmp		r2,r3
	beq		sgcfifo1		; is there a char available ?
	lda		Uart_rxfifo,x	; get the char from the fifo into r1
	inx						; increment the fifo pointer
	and		r2,r2,#$1ff
	stx		Uart_rxtail
	ldx		Uart_rxflow		; using flow control ?
	beq		sgcfifo2
	ldy		Uart_fon		; enough space in Rx buffer ?
	jsr		CharsInRxBuf
	cmp		r4,r3
	bpl		sgcfifo2
	stz		Uart_rxflow		; flow off
	ld		r4,Uart_rxrts
	beq		sgcfifo3
	ld		r4,UART_MC		; set rts bit in MC
	or		r4,r4,#2
	st		r4,UART_MC
sgcfifo3:
	ld		r4,Uart_rxdtr
	beq		sgcfifo4
	ld		r4,UART_MC		; set DTR
	or		r4,r4,#1
	st		r4,UART_MC
sgcfifo4:
	ld		r4,Uart_rxxon
	beq		sgcfifo5
	ld		r4,#XON
	st		r4,UART
sgcfifo5:
sgcfifo2:					; return with char in r1
	pop		r4
	ply
	plx
	rts
sgcfifo1:
	lda		#-1				; no char available
	pop		r4
	ply
	plx
	rts


;-----------------------------------------
; Serial port IRQ
;-----------------------------------------
;
SerialIRQ:
	pha
	phx
	phy
	push	r4

	lda		UART_IS			; get interrupt status
	bpl		sirq1			; no interrupt
	and		#0x7f			; switch on interrupt type
	cmp		#4
	beq		srxirq
	cmp		#$0C
	beq		stxirq
	cmp		#$10
	beq		smsirq
	; unknown IRQ type
sirq1:
	pop		r4
	ply
	plx
	pla
	rti


; Get the modem status and record it
smsirq:
	lda		UART_MS
	sta		Uart_ms
	bra		sirq1

stxirq:
	bra		sirq1

; Get a character from the uart and store it in the rx fifo
srxirq:
srxirq1:
	lda		UART				; get the char (clears interrupt)
	ldx		Uart_txxon
	beq		srxirq3
	cmp		#XOFF
	bne		srxirq2
	lda		#1
	sta		Uart_txxonoff
	bra		srxirq5
srxirq2:
	cmp		#XON
	bne		srxirq3
	stz		Uart_txxonoff
	bra		srxirq5
srxirq3:
	stz		Uart_txxonoff
	ldx		Uart_rxhead
	sta		Uart_rxfifo,x		; store in buffer
	inx
	and		r2,r2,#$1ff
	stx		Uart_rxhead
srxirq5:
	lda		UART_LS				; check for another ready character
	and		#rxfull
	bne		srxirq1
	lda		Uart_rxflow			; are we using flow controls?
	bne		srxirq8
	jsr		CharsInRxBuf
	lda		Uart_foff
	cmp		r4,r1
	bmi		srxirq8
	lda		#1
	sta		Uart_rxflow
	lda		Uart_rxrts
	beq		srxirq6
	lda		UART_MC
	and		#$FD			; turn off RTS
	sta		UART_MC
srxirq6:
	lda		Uart_rxdtr
	beq		srxirq7
	lda		UART_MC
	and		#$FE			; turn off DTR
	sta		UART_MC
srxirq7:
	lda		Uart_rxxon
	beq		srxirq8
	lda		#XOFF
	sta		UART
srxirq8:
	bra		sirq1


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

message "Monitor"
;==============================================================================
; System Monitor Program
; The system monitor is task#0
;==============================================================================
;
Monitor:
	ldx		#BIOS_STACKS+0x03FF	; setup stack pointer
	txs
	ldx		RunningTCB
	stz		KeybdEcho,x		; turn off keyboard echo
PromptLn:
	jsr		CRLF
	lda		#'$'
	jsr		DisplayChar

; Get characters until a CR is keyed
;
Prompt3:
;	lw		r1,#2			; get keyboard character
;	syscall	#417
;	jsr		KeybdCheckForKeyDirect
;	cmp		#0
	jsr		KeybdGetChar
	cmp		#-1
	beq		Prompt3
;	jsr		KeybdGetCharDirect
	cmp		#CR
	beq		Prompt1
	jsr		DisplayChar
	bra		Prompt3

; Process the screen line that the CR was keyed on
;
Prompt1:
	ldx		RunningTCB
	stz		TCB_CursorCol,x	; go back to the start of the line
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
	lda		#3
	ldy		#CSTART
	ldx		#0
	jsr		StartTask
;	jsr		CSTART
	bra		Monitor
Prompt4:
	cmp		#'b'
	bne		Prompt5
	lda		#3				; priority level 3
	ldy		#$C000			; start address $C000
	ldx		#$20000000		; flags: emmulation mode set
	jsr		StartTask
	bra		Monitor
	emm
	cpu		W65C02
	jml		$0C000
	cpu		rtf65002
Prompt5:
	cmp		#'J'			; $J - execute code
	beq		ExecuteCode
	cmp		#'L'			; $L - load dector
	beq		LoadSector
	cmp		#'W'
	beq		WriteSector
Prompt9:
	cmp		#'?'			; $? - display help
	bne		Prompt10
	lda		#HelpMsg
	jsr		DisplayStringB
	jmp		Monitor
Prompt10:
	cmp		#'C'			; $C - clear screen
	beq		TestCLS
	cmp		#'r'
	bne		Prompt12
	lda		#4				; priority level 4
	ldx		#0				; zero all flags at startup
	ldy		#RandomLines	; task address
	jsr		(y)
;	jsr		StartTask
	jmp		Monitor
;	jmp		RandomLinesCall
Prompt12:
Prompt13:
	cmp		#'P'
	bne		Prompt14
	jmp		Piano
Prompt14:
	cmp		#'T'
	bne		Prompt15
	jsr		DumpTaskList
	jmp		Monitor
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
	cmp		#'e'
	bne		Prompt17
	jsr		eth_main
Prompt17:
	cmp		#'R'
	bne		Monitor
	lda		(y)
	iny
	jsr		ScreenToAscii
	cmp		#'S'
	beq		ReadSector
	dey
	bra		SetRegValue
	jmp		Monitor
message "Prompt16"
RandomLinesCall:
;	jsr		RandomLines
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
	ldx		RunningTCB
	stz		TCB_CursorCol,x
	stz		TCB_CursorRow,x
	jsr		CalcScreenLoc
	jmp		Monitor
message "HelpMsg"
HelpMsg:
	db	"? = Display help",CR,LF
	db	"CLS = clear screen",CR,LF
	db	"S = Boot from SD Card",CR,LF
	db	": = Edit memory bytes",CR,LF
	db	"L = Load sector",CR,LF
	db	"W = Write sector",CR,LF
	db  "DR = Dump registers",CR,LF
	db	"D = Dump memory",CR,LF
	db	"F = Fill memory",CR,LF
	db	"B = start tiny basic",CR,LF
	db	"b = start EhBasic 6502",CR,LF
	db	"J = Jump to code",CR,LF
	db	"R[n] = Set register value",CR,LF
	db	"r = random lines - test bitmap",CR,LF
	db	"e = ethernet test",CR,LF
	db	"T = Dump task list",CR,LF
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
message "ExecuteCode"
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
	st		r1,TCB_SPSave
	tsr		sp8,r1
	st		r1,TCB_SP8Save
	pla
	sta		SRSave
	jmp     Monitor

LoadSector:
	jsr		ignBlanks
	jsr		GetDecNumber
	pha
	jsr		ignBlanks
	jsr		GetHexNumber
	tax
	phx
;	ld		r2,#0x3800
	jsr		spi_init
	plx
	pla
	jsr		spi_read_sector
	jmp		Monitor

WriteSector:
	jsr		ignBlanks
	jsr		GetDecNumber
	pha
	jsr		ignBlanks
	jsr		GetHexNumber
	tax
	phx
	jsr		spi_init
	plx
	pla
	jsr		spi_write_sector
	jmp		Monitor

;------------------------------------------------------------------------------
; Dump the register set.
;------------------------------------------------------------------------------
message "DumpReg"
DumpReg:
	ldy		#0
DumpReg1:
	jsr		CRLF
	lda		#':'
	jsr		DisplayChar
	lda		#'R'
	jsr		DisplayChar
	ldx		#1
	tya
	ina
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
	lda		TCB_SPSave
	jsr		DisplayWord
	jsr		CRLF
	jmp		Monitor
;------------------------------------------------------------------------------
;------------------------------------------------------------------------------
SetRegValue:
	jsr		GetDecNumber
	cmp		#15
	bpl		Monitor
	pha
	jsr		ignBlanks
	jsr		GetHexNumber
	ply
	sta		R1Save,y
	jmp		Monitor
		
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
message "FillMem"
FillMem:
	jsr		ignBlanks
	jsr		GetHexNumber	; get start address of dump
	tax
	jsr		ignBlanks
	jsr		GetHexNumber	; get number of bytes to fill
	ld		r5,r1
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

GetDecNumber:
	phx
	push	r4
	push	r5
	ldx		#0
	ld		r4,#10
	ld		r5,#10
gtdcn2:
	lda		(y)
	iny
	jsr		ScreenToAscii
	jsr		AsciiToDecNybble
	cmp		#-1
	beq		gtdcn1
	mul		r2,r2,r5
	add		r2,r2,r1
	dec		r4
	bne		gtdcn2
gtdcn1:
	txa
	pop		r5
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

AsciiToDecNybble:
	cmp		#'0'
	bcc		gtdc3
	cmp		#'9'+1
	bcs		gtdc3
	sub		#'0'
	rts
gtdc3:
	lda		#-1
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
; Z=1 if successful, otherwise Z=0
;
message "spi_init"
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
	rts
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
	rts

spi_delay:
	nop
	nop
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
	jsr		spi_delay			; just a delay between consecutive status reg reads
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
; Returns
; r1 = 0 everything okay, 1=read error
; also Z=1=everything okay, Z=0=read error
;
spi_read_part:
	phx
	stz		startSector						; default starting sector
	lda		#0								; r1 = sector number (#0)
	ldx		#BYTE_SECTOR_BUF				; r2 = target address (word to byte address)
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
; Returns:
; r1 = 0 means this card is bootable
; r1 = 1 means a read error occurred
; r1 = 2 means the card is not bootable
;
spi_read_boot:
	phx
	phy
	push	r5
	lda		startSector					; r1 = sector number
	ldx		#BYTE_SECTOR_BUF			; r2 = target address
	jsr		spi_read_sector
	cmp		#0
	bne		spi_read_boot_err
	lb		r1,BYTE_SECTOR_BUF
	cmp		#$EB
	bne		spi_eb_err
spi_read_boot2:
	lda		#msgFoundEB
	jsr		DisplayStringB
	lb		r1,BYTE_SECTOR_BUF+$1FE		; check for 0x55AA signature
	cmp		#$55
	bne		spi_eb_err
	lb		r1,BYTE_SECTOR_BUF+$1FF		; check for 0x55AA signature
	cmp		#$AA
	bne		spi_eb_err
	pop		r5
	ply
	plx
	lda		#0						; r1 = 0, for okay status
	rts
spi_read_boot_err:
	pop		r5
	ply
	plx
	lda		#1
	rts
spi_eb_err:
	lda		#msgNotFoundEB
	jsr		DisplayStringB
	pop		r5
	ply
	plx
	lda		#2
	rts

msgFoundEB:
	db	"Found EB code.",CR,LF,0
msgNotFoundEB:
	db	"EB/55AA Code missing.",CR,LF,0

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
	lda		PROG_LOAD_AREA>>2		; make sure it's bootable
	cmp		#$544F4F42
	bne		loadBootFile2
	lda		#msgJumpingToBoot
	jsr		DisplayStringB
	lda		(PROG_LOAD_AREA>>2)+$1
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
	db	"SD card boot error",CR,LF,0
spi_read_error_msg:
	db	"SD card read error",CR,LF,0
spi_write_error_msg:
	db	"SD card write error",0

;==============================================================================
; Ethernet
;==============================================================================
my_MAC1	EQU	0x00
my_MAC2	EQU	0xFF
my_MAC3	EQU	0xEE
my_MAC4	EQU	0xF0
my_MAC5	EQU	0xDA
my_MAC6	EQU	0x42

; Initialize the ethmac controller.
; Supply a MAC address, set MD clock
;
message "eth_init"
eth_init:
	pha
	phy
	ldy		#ETHMAC
	lda		#0x64				; 100
	sta		ETH_MIIMODER,y
	lda		#7					; PHY address
	sta		ETH_MIIADDRESS,y
	lda		#0xEEF0DA42
	sta		ETH_MAC_ADDR0,y		; MAC0
	lda		#0x00FF
	sta		ETH_MAC_ADDR1,y		; MAC1
	ply
	pla
	rts

; Request a packet and display on screen
; r1 = address where to put packet
;
message "eth_request_packet"
eth_request_packet:
	phx
	phy
	push	r4
	push	r5
	ldy		#ETHMAC
	ldx		#4					; clear rx interrupt
	stx		ETH_INT_SOURCE,y
	sta		0x181,y				; storage address
	ldx		#0xe000				; enable interrupt
	stx		0x180,y
eth1:
	nop
	ldx		ETH_INT_SOURCE,y
	and		r2,r2,#4			; get bit #2
	beq		eth1
	ldx		0x180,y				; get from descriptor
	lsr		r2,r2,#16
	ldy		#0
	ld		r4,#TEXTSCR+3780	; second last line of screen
eth20:
	add		r5,r1,r3
	ldx		(r5)				; get byte
	add		r5,r4,r3
	stx		(r5)				; store to screen
	iny
	cpy		#83
	bne		eth20
	pop		r5
	pop		r4
	ply
	plx
	rts

; r1 = packet address
;
message "eth_interpret_packet"
eth_interpret_packet:
	phx
	phy
	lb		r2,12,r1
	lb		r3,13,r1
	cpx		#8					; 0x806 ?
	bne		eth2	
	cpy		#6		
	bne		eth2
	lda		#2					; return r1 = 2 for ARP
eth5:
	ply
	plx
	rts
eth2:
	cpx		#8
	bne		eth3				; 0x800 ?
	cpy		#0
	bne		eth3
	lb		r2,23,r1
	cpx		#1
	bne		eth4
	lda		#1
	bra		eth5				; return 1 ICMP
eth4:
	cpx		#$11
	bne		eth6
	lda		#3					; return 3 for UDP
	bra		eth5
eth6:
	cpx		#6
	bne		eth7
	lda		#4					; return 4 for TCP
	bra		eth5
eth7:
eth3:
	eor		r1,r1,r1			; return zero for unknown
	ply
	plx
	rts

; r1 = address of packet to send
; r2 = packet length
;
message "eth_send_packet"
eth_send_packet:
	phx
	phy
	push	r4
	ldy		#ETHMAC
	; wait for tx buffer to be clear
eth8:
	ld		r4,0x100,y
	and		r4,r4,#$8000
	bne		eth8
	ld		r4,#1			; clear tx interrupt
	st		r4,ETH_INT_SOURCE,y
	; set address
	sta		0x101,y
	; set the packet length field and enable interrupts
	asl		r2,r2,#16
	or		r2,r2,#0xF000
	stx		0x100,y
	pop		r4
	ply
	plx
	rts

; Only for IP type packets (not ARP)
; r1 = rx buffer address
; r2 = swap flag
; Returns:
; r1 = data start index
;
message "eth_build_packet"
eth_build_packet:
	phy
	push	r4
	push	r5
	push	r6
	push	r7
	push	r8
	push	r9
	push	r10

	lb		r3,6,r1
	lb		r4,7,r1
	lb		r5,8,r1
	lb		r6,9,r1
	lb		r7,10,r1
	lb		r8,11,r1
	; write to destination header
	sb		r3,0,r1
	sb		r4,1,r1
	sb		r5,2,r1
	sb		r6,3,r1
	sb		r7,4,r1
	sb		r8,5,r1
	; write to source header
	ld		r3,#my_MAC1
	sb		r3,6,r1
	ld		r3,#my_MAC2
	sb		r3,7,r1
	ld		r3,#my_MAC3
	sb		r3,8,r1
	ld		r3,#my_MAC4
	sb		r3,9,r1
	ld		r3,#my_MAC5
	sb		r3,10,r1
	ld		r3,#my_MAC6
	sb		r3,11,r1
	cmp		r2,#1
	bne		eth16			; if (swap)
	lb		r3,26,r1
	lb		r4,27,r1
	lb		r5,28,r1
	lb		r6,29,r1
	; read destination
	lb		r7,30,r1
	lb		r8,31,r1
	lb		r9,32,r1
	lb		r10,33,r1
	; write to sender
	sb		r7,26,r1
	sb		r8,27,r1
	sb		r9,28,r1
	sb		r10,29,r1
	; write destination
	sb		r3,30,r1
	sb		r4,31,r1
	sb		r5,32,r1
	sb		r6,33,r1
eth16:
	ldy		eth_unique_id
	iny
	sty		eth_unique_id
	sb		r3,19,r1
	lsr		r3,r3,#8
	sb		r3,18,r1
	lb		r3,14,r1
	and		r3,r3,#0xF
	asl		r3,r3,#2		; *4
	add		r1,r3,#14		; return datastart in r1
	pop		r10
	pop		r9
	pop		r8
	pop		r7
	pop		r6
	pop		r5
	pop		r4
	ply
	rts

; Compute IPv4 checksum of header
; r1 = packet address
; r2 = data start
;
message "eth_checksum"
eth_checksum:
	phy
	push	r4
	push	r5
	push	r6
	; set checksum to zero
	stz		24,r1
	stz		25,r1
	eor		r3,r3,r3		; r3 = sum = zero
	ld		r4,#14
eth15:
	ld		r5,r2
	dec		r5				; r5 = datastart - 1
	cmp		r4,r5
	bpl		eth14
	add		r6,r1,r4
	lb		r5,0,r6			; shi = [rx_addr+i]
	lb		r6,1,r6		    ; slo = [rx_addr+i+1]
	asl 	r5,r5,#8
	or		r5,r5,r6		; shilo
	add		r3,r3,r5		; sum = sum + shilo
	add		r4,r4,#2		; i = i + 2
	bra		eth15
eth14:
	ld		r5,r3			; r5 = sum
	and		r3,r3,#0xffff
	lsr		r5,r5,#16
	add		r3,r3,r5
	eor		r3,r3,#-1
	sb		r3,25,r1		; low byte
	lsr		r3,r3,#8
	sb		r3,24,r1		; high byte
	pop		r6
	pop		r5
	pop		r4
	ply
	rts

; r1 = packet address
; returns r1 = 1 if this IP
;	
message "eth_verifyIP"
eth_verifyIP:
	phx
	phy
	push	r4
	push	r5
	lb		r2,30,r1
	lb		r3,31,r1
	lb		r4,32,r1
	lb		r5,33,r1
	; Check for general broadcast
	cmp		r2,#$FF
	bne		eth11
	cmp		r3,#$FF
	bne		eth11
	cmp		r4,#$FF
	bne		eth11
	cmp		r5,#$FF
	bne		eth11
eth12:
	lda		#1
eth13:
	pop		r5
	pop		r4
	ply
	plx
	rts
eth11:
	ld		r1,r2
	asl		r1,r1,#8
	or		r1,r1,r3
	asl		r1,r1,#8
	or		r1,r1,r4
	asl		r1,r1,#8
	or		r1,r1,r5
	cmp		#$C0A8012A		; 192.168.1.42
	beq		eth12
	eor		r1,r1,r1
	bra		eth13

message "eth_main"
eth_main:
	jsr		eth_init
eth_loop:
	jsr		KeybdGetChar
	cmp		#-1
	beq		eth17
	cmp		#CTRLC
	bne		eth17
	rts
eth17
	lda		#eth_rx_buffer<<2		; memory address zero
	jsr		eth_request_packet
	jsr		eth_interpret_packet	; r1 = packet type

	cmp		#1
	bne		eth10
	ld		r2,r1					; save off r1, r2 = packet type
	lda		#eth_rx_buffer<<2		; memory address zero
	jsr		eth_verifyIP
	tay
	txa								; r1 = packet type again
	cpy		#1
	bne		eth10

	lda		#eth_rx_buffer<<2		; memory address zero
	ldx		#1
	jsr		eth_build_packet
	tay								; y = icmpstart
	lda		#eth_rx_buffer<<2		; memory address zero
	add		r4,r1,r3
	sb		r0,0,r4					; [rx_addr+icmpstart] = 0
	lb		r2,17,r1
	add		r2,r2,#14				; r2 = len
	ld		r6,r2					; r6 = len
	add		r15,r1,r3
	lb		r4,2,r15				; shi
	lb		r5,3,r15				; slo
	asl		r4,r4,#8
	or		r4,r4,r5				; sum = {shi,slo};
	eor		r4,r4,#-1				; sum = ~sum
	sub		r4,r4,#0x800			; sum = sum - 0x800
	eor		r4,r4,#-1				; sum = ~sum
	add		r15,r1,r3
	sb		r4,3,r15
	lsr		r4,r4,#8
	sb		r4,2,r15
	tyx
	jsr		eth_checksum
	lda		#eth_rx_buffer<<2		; memory address zero
	ld		r2,r6
	jsr		eth_send_packet
	jmp		eth_loop
eth10:
	; r2 = rx_addr
	cmp		#2
	bne		eth_loop		; Do we have ARP ?
;	xor		r2,r2,r2			; memory address zero
	ldx		#eth_rx_buffer<<2
	; get the opcode
	lb		r13,21,x
	cmp		r13,#1
	bne		eth_loop		; ARP request
	; get destination IP address
	lb		r9,38,x
	lb		r10,39,x
	lb		r11,40,x
	lb		r12,41,x
	; set r15 = destination IP
	ld		r15,r9
	asl		r15,r15,#8
	or		r15,r15,r10
	asl		r15,r15,#8
	or		r15,r15,r11
	asl		r15,r15,#8
	or		r15,r15,r12
	; Is it our IP ?
	cmp		r15,#$C0A8012A	; //192.168.1.42
	bne		eth_loop
	; get source IP address
	lb		r5,28,x
	lb		r6,29,x
	lb		r7,30,x
	lb		r8,31,x
	; set r14 = source IP
	ld		r14,r5
	asl		r14,r14,#8
	or		r14,r14,r6
	asl		r14,r14,#8
	or		r14,r14,r7
	asl		r14,r14,#8
	or		r14,r14,r8
	; Get the source MAC address
	push	r6
	push	r7
	push	r8
	push	r9
	push	r10
	push	r11
	lb		r6,22,x
	lb		r7,23,x
	lb		r8,24,x
	lb		r9,25,x
	lb		r10,26,x
	lb		r11,27,x
	; write to destination header
	sb		r6,0,x
	sb		r7,1,x
	sb		r8,2,x
	sb		r9,3,x
	sb		r10,4,x
	sb		r11,5,x
	; and write to ARP destination
	sb		r6,32,x
	sb		r7,33,x
	sb		r8,34,x
	sb		r9,35,x
	sb		r10,36,x
	sb		r11,37,x
	pop		r11
	pop		r10
	pop		r9
	pop		r8
	pop		r7
	pop		r6
	; write to source header
;	stbc	#0x00,6[r2]
;	stbc	#0xFF,7[r2]
;	stbc	#0xEE,8[r2]
;	stbc	#0xF0,9[r2]
;	stbc	#0xDA,10[r2]
;	stbc	#0x42,11[r2]
	sb		r0,6,x
	lda		#0xFF
	sb		r1,7,x
	lda		#0xEE
	sb		r1,8,x
	lda		#0xF0
	sb		r1,9,x
	lda		#0xDA
	sb		r1,10,x
	lda		#0x42
	sb		r1,11,x
	; write to ARP source
;	stbc	#0x00,22[r2]
;	stbc	#0xFF,23[r2]
;	stbc	#0xEE,24[r2]
;	stbc	#0xF0,25[r2]
;	stbc	#0xDA,26[r2]
;	stbc	#0x42,27[r2]
	sb		r0,22,x
	lda		#0xFF
	sb		r1,23,x
	lda		#0xEE
	sb		r1,24,x
	lda		#0xF0
	sb		r1,25,x
	lda		#0xDA
	sb		r1,26,x
	lda		#0x42
	sb		r1,27,x
	; swap sender / destination IP
	; write sender
	sb		r9,28,x
	sb		r10,29,x
	sb		r11,30,x
	sb		r12,31,x
	; write destination
	sb		r5,38,x
	sb		r6,39,x
	sb		r7,40,x
	sb		r8,41,x
	; change request to reply
;	stbc	#2,21[r2]
	lda		#2
	sb		r1,21,x
	txa						; r1 = packet address
	ldx		#0x2A			; r2 = packet length
	jsr		eth_send_packet
	jmp		eth_loop

;--------------------------------------------------------------------------
; Initialize sprite image caches with random data.
;--------------------------------------------------------------------------
RandomizeSprram:
	ldx		#SPRRAM
	ld		r4,#14336		; number of chars to initialize
rsr1:
	tsr		LFSR,r1
	sta		(x)
	inx
	dec		r4
	bne		rsr1
	rts

;--------------------------------------------------------------------------
; Draw random lines on the bitmap screen.
;--------------------------------------------------------------------------
;
RandomLines:
	pha
	phx
	phy
	push	r4
	push	r5
	jsr		RequestIOFocus
rl5:
	tsr		LFSR,r1
	tsr		LFSR,r2
	jsr		DrawPixel
	tsr		LFSR,r1
	sta		LineColor		; select a random color
rl1:						; random X0
	tsr		LFSR,r1
	ld		r5,#1364
	mod		r1,r1,r5
rl2:						; random X1
	tsr		LFSR,r3
	mod		r3,r3,r5
rl3:						; random Y0
	tsr		LFSR,r2
	ld		r5,#768
	mod		r2,r2,r5
rl4:						; random Y1
	tsr		LFSR,r4
	ld		r5,#768
	mod		r4,r4,r5
rl8:
	jsr		DrawLine
	jsr		KeybdGetChar
	cmp		#CTRLC
	beq		rl7
	bra		rl5
rl7:
	jsr		ReleaseIOFocus
	pop		r5
	pop		r4
	ply
	plx
	pla
	rts

DrawPixel:
	pha
	phx
	phy
	push	r4
	ld		r4,#768
	mod		r2,r2,r4
	ld		r4,#1364
	mod		r1,r1,r4
	mul		r2,r2,r4	; y * 1364
	add		r1,r1,r2	; + x
	ldy		LineColor
	sb		r3,BITMAPSCR<<2,r1
	pop		r4
	ply
	plx
	pla
	rts
	
;50 REM DRAWLINE
;100 dx = ABS(xb-xa)
;110 dy = ABS(yb-ya)
;120 sx = SGN(xb-xa)
;130 sy = SGN(yb-ya)
;140 er = dx-dy
;150 PLOT xa,ya
;160 if xa<>xb goto 200
;170 if ya=yb goto 300
;200 ee = er * 2
;210 if ee <= -dy goto 240
;220 er = er - dy
;230 xa = xa + sx
;240 if ee >= dx goto 270
;250 er = er + dx
;260 ya = ya + sy
;270 GOTO 150
;300 RETURN

DrawLine:
	pha
	phx
	phy
	push	r4
	push	r5
	push	r6
	push	r7
	push	r8
	push	r9
	push	r10
	push	r11

	sub		r5,r3,r1	; dx = abs(x2-x1)
	bpl		dln1
	sub		r5,r0,r5
dln1:
	sub		r6,r4,r2	; dy = abs(y2-y1)
	bpl		dln2
	sub		r6,r0,r6
dln2:

	sub		r7,r3,r1	; sx = sgn(x2-x1)
	beq		dln5
	bpl		dln4
	ld		r7,#-1
	bra		dln5
dln4:
	ld		r7,#1
dln5:

	sub		r8,r4,r2	; sy = sgn(y2-y1)
	beq		dln8
	bpl		dln7
	ld		r8,#-1
	bra		dln8
dln7:
	ld		r8,#1

dln8:
	sub		r9,r5,r6	; er = dx-dy
dln150:
	jsr		DrawPixel
	cmp		r1,r3		; if (xa <> xb)
	bne		dln200		;    goto 200
	cmp		r2,r4		; if (ya==yb)
	beq		dln300		;    goto 300
dln200:
	asl		r10,r9		; ee = er * 2
	sub		r11,r0,r6	; r11 = -dy
	cmp		r10,r11		; if (ee <= -dy)
	bmi		dln240		;     goto 240
	beq		dln240
	sub		r9,r9,r6	; er = er - dy
	add		r1,r1,r7	; xa = xa + sx
dln240:
	cmp		r10,r5		; if (ee >= dx)
	bpl		dln150		;    goto 150
	add		r9,r9,r5	; er = er + dx
	add		r2,r2,r8	; ya = ya + sy
	bra		dln150		; goto 150

dln300:
	pop		r11
	pop		r10
	pop		r9
	pop		r8
	pop		r7
	pop		r6
	pop		r5
	pop		r4
	ply
	plx
	pla
	rts

;include "float.asm"

;------------------------------------------------------------------------------
; Bus Error Routine
; This routine display a message then restarts the BIOS.
;------------------------------------------------------------------------------
;
message "bus_err_rout"
bus_err_rout:
	cld
	pla							; get rid of the stacked flags
	ply							; get the error PC
	ldx		#$05FFFFF8			; setup stack pointer top of memory
	txs
	jsr		CRLF
	lda		#msgBusErr
	jsr		DisplayStringB
	tya
	jsr		DisplayWord			; display the originating PC address
	lda		#msgDataAddr
	jsr		DisplayStringB
	tsr		#9,r1
	jsr		DisplayWord
	cli							; enable interrupts so we can get a char
	jsr		KeybdGetChar
	jmp		start
	
msgBusErr:
	db		"Bus error at: ",0
msgDataAddr:
	db		" data address: ",0

strStartQue:
	db		1,0,0,0,2,0,0,0,3,1,0,0,4,0,0,0

;------------------------------------------------------------------------------
; 100 Hz interrupt
; - takes care of "flashing" the cursor
; - switching tasks
;------------------------------------------------------------------------------
;
p100Hz:
	; Handle every other interrupt because 100Hz interrupts may be too fast.
	pha
	lda		IRQFlag
	ina
	sta		IRQFlag
	ror
	bcc		p100Hz11	
	pla
	rti

p100Hz11:

	cld		; clear extended precision mode

	; save off regs on the stack
	phx
	phy
	push	r4
	push	r5
	push	r6
	push	r7
	push	r8
	push	r9
	push	r10
	push	r11
	push	r12
	push	r13
	push	r14
	push	r15
	ldx		RunningTCB
	and		r2,r2,#$FF
	tsa						; save off the stack pointer
	sta		TCB_SPSave,x
	tsr		sp8,r1			; and the eight bit mode stack pointer
	sta		TCB_SP8Save,x

	; support EhBASIC's IRQ functionality
	; code derived from minimon.asm
	lda		#3				; Timer is IRQ #3
	sta		IrqSource		; stuff a byte indicating the IRQ source for PEEK()
	lb		r1,IrqBase		; get the IRQ flag byte
;	ora		#$20			; set IRQ pending bit
	lsr		r2,r1
	or		r1,r1,r2
	and		#$E0
	sb		r1,IrqBase


	inc		TEXTSCR+83		; update IRQ live indicator on screen
	stz		0xFFDCFFFC		; clear interrupt
	
	; flash the cursor
	lda		CursorFlash		; test if we want a flashing cursor
	beq		p100Hz1a
	jsr		CalcScreenLoc	; compute cursor location in memory
	tay
	lda		$10000,y		; get color code $10000 higher in memory
	ldx		IRQFlag			; get counter
	lsr		r2,r2
	and		r2,r2,#$0F		; limit to low order nybble
	and		#$F0			; prepare to or in new value, mask off foreground color
	or		r1,r1,r2		; set new foreground color for cursor
	sta		$10000,y		; store the color code back to memory
p100Hz1a

	; Check the timeout list to see if there are items ready to be removed from
	; the list. Also decrement the timeout of the item at the head of the list.

p100Hz15:	
	ldx		TimeoutList
	bmi		p100Hz12				; are there any entries in the timeout list ?
	lda		TCB_Timeout,x
	bne		p100Hz14				; has this entry timed out ?
	txa
	jsr		RemoveFromTimeoutList
	jsr		AddTaskToReadyList
	bra		p100Hz15				; go back and see if there's another task to be removed

p100Hz14:
	dea								; decrement the entries timeout
	sta		TCB_Timeout,x
	
p100Hz12:
SelectTaskToRun:
	; Search the ready queues for a ready task.
	; The search is occasionally started at a lower priority queue in order
	; to prevent starvation of lower priority tasks. This is managed by 
	; using a tick count as an index to a string containing the start que.

	ld		r6,#5			; number of queues to search
	ldy		IRQFlag			; use the IRQFlag as a buffer index
	lsr		r3,r3,#1		; the LSB is always the same
	and		r3,r3,#$0F		; counts from 0 to 15
	lb		r3,strStartQue,y	; get the queue to start search at
p100Hz2:
	lda		HeadRdy0,y
	bmi		p100Hz1
	; Move the head of the ready queue to the tail
	jsr		RemoveTaskFromReadyList	; remove task
	jsr		AddTaskToReadyList		; add it back (automatically goes to tail spot)
	ldx		TCB_Status,r1		; the task is no longer running
	and		r2,r2,#~TS_RUNNING
	stx		TCB_Status,r1
	lda		HeadRdy0,y
	sta		RunningTCB
	ldx		TCB_Status,r1		; flag the task as the running task
	or		r2,r2,#TS_RUNNING
	stx		TCB_Status,r1
	bra		p100Hz3
p100Hz1:
	iny
	cpy		#5
	bne		p100Hz5
	ldy		#0
p100Hz5
	dec		r6
	bne		p100Hz2

	; here there were no tasks ready
	stz		RunningTCB			; select BIOS task
	ldx		TCB_Status		; flag the task as the running task
	or		r2,r2,#TS_RUNNING
	stx		TCB_Status
p100Hz3:
p100Hz10
	ldx		RunningTCB
	and		r2,r2,#$FF
	lda		TCB_SP8Save,x		; get back eight bit stack pointer
	trs		r1,sp8
	ldx		TCB_SPSave,x		; get back stack pointer
	txs
	; restore registers
	pop		r15
	pop		r14
	pop		r13
	pop		r12
	pop		r11
	pop		r10
	pop		r9
	pop		r8
	pop		r7
	pop		r6
	pop		r5
	pop		r4
	ply
	plx
	pla
	rti


;------------------------------------------------------------------------------
; 1000 Hz interrupt
; This IRQ must be fast.
; Increments the millisecond counter
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
	