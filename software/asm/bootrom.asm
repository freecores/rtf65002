
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
TS_PREEMPT	=4
TS_RUNNING	=8
TS_READY	=16
TS_SLEEP	=32

MAX_TASKNO	= 255

DIRENT_NAME		=0x00	; file name
DIRENT_EXT		=0x1C	; file name extension
DIRENT_ATTR		=0x20	; attributes
DIRENT_DATETIME	=0x28
DIRENT_CLUSTER	=0x30	; starting cluster of file
DIRENT_SIZE		=0x34	; file size (6 bytes)

; One FCB is allocated and filled out for each file that is open.
;
nFCBs	= 128
FCB_DE_NAME		=0x00
FCB_DE_EXT		=0x1C
FCB_DE_ATTR		=0x20
FCB_DE_DATETIME	=0x28
FCB_DE_CLUSTER	=0x30	; starting cluster of file
FCB_DE_SIZE		=0x34	; 6 byte file size

FCB_DIR_SECTOR	=0x40	; LBA directory sector this is from
FCB_DIR_ENT		=0x44	; offset in sector for dir entry
FCB_LDRV		=0x48	; logical drive this is on
FCB_MODE		=0x49	; 0 read, 1=modify
FCB_NUSERS		=0x4A	; number of users of this file
FCB_FMOD		=0x4B	; flag: this file was modified
FCB_RESV		=0x4C	; padding out to 80 bytes
FCB_SIZE		=0x50

FUB_JOB		=0x00	; User's job umber
FUB_iFCB	=0x02	; FCB number for this file
FUB_CrntLFA	=0x04	; six byte current logical file address
FUB_pBuf	=0x0C	; pointer to buffer if in stream mode
FUB_sBuf	=0x10	; size of buffer for stream file
FUB_LFABuf	=0x14	; S-First LFA in Clstr Buffer
FUB_LFACluster	=0x18	; LFA of cluster
FUB_Clstr	= 0x20		; The last cluster read
FUB_fModified	= 0x24	; data in buffer was modified
FUB_fStream		= 0x25	; non-zero for stream mode
FUB_PAD		=0x26	
FUB_SIZE	=0x30

; Boot sector info (62 byte structure) */
BSI_JMP		= 0x00
BSI_OEMName	= 0x03
BSI_bps		= 0x0B
BSI_SecPerCluster	= 0x0D
BSI_ResSectors	= 0x0E
BSI_FATS	= 0x10
BSI_RootDirEnts	= 0x11
BSI_Sectors	= 0x13
BSI_Media	= 0x15
BSI_SecPerFAT	= 0x16
BSI_SecPerTrack	= 0x18
BSI_Heads	= 0x1A
BSI_HiddenSecs	= 0x1C
BSI_HugeSecs	= 0x1E

BSI_DriveNum	= 0x24
BSI_Rsvd1		= 0x25
BSI_BootSig		= 0x26
BSI_VolID		= 0x27
BSI_VolLabel	= 0x2B
BSI_FileSysType = 0x36

	 
MEM_CHK		=0
MEM_FLAG	=1
MEM_PREV	=2
MEM_NEXT	=3

; message queuing strategy
MQS_UNLIMITED	=0	; unlimited queue size
MQS_NEWEST		=1	; buffer queue size newest messages
MQS_OLDEST		=2	; buffer queue size oldest messages

LEDS		EQU		0xFFDC0600
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
PIC_ES		EQU		0xFFDC0FF4
PIC_RSTE	EQU		0xFFDC0FF5
TASK_SELECT	EQU		0xFFDD0008
RQ_SEMA		EQU		0xFFDB0000
TO_SEMA		EQU		0xFFDB0010
SERIAL_SEMA	EQU		0xFFDB0020
KEYBD_SEMA	EQU		0xFFDB0030
IOF_LIST_SEMA	EQU	0xFFDB0040
MBX_SEMA	EQU		0xFFDB0050
MEM_SEMA	EQU		0xFFDB0060

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
GA_X0		EQU		0xFFDAE002
GA_Y0		EQU		0xFFDAE003
GA_PEN		EQU		0xFFDAE000
GA_X1		EQU		0xFFDAE004
GA_Y1		EQU		0xFFDAE005
GA_STATE	EQU		0xFFDAE00E
GA_CMD		EQU		0xFFDAE00F

AC97		EQU		0xFFDC1000
PSG			EQU		0xFFD50000
PSGFREQ0	EQU		0xFFD50000
PSGPW0		EQU		0xFFD50001
PSGCTRL0	EQU		0xFFD50002
PSGADSR0	EQU		0xFFD50003

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

ETH_WCTRLDATA	EQU		4
ETH_MIICOMMAND_RSTAT	EQU	2
ETH_MIISTATUS_BUSY	EQU		2
ETH_MIIMODER_RST	EQU		$200
ETH_MODER_RST       EQU		$800
ETH_MII_BMCR		EQU		0		; basic mode control register
ETH_MII_ADVERTISE	EQU		4
ETH_MII_EXPANSION       =6
ETH_MII_CTRL1000        =9
ETH_ADVERTISE_ALL	EQU		$1E0
ETH_ADVERTISE_1000FULL      =0x0200  ; Advertise 1000BASE-T full duplex
ETH_ADVERTISE_1000HALF      =0x0100  ; Advertise 1000BASE-T half duplex
ETH_ESTATUS_1000_TFULL	=0x2000	; Can do 1000BT Full
ETH_ESTATUS_1000_THALF	=0x1000	; Can do 1000BT Half
ETH_BMCR_ANRESTART      =    0x0200  ; Auto negotiation restart    
ETH_BMCR_ISOLATE        =    0x0400  ; Disconnect DP83840 from MII
ETH_BMCR_PDOWN          =    0x0800  ; Powerdown the DP83840     
ETH_BMCR_ANENABLE       =    0x1000  ; Enable auto negotiation    

ETH_PHY		=7

MMU			EQU		0xFFDC4000
MMU_KVMMU	EQU		0xFFDC4800
MMU_FUSE	EQU		0xFFDC4811
MMU_AKEY	EQU		0xFFDC4812
MMU_OKEY	EQU		0xFFDC4813
MMU_MAPEN	EQU		0xFFDC4814

DATETIME	EQU		0xFFDC0400
DATETIME_TIME		EQU		0xFFDC0400
DATETIME_DATE		EQU		0xFFDC0401
DATETIME_ALMTIME	EQU		0xFFDC0402
DATETIME_ALMDATE	EQU		0xFFDC0403
DATETIME_CTRL		EQU		0xFFDC0404
DATETIME_SNAPSHOT	EQU		0xFFDC0405

SPRITEREGS	EQU		0xFFDAD000
SPRRAM		EQU		0xFFD80000

THRD_AREA	EQU		0x04000000	; threading area 0x04000000-0x40FFFFF
BITMAPSCR	EQU		0x04100000
SECTOR_BUF	EQU		0x05FBEC00
BIOS_STACKS	EQU		0x05FC0000	; room for 256 1kW stacks
BIOS_SCREENS	EQU	0x05C00000	; 0x05C00000 to 0x05DFFFFF

BYTE_SECTOR_BUF	EQU	SECTOR_BUF<<2
PROG_LOAD_AREA	EQU		0x4180000<<2

FCBs			EQU		0x5F40000	; room for 128 FCB's

FATOFFS			EQU		0x5F50000	; offset into FAT on card
FATBUF			EQU		0x5F60000
DIRBUF			EQU		0x5F70000
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
TCB_CursorRow	EQU		0x05FBD100
TCB_CursorCol	EQU		0x05FBD200
TCB_hWaitMbx	EQU		0x05FBD300	; handle of mailbox task is waiting at
TCB_mbq_next	EQU		0x05FBD400	; mailbox queue next
TCB_mbq_prev	EQU		0x05FBD500	; mailbox queue previous
TCB_iof_next	EQU		0x05FBD600
TCB_iof_prev	EQU		0x05FBD700
TCB_SP8Save		EQU		0x05FBD800	; TCB_SP8Save area 
TCB_SPSave		EQU		0x05FBD900	; TCB_SPSave area
TCB_ABS8Save	EQU		0x05FBDA00
TCB_mmu_map		EQU		0x05FBDB00

KeybdHead	EQU		0x05FBEA00
KeybdTail	EQU		0x05FBEB00
KeybdEcho	EQU		0x05FBEC00
KeybdBad	EQU		0x05FBED00
KeybdAck	EQU		0x05FBEE00
KeybdLocks	EQU		0x05FBEF00
KeybdBuffer	EQU		0x05FBF000	; buffer is 16 chars

HeapStart	EQU		0x04200000
HeapEnd		EQU		0x043FFFFF

; Bitmap of tasks requesting the I/O focus
;
IOFocusTbl	EQU		0x05FBD000

; EhBASIC vars:
;
NmiBase		EQU		0xDC
IrqBase		EQU		0xDF

; BIOS vars at the top of the 8kB scratch memory
;
; TinyBasic AREA = 0xF00 to 0xF7F

QNdx0		EQU		0xF80
QNdx1		EQU		QNdx0+1
QNdx2		EQU		QNdx1+1
QNdx3		EQU		QNdx2+1
QNdx4		EQU		QNdx3+1
FreeTCB		EQU		QNdx4+1
TimeoutList	EQU		FreeTCB+1
RunningTCB		EQU		TimeoutList+1
FreeMbx		EQU		RunningTCB + 1
nMailbox	EQU		FreeMbx + 1
FreeMsg		EQU		nMailbox + 1
nMsgBlk		EQU		FreeMsg + 1

; The IO focus list is a doubly linked list formed into a ring.
;
IOFocusNdx	EQU		nMsgBlk + 1

IrqSource	EQU		0xF98

JMPTMP		EQU		0xFA0
SP8Save		EQU		0xFAE
SRSave		EQU		0xFAF
R1Save		EQU		0xFB0
R2Save		EQU		0xFB1
R3Save		EQU		0xFB2
R4Save		EQU		0xFB3
R5Save		EQU		0xFB4
R6Save		EQU		0xFB5
R7Save		EQU		0xFB6
R8Save		EQU		0xFB7
R9Save		EQU		0xFB8
R10Save		EQU		0xFB9
R11Save		EQU		0xFBA
R12Save		EQU		0xFBB
R13Save		EQU		0xFBC
R14Save		EQU		0xFBD
R15Save		EQU		0xFBE
SPSave		EQU		0xFBF

CharColor	EQU		0xFC0
ScreenColor	EQU		0xFC1
CursorRow	EQU		0xFC2
CursorCol	EQU		0xFC3
CursorFlash	EQU		0xFC4
Milliseconds	EQU		0xFC5
IRQFlag		EQU		0xFC6
RdyQueTick	EQU		0xFC7
eth_unique_id	EQU		0xFC8
LineColor	EQU		0xFC9
QIndex		EQU		0xFCA
ROMcs		EQU		0xFCB
mmu_present	EQU		0xFCC
TestTask	EQU		0xFCD
KeybdIsSetup	EQU		0xFCE

Uart_rxfifo		EQU		0x05FBC000
Uart_rxhead		EQU		0xFD0
Uart_rxtail		EQU		0xFD1
Uart_ms			EQU		0xFD2
Uart_rxrts		EQU		0xFD3
Uart_rxdtr		EQU		0xFD4
Uart_rxxon		EQU		0xFD5
Uart_rxflow		EQU		0xFD6
Uart_fon		EQU		0xFD7
Uart_foff		EQU		0xFD8
Uart_txrts		EQU		0xFD9
Uart_txdtr		EQU		0xFDA
Uart_txxon		EQU		0xFDB
Uart_txxonoff	EQU		0xFDC

startSector	EQU		0xFF0


	cpu		rtf65002
	code

message "jump table"
	; jump table of popular BIOS routines
	org		$FFFF8000
ROMStart:
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
	dw	Sleep
	dw	do_load
	dw	do_save

	org		$FFFF8400		; leave room for 256 vectors
message "cold start point"
KeybdRST
start
	sei						; disable interrupts
	cld						; disable decimal mode
	lda		#1
	sta		LEDS
	ldx		#BIOS_STACKS+0x03FF	; setup stack pointer top of memory
	txs
	trs		r0,abs8			; set 8 bit mode absolute address offset
	lda		#3
	trs		r1,cc			; enable dcache and icache
	jsr		ROMChecksum
	sta		ROMcs
	stz		mmu_present		; assume no mmu
	lda		CONFIGREC
	bit		#4096
	beq		st_nommu
	jsr		InitMMU			; setup the maps and enable the mmu
	lda		#1
	sta		mmu_present
st_nommu:
	jsr		MemInit			; Initialize the heap

	lda		#2
	sta		LEDS

	; setup interrupt vectors
	ldx		#$05FB0001		; interrupt vector table from $5FB0000 to $5FB01FF
							; also sets nmoi policy (native mode on interrupt)
	trs		r2,vbr
	dex
	phx
	txy						; y = pointer to vector table
	lda		#511			; 512 vectors to setup
	ldx		#brk_rout		; point vector to brk routine
	stos

	plx
	lda		#brk_rout
	sta		(x)
	lda		#slp_rout
	sta		1,x
	lda		#reschedule
	sta		2,x
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
	lda		#InvalidOpIRQ
	sta		495,x
	lda		#bus_err_rout
	sta		508,x
	sta		509,x

	lda		#3
	sta		LEDS

	; stay in native mode in case emulation is not supported.
	ldx		#$1FF			; set 8 bit stack pointer
	trs		r2,sp8
	
	ldx		#0
	stz		IrqBase			; support for EhBASIC's interrupt mechanism
	stz		NmiBase

	lda		#-1
	sta		TimeoutList		; no entries in timeout list
	sta		QNdx0
	sta		QNdx1
	sta		QNdx2
	sta		QNdx3
	sta		QNdx4


	; Initialize IO Focus List
	;
	lda		#7
	ldx		#0
	ldy		#IOFocusTbl
	stos

	lda		#255
	ldx		#-1
	ldy		#TCB_iof_next
	stos
	lda		#255
	ldx		#-1
	ldy		#TCB_iof_prev
	stos

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
	lda		#4
	sta		LEDS

	; Manually setup the BIOS task
	stz		RunningTCB		; BIOS is task #0
	stz		TCB_NxtRdy		; manually build the ready list
	stz		TCB_PrvRdy
	stz		QNdx0			; insert at priority 0
	stz		TCB_iof_next	; manually build the IO focus list
	stz		TCB_iof_prev
	stz		IOFocusNdx		; task #0 has the focus
	lda		#1
	sta		IOFocusTbl		; set the task#0 request bit
	lda		#0
	sta		TCB_Priority
	stz		TCB_Timeout
	lda		#TS_RUNNING|TS_READY
	sta		TCB_Status
	stz		TCB_CursorRow
	stz		TCB_CursorCol

	lda		#1
	sta		MBX_SEMA
	sta		IOF_LIST_SEMA
	sta		RQ_SEMA			; set ready queue semaphore
	sta		TO_SEMA			; set timeout list semaphore

	lda		#$CE			; CE =blue on blue FB = grey on grey
	sta		ScreenColor
	sta		CharColor
	sta		CursorFlash
	jsr		ClearScreen
	jsr		ClearBmpScreen
	jsr		PICInit
	; Enable interrupts
	; This will likely cause an interrupt right away because the timer
	; pulses run since power-up.
	cli						
	lda		#4
	ldx		#0
	ldy		#IdleTask
	jsr		StartTask
	lda		CONFIGREC		; do we have a serial port ?
	bit		#32
	beq		st7
	; 19200 * 16
	;-------------
	; 25MHz / 2^32
	lda		#$03254E6E		; constant for 19,200 baud at 25MHz
	jsr		SerialInit
st7:
	lda		#5
	sta		LEDS
	lda		CONFIGREC		; do we have sprites ?
	bit		#1
	beq		st8
	lda		#$3FFF			; turn on sprites
	sta		SPRITEREGS+120
	jsr		RandomizeSprram
st8:
	; Enable interrupts.
	; Keyboard initialization must take place after interrupts are
	; enabled.
	cli						
	lda		#14
	sta		LEDS
	jsr		KeybdInit
	lda		#1
	sta		KeybdEcho
	lda		#6
	sta		LEDS

	; The following must be after interrupts are enabled.
	lda		#9
	sta		LEDS
	jsr		HomeCursor
	lda		#msgStart
	jsr		DisplayStringB
	jsr		ReportMemFree
	lda		#msgChecksum
	jsr		DisplayStringB
	lda		ROMcs
	jsr		DisplayWord
	jsr		CRLF
	lda		#10
	sta		LEDS

	; The AC97 setup uses the millisecond counter and the
	; keyboard.
	lda		CONFIGREC		; do we have a sound generator ?
	bit		#4
	beq		st6
	jsr		SetupAC97
	lda		#4
	ldx		#0
	ldy		#Beep
;	jsr		StartTask
st6:
	lda		#11
	sta		LEDS
	jmp		Monitor
st1
	jsr		KeybdGetCharDirect
	bra		st1
	stp
	bra		start
	
msgStart
	db		"RTF65002 system starting.",$0d,$0a,00

;------------------------------------------------------------------------------
; InitMMU
;
; Initialize the 64 maps of the MMU.
; Initially all the maps are set the same:
; Virtual Page  Physical Page
; 000-255		 000-255
; 256-511		1792-2047
; Note that there are only 512 virtual pages per map, and 2048 real
; physical pages of memory. This limits maps to 32MB.
; This range includes the BIOS assigned stacks for the tasks and tasks
; virtual video buffers. It also includes the bitmap screen buffer.
; Note that physical pages 256 to 1791 are not mapped, but do exist.
; If changing the maps the last 128 pages (8MB) of the map should always point
; to the BIOS area. Don't change map entries 384-511 or the system may
; crash.
; If the rts at the end of this routine works, then memory was mapped
; successfully.
;------------------------------------------------------------------------------
InitMMU:
	lda		#1
	sta		MMU_KVMMU+1
	dea
	sta		MMU_KVMMU
immu1:
	sta		MMU_AKEY	; set access key for map
	ldy		#0		; 
	ldx		#0
immu2:
	; set the first 256 pages to physical page 0-255
	; set the last 256 pages to physical page 1792-2047
	ld		r4,r3
	bit		r3,#$0100
	beq		immu3
	add		r4,r4,#1536
immu3:
	st		r4,MMU,x
	iny
	inx
	cpx		#512
	bne		immu2
	ina
	cmp		#64			; 64 MMU maps
	bne		immu1
	stz		MMU_OKEY	; set operating key to map #0
	lda		#2
	sta		MMU_FUSE	; set fuse to 2 clocks before mapping starts
	nop
	nop

EnableMMUMapping:
	pha
	lda		#1
	sta		MMU_MAPEN
	pla
	rts
DisableMMUMapping:
	stz		MMU_MAPEN
	rts

;------------------------------------------------------------------------------
; The ROM contents are summed up to ensure the ROM is okay.
;------------------------------------------------------------------------------
ROMChecksum:
	lda		#0
	ldx		#ROMStart>>2
idc1:
	add		(x)
	inx
	cpx		#$100000000>>2
	bne		idc1
	cmp		#0			; The sum of all the words in the
						; ROM should be zero.
	rts

msgChecksum:
	db	CR,LF,"ROM checksum: ",0

;----------------------------------------------------------
; Initialize programmable interrupt controller (PIC)
;  0 = nmi (parity error)
;  1 = keyboard reset
;  2 = 1000Hz pulse
;  3 = 100Hz pulse (cursor flash)
;  4 = ethmac
;  8 = uart
; 13 = raster interrupt
; 15 = keyboard char
;----------------------------------------------------------
message "PICInit"
PICInit:
	;
	lda		#$000C			; clock pulses are edge sensitive
	sta		PIC_ES
	lda		#$000F			; enable nmi,kbd_rst
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
	lda		QNdx0,y
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
	cmp		r4,QNdx0,y
	bne		dtl3
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
;------------------------------------------------------------------------------
message "DumpTimeoutList"
DumpTimeoutList:
	pha
	phx
	phy
	push	r4
	lda		#msgTimeoutList
	jsr		DisplayStringB
	php
	sei
dtol2:
	lda		TimeoutList
	ld		r4,r1
	bmi		dtol1
dtol3:
	ld		r1,r4
	ldx		#3
	jsr		PRTNUM
	lda		#' '
	jsr		DisplayChar
	jsr		DisplayChar
	jsr		DisplayChar
	ld		r1,r4
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
	bpl		dtol3
dtol1:
	plp
	pop		r4
	ply
	plx
	pla
	rts

msgTimeoutList:
	db	CR,LF,"Task Prv Nxt Timeout",CR,LF,0

;------------------------------------------------------------------------------
;------------------------------------------------------------------------------
message "DumpIOFocusList"
DumpIOFocusList:
	pha
	phx
	phy
	php
	sei
	lda		#msgIOFocusList
	jsr		DisplayStringB
	lda		IOFocusNdx
diofl2:
	bmi		diofl1
	tay
	ldx		#3
	jsr		PRTNUM
	lda		#' '
	jsr		DisplayChar
	lda		TCB_iof_prev,y
	ldx		#3
	jsr		PRTNUM
	lda		#' '
	jsr		DisplayChar
	lda		TCB_iof_next,y
	ldx		#3
	jsr		PRTNUM
	jsr		CRLF
	lda		TCB_iof_next,y
	cmp		IOFocusNdx
	bne		diofl2
	
diofl1:
	plp
	ply
	plx
	pla
	rts
	
msgIOFocusList:
	db	CR,LF,"Task Prv Nxt",CR,LF,0

RunningTCBErr:
;	lda		#$FF
;	sta		LEDS
	lda		#msgRunningTCB
	jsr		DisplayStringB
rtcberr1:
	jsr		KeybdGetChar
	cmp		#-1
	beq		rtcberr1
	jmp		start

msgRunningTCB:
	db	CR,LF,"RunningTCB is bad.",CR,LF,0

;------------------------------------------------------------------------------
; IdleTask
;
; IdleTask is a low priority task that is always running. It runs when there
; is nothing else to run.
; This task check for tasks that are stuck in infinite loops and kills them.
;------------------------------------------------------------------------------
IdleTask:
	stz		TestTask
it2:
	inc		TEXTSCR+111		; increment IDLE active flag
	ldx		TestTask
	and		r2,r2,#$FF
	beq		it1
	lda		TCB_Status,x
	cmp		#TS_SLEEP
	bne		it1
	txa
	jsr		KillTask
it1:
	inc		TestTask
	cli						; enable interrupts
	wai						; wait for one to happen
	bra		it2

;------------------------------------------------------------------------------
; StartTask
;
; Startup a task. The task is automatically allocated a 1kW stack from the BIOS
; stacks area. The scheduler is invoked after the task is added to the ready
; list.
;
; Parameters:
;	r1 = task priority
;	r2 = start flags
;	r3 = start address
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
	ld		r6,r1				; r6 = task priority
	ld		r8,r2				; r8 = flag register value on startup
	
	; get a free TCB
	;
	php
	sei
	lda		FreeTCB				; get free tcb list pointer
	bmi		stask1
	tax
	lda		TCB_NxtTCB,x
	sta		FreeTCB				; update the FreeTCB list pointer
	plp
	txa							; acc = TCB index (task number)
	
	; setup the stack for the task
	; Zap the stack memory.
	ld		r7,r2
	asl		r2,r2,#10			; 1kW stack per task
	add		r2,r2,#BIOS_STACKS	;+0x3ff	; add in stack base
	pha
	phx
	phy
	txy							; y = target address
	ldx		#ExitTask			; x = fill value
	lda		#$3FF				; acc = # words to fill -1
	stos
	ply
	plx
	pla
	
	add		r2,r2,#$3FF			; Move pointer to top of stack
	php
	tsr		sp,r4				; save off current stack pointer
	sei
	txs
	ldx		#$1FF
	stx		TCB_SP8Save,r7
	st		r6,TCB_Priority,r7
	stz		TCB_Status,r7
	stz		TCB_Timeout,r7
	; setup virtual video for the task
	stz		TCB_CursorRow,r7
	stz		TCB_CursorCol,r7
	stz		TCB_mmu_map,r7		; use mmu map #0
	stz		TCB_ABS8Save,r7

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
	plp
	int		#2		; invoke the scheduler
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
	plp
	lda		#msgNoTCBs
	jsr		DisplayStringB
	bra		stask2

msgNoTCBs:
	db		"No more task control blocks available.",CR,LF,0

;------------------------------------------------------------------------------
; ExitTask
;
; This routine is called when the task exits with an rts instruction. OR
; it may be invoked with a JMP ExitTask. In either case the task must be
; running so it can't be on the timeout list. The scheduler is invoked
; after the task is removed from the ready list.
;------------------------------------------------------------------------------
message "ExitTask"
ExitTask:
	sei
	; release any aquired resources
	; - mailboxes
	; - messages
	hoff
	lda		RunningTCB
	cmp		#MAX_TASKNO
	bhi		xtsk1
	jsr		RemoveTaskFromReadyList
	jsr		RemoveFromTimeoutList
	stz		TCB_Status,r1				; set task status to TS_NONE
	jsr		ReleaseIOFocus
	ldx		#86
	stx		LEDS
	ldx		FreeTCB						; add the task control block to the free list
	stx		TCB_NxtTCB,r1
	sta		FreeTCB
xtsk1:
	jmp		SelectTaskToRun

;------------------------------------------------------------------------------
; r1 = task number
; r2 = new priority
;------------------------------------------------------------------------------
SetTaskPriority:
	cmp		#MAX_TASKNO					; make sure task number is reasonable
	bhi		stp1
	cpx		#5							; make sure priority is okay
	bhs		stp1
	phy
	php
	sei
	ldy		TCB_Status,r1				; if the task is on the ready list
	bit		r3,#TS_READY|TS_RUNNING		; then remove it and re-add it.
	beq		stp2						; Otherwise just go set the priority field
	jsr		RemoveTaskFromReadyList
	stx		TCB_Priority,r1
	jsr		AddTaskToReadyList
	plp
	ply
stp1:
	rts
stp2:
	stx		TCB_Priority,r1
	plp
	ply
	rts

;------------------------------------------------------------------------------
; AddTaskToReadyList
;
; The ready list is a group of five ready lists, one for each priority
; level. Each ready list is organized as a doubly linked list to allow fast
; insertions and removals. The list is organized as a ring (or bubble) with
; the last entry pointing back to the first. This allows a fast task switch
; to the next task. Which task is at the head of the list is maintained
; in the variable QNdx for the priority level.
;
; Registers Affected: none
; Parameters:
;	r1 = task number
; Returns:
;	none
;------------------------------------------------------------------------------
;
message "AddTaskToReadyList"
AddTaskToReadyList:
	php
	phx
	phy
	sei
	ldx		#TS_READY
	stx		TCB_Status,r1
	ldy		TCB_Priority,r1
	ldx		QNdx0,y
	bmi		arl5
	ldy		TCB_PrvRdy,x
	sta		TCB_NxtRdy,y
	sty		TCB_PrvRdy,r1
	sta		TCB_PrvRdy,x
	stx		TCB_NxtRdy,r1
arl3:	
	ply
	plx
	plp
	rts

	; Here the ready list was empty, so add at head
arl5:
	sta		QNdx0,y
	sta		TCB_NxtRdy,r1
	sta		TCB_PrvRdy,r1
	ply
	plx
	plp
	rts
	
;------------------------------------------------------------------------------
; RemoveTaskFromReadyList
;
; This subroutine removes a task from the ready list.
;
; Registers Affected: none
; Parameters:
;	r1 = task number
; Returns:
;   r1 = task number
;------------------------------------------------------------------------------

message "RemoveTaskFromReadyList"
RemoveTaskFromReadyList:
	php						; save off interrupt mask state
	phx
	phy
	push	r4
	push	r5

	sei
	ldy		TCB_Status,r1	; is the task on the ready list ?
	bit		r3,#TS_READY|TS_RUNNING
	beq		rfr2
	stz		TCB_Status,r1		; task status = TS_NONE
	ld		r4,TCB_NxtRdy,r1	; Get previous and next fields.
	ld		r5,TCB_PrvRdy,r1
	st		r4,TCB_NxtRdy,r5
	st		r5,TCB_PrvRdy,r4
	ldy		TCB_Priority,r1
	cmp		r1,QNdx0,y			; Are we removing the QNdx task ?
	bne		rfr2
	st		r4,QNdx0,y
	; Now we test for the case where the task being removed was the only one
	; on the ready list of that priority level. We can tell because the
	; NxtRdy would point to the task itself.
	cmp		r4,r1				
	bne		rfr2
	ldx		#-1					; Make QNdx negative
	stx		QNdx0,y
	stx		TCB_NxtRdy,r1
	stx		TCB_PrvRdy,r1
rfr2:
	pop		r5
	pop		r4
	ply
	plx
	plp
	rts

;------------------------------------------------------------------------------
; AddToTimeoutList
; AddToTimeoutList adds a task to the timeout list. The task is placed in the
; list depending on it's timeout value.
;
; Registers Affected: none
; Parameters:
;	r1 = task
;	r2 = timeout value
;------------------------------------------------------------------------------
message "AddToTimeoutList"
AddToTimeoutList:
	php
	phx
	push	r4
	push	r5
	sei

	ld		r5,#-1
	ld		r4,TimeoutList	; are there any tasks on the timeout list ?
	cmp		r4,#MAX_TASKNO
	bhi		attl1
attl_check_next:
	sub		r2,r2,TCB_Timeout,r4	; is this timeout > next
	bmi		attl_insert_before
	ld		r5,r4
	ld		r4,TCB_NxtRdy,r4
	cmp		r4,#MAX_TASKNO
	bls		attl_check_next

	; Here we scanned until the end of the timeout list and didn't find a 
	; timeout of a greater value. So we add the task to the end of the list.
attl_add_at_end:
	st		r4,TCB_NxtRdy,r1	; r4 was = -1
	st		r1,TCB_NxtRdy,r5
	st		r5,TCB_PrvRdy,r1
	st		r2,TCB_Timeout,r1
	bra		attl_exit

attl_insert_before:
	cmp		r5,#MAX_TASKNO
	bhi		attl2
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
	ldx		#TS_TIMEOUT			; set the task's status as timing out
	stx		TCB_Status,r1
	pop		r5
	pop		r4
	plx
	plp
	rts
msgTimeout1:
	db	CR,LF,"Adding to timeout list:",CR,LF,0
	
;------------------------------------------------------------------------------
; RemoveFromTimeoutList
;
; This subroutine is called from within the timer ISR when the task's 
; timeout expires. It may also be called when a task is killed.
;
; Registers Affected: none
; Parameters:
;	 r1 = task number
;------------------------------------------------------------------------------
message "RemoveFromTimeoutList"
RemoveFromTimeoutList:
	php
	phx
	push	r4
	push	r5
	sei

	ld		r4,TCB_Status,r1		; Is the task even on the timeout list ?
	bit		#TS_TIMEOUT
	beq		rftl5
	cmp		TimeoutList				; Are we removing the head of the list ?
	beq		rftl2
	ld		r4,TCB_PrvRdy,r1		; adjust the links of the next and previous
	bmi		rftl3					; no previous link - list corrupt?
	ld		r5,TCB_NxtRdy,r1		; tasks on the list to point around the task
	st		r5,TCB_NxtRdy,r4
	bmi		rftl3
	st		r4,TCB_PrvRdy,r5
	ldx		TCB_Timeout,r1			; update the timeout of the next on list
	add		r2,r2,TCB_Timeout,r5	; with any remaining timeout in the task
	stx		TCB_Timeout,r5			; removed from the list
	bra		rftl3

	; Update the head of the list.
rftl2:
	ld		r5,TCB_NxtRdy,r1
	st		r5,TimeoutList		; store next field into list head
	bmi		rftl3
	ld		r4,TCB_Timeout,r1		; add any remaining timeout to the timeout
	add		r4,r4,TCB_Timeout,r5	; of the next task on the list.
	st		r4,TCB_Timeout,r5
	ld		r4,#-1					; there is no previous item to the head
	sta		TCB_PrvRdy,r5
	
	; Here there is no previous or next items in the list, so the list
	; will be empty once this task is removed from it.
rftl3:
	stz		TCB_Status,r1		; set the task status to TS_NONE
	ldx		#-1					; make sure the next and prev fields indicate
	stx		TCB_NxtRdy,r1		; the task is not on a list.
	stx		TCB_PrvRdy,r1
rftl5:
	pop		r5
	pop		r4
	plx
	plp
	rts

;------------------------------------------------------------------------------
; Sleep
;
; Put the currently running task to sleep for a specified time.
;
; Registers Affected: none
; Parameters:
; r1 = time duration in centi-seconds (1/100 second).
;------------------------------------------------------------------------------
Sleep:
	php
	pha
	phx
	tax
	sei
	lda		RunningTCB
	jsr		RemoveTaskFromReadyList
	jsr		AddToTimeoutList	; The scheduler will be returning to this
	int		#2					; task eventually, once the timeout expires,
SleepRet:
	plx
	pla
	plp
	rts

;------------------------------------------------------------------------------
; KillTask
;
; "Kills" a task, removing it from all system lists. If the task has the 
; IO focus, the IO focus is switched. Task #0 is immortal and cannot be
; killed.
;
; Registers Affected: none
; Parameters:
;	r1 = task number
;------------------------------------------------------------------------------
;
KillTask:
	php
	phx
	cmp		#1							; BIOS task and IDLE task are immortal
	bls		kt1
	cmp		#MAX_TASKNO
	bhi		kt1
	sei
	jsr		ForceReleaseIOFocus
	jsr		RemoveTaskFromReadyList
	jsr		RemoveFromTimeoutList
	stz		TCB_Status,r1				; set task status to TS_NONE
	ldx		FreeTCB						; add the task control block to the free list
	stx		TCB_NxtTCB,r1
	sta		FreeTCB
	int		#2							; invoke scheduler to reschedule tasks
kt1:
	plx
	plp
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
	bmi		RunningTCBErr
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
ambx3:
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
	stz		TCB_Status,r5		; set task status = TS_NONE
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
	cmp		#2047					; check the mailbox number to make sure
	bhi		smsg1					; that it's sensible
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
	bit		r5,#TS_TIMEOUT
	beq		smsg8
	ld		r1,r6
	jsr		RemoveFromTimeoutList
smsg8:
	ld		r1,r6
	jsr		AddTaskToReadyList
	int		#2			; invoke the scheduler
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
	cmp		#2047					; check the mailbox number to make sure
	bhi		wmsg1					; that it's sensible
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
	cmp		r5,#MAX_TASKNO
	bhi		wmsg2					; error: no owner
	jsr		DequeueMsgFromMbx
	cmp		#0
	bpl		wmsg3

	; Here there was no message available, remove the task from
	; the ready list, and optionally add it to the timeout list.
	; Queue the task at the mailbox.
	lda		RunningTCB				; remove the task from the ready list
	jsr		RemoveTaskFromReadyList
	ld		r7,#TS_WAITMSG				; set task status to waiting
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
	int		#2			; invoke the scheduler
	
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
	cmp		#2047					; check the mailbox number to make sure
	bhi		cmsg1					; that it's sensible
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
	lda		MBX_MQ_HEAD,r1			; peek the message at the head of the messages queue
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
;------------------------------------------------------------------------------
comment ~
SetIOFocusBit:
	and		r2,r2,#$FF
	and		r1,r2,#$1F		; get bit index 0 to 31
	ldy		#1
	asl		r3,r3,r1		; shift bit to proper place
	lsr		r2,r2,#5		; get word index /32 bits per word
	lda		IOFocusTbl,x
	or		r1,r1,r3
	sta		IOFocusTbl,x
	rts
~
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
	cpx		#MAX_TASKNO
	bhi		riof1
	ldy		IOFocusNdx		; Is the focus list empty ?
	bmi		riof2
riof4:
	lda		TCB_iof_next,x	; is the task already in the IO focus list ?
	bpl		riof3
	lda		IOFocusNdx		; Expand the list
	ldy		TCB_iof_prev,r1
	stx		TCB_iof_prev,r1
	sta		TCB_iof_next,x
	sty		TCB_iof_prev,x
	stx		TCB_iof_next,y
riof3:
	txa
	bms		IOFocusTbl
;	jsr		SetIOFocusBit
riof1:
	plp
	ply
	plx
	pla
	rts

	; Here, the IO focus list was empty. So expand it.
	; Update pointers to loop back to self.
riof2:
	stx		IOFocusNdx
	stx		TCB_iof_next,x
	stx		TCB_iof_prev,x
	bra		riof3

;------------------------------------------------------------------------------
; Releasing the I/O focus causes the focus to switch if the running task
; had the I/O focus.
; ForceReleaseIOFocus forces the release of the IO focus for a task
; different than the one currently running.
;------------------------------------------------------------------------------
;
message "ForceReleaseIOFocus"
ForceReleaseIOFocus:
	php
	pha
	phx
	phy
	sei
	tax
	jmp		rliof4
message "ReleaseIOFocus"	
ReleaseIOFocus:
	php
	pha
	phx
	phy
	sei
	ldx		RunningTCB	
rliof4:
	cpx		#MAX_TASKNO
	bhi		rliof3
;	phx	
	ldy		#1
	txa
	bmt		IOFocusTbl
	beq		rliof3
	bmc		IOFocusTbl
comment ~
	and		r1,r2,#$1F		; get bit index 0 to 31
	asl		r3,r3,r1		; shift bit to proper place
	eor		r3,r3,#-1		; invert bit mask
	lsr		r2,r2,#5		; get word index /32 bits per word
	lda		IOFocusTbl,x
	and		r1,r1,r3
	sta		IOFocusTbl,x
~
;	plx
	cpx		IOFocusNdx		; Does the running task have the I/O focus ?
	bne		rliof1
	jsr		SwitchIOFocus	; If so, then switch the focus.
rliof1:
	lda		TCB_iof_next,x	; get next and previous fields.
	bmi		rliof2			; Is the task on the list ?
	ldy		TCB_iof_prev,x
	sta		TCB_iof_next,y	; prev->next = current->next
	sty		TCB_iof_prev,r1	; next->prev = current->prev
	cmp		r1,r3			; Check if the IO focus list is collapsing.
	bne		rliof2			; If the list just points back to the task
	cmp		r1,r2			; being removed, then it's the last task
	bne		rliof2			; removed from the list, so the list is being
	lda		#-1				; emptied.
	sta		IOFocusNdx
rliof2:
	lda		#-1				; Update the next and prev fields to indicate
	sta		TCB_iof_next,x	; the task is no longer on the list.
	sta		TCB_iof_prev,x
rliof3:
	ply
	plx
	pla
	plp
	rts

;------------------------------------------------------------------------------
; Get the location of the screen and screen attribute memory. The location
; depends on whether or not the task has the output focus.
;------------------------------------------------------------------------------
GetScreenLocation:
	lda		RunningTCB
	cmp		IOFocusNdx
	beq		gsl1
	and		r1,r1,#$FF
	asl		r1,r1,#13			; 8192 words per screen
	add		r1,r1,#BIOS_SCREENS
	rts
gsl1:
	lda		#TEXTSCR
	rts

GetColorCodeLocation:
	lda		RunningTCB
	cmp		IOFocusNdx
	beq		gccl1
	and		r1,r1,#$FF
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
	push	r4
	lda		#4095				; number of words to copy-1
	ldx		IOFocusNdx			; compute virtual screen location
	bmi		cvss3
	asl		r2,r2,#13			; 8192 words per screen
	add		r2,r2,#BIOS_SCREENS	; add in screens array base address
	ldy		#TEXTSCR
	mvn
;cvss1:
;	ld		r4,(x)
;	st		r4,(y)
;	inx
;	iny
;	dea
;	bne		cvss1
	; now copy the color codes
	lda		#4095
	ldx		IOFocusNdx
	asl		r2,r2,#13
	add		r2,r2,#BIOS_SCREENS+4096	; virtual char color array
	ldy		#TEXTSCR+$10000
	mvn
;cvss2:
;	ld		r4,(x)
;	st		r4,(y)
;	inx
;	iny
;	dea
;	bne		cvss2
cvss3:
	; reset the cursor position in the text controller
	ldy		IOFocusNdx
	ldx		TCB_CursorRow,y
	lda		TEXTREG+TEXT_COLS
	mul		r2,r2,r1
	add		r2,r2,TCB_CursorCol,y
	stx		TEXTREG+TEXT_CURPOS
	pop		r4
	ply
	plx
	pla
	rts
message "CopyScreenToVirtualScreen"
CopyScreenToVirtualScreen
	pha
	phx
	phy
	push	r4
	lda		#4095
	ldx		#TEXTSCR
	ldy		IOFocusNdx
	bmi		csvs3
	asl		r3,r3,#13
	add		r3,r3,#BIOS_SCREENS
	mvn
;csvs1:
;	ld		r4,(x)
;	st		r4,(y)
;	inx
;	iny
;	dea
;	bne		csvs1
	lda		#4095
	ldx		#TEXTSCR+$10000
	ldy		IOFocusNdx
	asl		r3,r3,#13
	add		r3,r3,#BIOS_SCREENS+4096
	mvn
;csvs2:
;	ld		r4,(x)
;	st		r4,(y)
;	inx
;	iny
;	dea
;	bne		csvs2
csvs3:
	pop		r4
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
	lda		TEXTREG+TEXT_COLS	; calc number to clear
	ldx		TEXTREG+TEXT_ROWS
	mul		r1,r1,r2			; r1 = # chars to clear
	pha
	jsr		GetScreenLocation
	tay							; y = target address
	lda		#' '				; space char
	jsr		AsciiToScreen
	tax							; x is value to store
	pla							; a is count
	pha
	stos						; clear the memory
	ld		r2,ScreenColor		; x = value to use
	jsr		GetColorCodeLocation
	tay							; y = targte address
	pla							; a = count
	stos
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
	and		r2,r2,#$FF
	stz		TCB_CursorRow,x
	stz		TCB_CursorCol,x
	cpx		IOFocusNdx
	bne		hc1
	stz		TEXTREG+TEXT_CURPOS
hc1:
	plx
	rts

;------------------------------------------------------------------------------
; Update the cursor position in the text controller based on the
;  CursorRow,CursorCol.
;------------------------------------------------------------------------------
;
UpdateCursorPos:
	pha
	phx
	push	r4
	ld		r4,RunningTCB
	and		r4,r4,#$FF
	cmp		r4,IOFocusNdx			; update cursor position in text controller
	bne		ucp1					; only for the task with the output focus
	lda		TCB_CursorRow,r4
	and		#$3F					; limit of 63 rows
	ldx		TEXTREG+TEXT_COLS
	mul		r2,r2,r1
	lda		TCB_CursorCol,r4
	and		#$7F					; limit of 127 cols
	add		r2,r2,r1
	stx		TEXTREG+TEXT_CURPOS
ucp1:
	pop		r4
	plx
	pla
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
	and		r4,r4,#$FF
	lda		TCB_CursorRow,r4
	and		#$3F					; limit to 63 rows
	ldx		TEXTREG+TEXT_COLS
	mul		r2,r2,r1
	ld		r1,TCB_CursorCol,r4
	and		#$7F					; limit to 127 cols
	add		r2,r2,r1
	cmp		r4,IOFocusNdx			; update cursor position in text controller
	bne		csl1					; only for the task with the output focus
	stx		TEXTREG+TEXT_CURPOS
csl1:
	jsr		GetScreenLocation
	add		r1,r2,r1
	pop		r4
	plx
	rts
csl2:
	lda		#TEXTSCR
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
	and		r4,r4,#$FF
	and		#$FF				; mask off any higher order bits (called from eight bit mode).
	cmp		#'\r'				; carriage return ?
	bne		dccr
	stz		TCB_CursorCol,r4	; just set cursor column to zero on a CR
	jsr		UpdateCursorPos
dcx14:
	pop		r4
	rts
dccr:
	cmp		#$91				; cursor right ?
	bne		dcx6
	pha
	lda		TCB_CursorCol,r4
	cmp		#55
	bcs		dcx7
	ina
	sta		TCB_CursorCol,r4
dcx7:
	jsr		UpdateCursorPos
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
	and		r4,r4,#$FF
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
	and		r4,r4,#$FF
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
	jsr		UpdateCursorPos
icc2:
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

DisplayStringQ:
	pha
	phx
	tax						; r2 = pointer to string
	lda		#TEXTSCR
	sta		QIndex
dspj1Q:
	lb		r1,0,x			; move string char into acc
	inx						; increment pointer
	cmp		#0				; is it end of string ?
	beq		dsretQ
	jsr		DisplayCharQ	; display character
	bra		dspj1Q
dsretQ:
	plx
	pla
	rts

DisplayCharQ:
	pha
	phx
	jsr		AsciiToScreen
	ldx		#0
	sta		(QIndex,x)
	lda		QIndex
	ina
	sta		QIndex
;	inc		QIndex
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
	lda		#32
	sta		LEDS
	ldx		#0

	lda		#MAX_TASKNO
	ldx		#0
	ldy		#KeybdHead
	stos
	lda		#MAX_TASKNO
	ldy		#KeybdTail
	stos
	lda		#MAX_TASKNO
	ldy		#KeybdBad
	stos
	lda		#MAX_TASKNO
	ldx		#1				; turn on keyboard echo
	ldy		#KeybdEcho
	stos
	
	lda		PIC_IE
	or		r1,r1,#$8000		; enable kbd_irq
	sta		PIC_IE

	lda		#33
	sta		LEDS
	lda		#$ff		; issue keyboard reset
	jsr		SendByteToKeybd
	lda		#38
	sta		LEDS
	lda		#1000000		; delay a bit
kbdi5:
	dea
	sta		LEDS
	bne		kbdi5
	lda		#34
	sta		LEDS
	lda		#0xf0		; send scan code select
	jsr		SendByteToKeybd
	lda		#35
	sta		LEDS
	ldx		#0xFA
	jsr		WaitForKeybdAck
	cmp		#$FA
	bne		kbdi2
	lda		#36
	sta		LEDS
	lda		#2			; select scan code set#2
	jsr		SendByteToKeybd
	lda		#39
	sta		LEDS
kbdi2:
	rts

msgBadKeybd:
	db		"Keyboard not responding.",0

SendByteToKeybd:
	phx
	ldx		RunningTCB
	sta		KEYBD
	lda		#40
	sta		LEDS
	tsr		TICK,r3
kbdi4:						; wait for transmit complete
	tsr		TICK,r4
	sub		r4,r4,r3
	cmp		r4,#1000000
	bcs		kbdbad
	lda		#41
	sta		LEDS
	lda		KEYBD+3
	bit		#64
	beq		kbdi4
	bra		sbtk1
kbdbad:
	lda		#42
	sta		LEDS
	lda		KeybdBad,x
	bne		sbtk1
	lda		#1
	sta		KeybdBad,x
	lda		#43
	sta		LEDS
	lda		#msgBadKeybd
	jsr		DisplayStringCRLFB
sbtk1:
	lda		#44
	sta		LEDS
	plx
	rts
	
; Wait for keyboard to respond with an ACK (FA)
;
WaitForKeybdAck:
	lda		#64
	sta		LEDS
	tsr		TICK,r3
wkbdack1:
	tsr		TICK,r4
	sub		r4,r4,r3
	cmp		r4,#1000000
	bcs		wkbdbad
	lda		#65
	sta		LEDS
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
; KeybdIRQ
;
; Normal keyboard interrupt, the lowest priority interrupt in the system.
; Grab the character from the keyboard device and store it in a buffer.
; The buffer of the task with the input focus is updated.
; This IRQ has to check for the ALT-tab character and take care of
; switching the IO focus if detected. It can't be done in the KeybdGetChar
; because the app with the IO focus may not call that routine. We know for
; sure the interrupt routine will be called when a key is pressed.
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
	lsr		r2,r1
	or		r1,r1,r2
	and		#$E0
	sb		r1,IrqBase		; save the new IRQ flag byte

	ld		r4,IOFocusNdx	; get the task with the input focus

	ldx		KEYBD				; get keyboard character
	ld		r0,KEYBD+1			; clear keyboard strobe (turns off the IRQ)
	txy							; check for a keyboard ACK code

	bit		r3,#$800				; test bit #11
	bne		KeybdIRQc				; ignore keyup messages for now
	bit		r3,#$200			; check for ALT-tab
	beq		KeybdIrq3
	and		r3,r3,#$FF
	cmp		r3,#TAB					; if we find an ALT-tab
	bne		KeybdIrq3
	jsr		SwitchIOFocus
	bra		KeybdIRQc				; don't store off the ALT-tab character
KeybdIrq3:
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

comment ~
;------------------------------------------------------------------------------
; Get a bit from the I/O focus table.
;------------------------------------------------------------------------------
GetIOFocusBit:
	phx
	phy
	tax
	and		r1,r1,#$1F		; get bit index into word
	lsr		r2,r2,#5		; get word index into table
	ldy		IOFocusTbl,x
	lsr		r3,r3,r1		; extract bit
	and		r1,r3,#1
	ply
	plx
	rts
~
;------------------------------------------------------------------------------
; ForceIOFocus
;
; Force the IO focus to a specific task.
;------------------------------------------------------------------------------
;
ForceIOFocus:
	php
	pha
	phy
	ldy		IOFocusNdx
	cmp		r1,r3
	beq		fif1
	jsr		CopyScreenToVirtualScreen
	sta		IOFocusNdx
	jsr		CopyVirtualScreenToScreen
fif1:
	ply
	pla
	plp
	rts
	
;------------------------------------------------------------------------------
; SwitchIOFocus
;
; Switches the IO focus to the next task requesting the I/O focus. This
; routine may be called when a task releases the I/O focus as well as when
; the user presses ALT-TAB on the keyboard.
;------------------------------------------------------------------------------
;
SwitchIOFocus:
	pha
	phy

	; First check if it's even possible to switch the focus to another
	; task. The I/O focus list could be empty or there may be only a
	; single task in the list. In either case it's not possible to
	; switch.
	ldy		IOFocusNdx		; Get the task at the head of the list.
	bmi		siof3			; Is the list empty ?
	lda		TCB_iof_next,y	; Get the next task on the list.
	cmp		r1,r3			; Will the list head change ?
	beq		siof3			; If not then no switch will occur
	
	; Copy the current task's screen to it's virtual screen buffer.
	jsr		CopyScreenToVirtualScreen

	sta		IOFocusNdx		; Make task the new head of list.

	; Copy the virtual screen of the task recieving the I/O focus to the
	; text screen.
	jsr		CopyVirtualScreenToScreen
siof3:
	ply
	pla
	rts
	
;------------------------------------------------------------------------------
; Get character from keyboard buffer
; return character in acc or -1 if no
; characters available.
; Also check for ALT-TAB and switch the I/O focus.
;------------------------------------------------------------------------------
message "KeybdGetChar"
KeybdGetChar:
	php
	phx
	push	r4
	sei
	ld		r4,RunningTCB
	cmp		r4,#MAX_TASKNO
	bhi		nochar
	ldx		KeybdTail,r4	; if keybdTail==keybdHead then there are no 
	lda		KeybdHead,r4	; characters in the keyboard buffer
	cmp		r1,r2
	beq		nochar
	asl		r4,r4,#4			; * 16
	phx
	add		r2,r2,r4
	lda		KeybdBuffer,x
	plx
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
	pop		r4
	plx
	plp
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
;	bit		#$200				; check for ALT-tab
;	bne		kgc2
;	and		r2,r1,#$7f
;	cmp		r2,#TAB					; if we find an ALT-tab
;	bne		kgc2
;	jsr		SwitchIOFocus
;	bra		kgc1
;kgc2:
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
	lda		#0					; turn off keyboard echo
	jsr		SetKeyboardEcho
	jsr		RequestIOFocus
PromptLn:
	jsr		CRLF
	lda		#'$'
	jsr		DisplayChar

; Get characters until a CR is keyed
;
Prompt3:
	jsr		RequestIOFocus
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
	lda		#80
	sta		LEDS
	ldx		RunningTCB
	cpx		#MAX_TASKNO
	bhi		Prompt3
	lda		#81
	sta		LEDS
	stz		TCB_CursorCol,x	; go back to the start of the line
	jsr		CalcScreenLoc	; r1 = screen memory location
	tay
	lda		#82
	sta		LEDS
	jsr		MonGetch
	cmp		#'$'
	bne		Prompt2			; skip over '$' prompt character
	lda		#83
	sta		LEDS
	jsr		MonGetch

; Dispatch based on command character
;
Prompt2:
	cmp		#':'
	beq		EditMem
	cmp		#'D'
	bne		Prompt8
	jsr		MonGetch
	cmp		#'R'
	beq		DumpReg
	cmp		#'I'
	beq		DoDir
	dey
	bra		DumpMem
Prompt8:
	cmp		#'F'
	bne		Prompt7
	jsr		MonGetch
	cmp		#'L'
	bne		Prompt8a
	jsr		DumpIOFocusList
	jmp		Monitor
Prompt8a:
	cmp		#'I'
	beq		DoFig
	cmp		#'M'
	beq		DoFmt
	dey
	bra		FillMem
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
	ldx		#$00000000		; flags: 
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
;	jsr		(y)
	jsr		StartTask
	jmp		Monitor
;	jmp		RandomLinesCall
Prompt12:
Prompt13:
	cmp		#'P'
	bne		Prompt14
	lda		#2
	ldx		#0
	ldy		#Piano
	jsr		StartTask
	jmp		Monitor

Prompt14:
	cmp		#'T'
	bne		Prompt15
	jsr		MonGetch
	cmp		#'O'
	bne		Prompt14a
	jsr		DumpTimeoutList
	jmp		Monitor
Prompt14a:
	cmp		#'I'
	bne		Prompt14b
	jsr		DisplayDatetime
	jmp		Monitor
Prompt14b:
	cmp		#'E'
	bne		Prompt14c
	jsr		ReadTemp
	jmp		Monitor
Prompt14c:
	dey
	jsr		DumpTaskList
	jmp		Monitor

Prompt15:
	cmp		#'S'
	bne		Prompt16
	jsr		MonGetch
	cmp		#'P'
	bne		Prompt18
	jsr		ignBlanks
	jsr		GetHexNumber
	sta		SPSave
	jmp		Monitor
Prompt18:
	dey
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
	lda		#1
	ldx		#0
	ldy		#eth_main
	jsr		StartTask
;	jsr		eth_main
	jmp		Monitor
Prompt17:
	cmp		#'R'
	bne		Prompt19
	jsr		MonGetch
	cmp		#'S'
	beq		LoadSector
	dey
	bra		SetRegValue
	jmp		Monitor
Prompt19:
	cmp		#'K'
	bne		Monitor
Prompt19a:
	jsr		MonGetch
	cmp		#' '
	bne		Prompt19a
	jsr		ignBlanks
	jsr		GetDecNumber
	jsr		KillTask
	jmp		Monitor

message "Prompt16"
RandomLinesCall:
;	jsr		RandomLines
	jmp		Monitor

MonGetch:
	lda		(y)
	iny
	jsr		ScreenToAscii
	rts

DoDir:
	jsr		do_dir
	jmp		Monitor
DoFmt:
	jsr		do_fmt
	jmp		Monitor
DoFig:
	lda		#3				; priority level 3
	ldy		#$A000			; start address $A000
	ldx		#$20000000		; flags: emmulation mode set
	jsr		StartTask
	bra		Monitor
	
TestCLS:
	jsr		MonGetch
	cmp		#'L'
	bne		Monitor
	jsr		MonGetch
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
	db  "FL = Dump I/O Focus List",CR,LF
;	db  "FIG = start FIG Forth",CR,LF
	db	"KILL n = kill task #n",CR,LF
	db	"B = start tiny basic",CR,LF
	db	"b = start EhBasic 6502",CR,LF
	db	"J = Jump to code",CR,LF
	db	"R[n] = Set register value",CR,LF
	db	"r = random lines - test bitmap",CR,LF
	db	"e = ethernet test",CR,LF
	db	"T = Dump task list",CR,LF
	db	"TO = Dump timeout list",CR,LF
	db	"TI = display date/time",CR,LF
	db	"TEMP = display temperature",CR,LF
	db	"P = Piano",CR,LF,0

;------------------------------------------------------------------------------
; Ignore blanks in the input
; r3 = text pointer
; r1 destroyed
;------------------------------------------------------------------------------
;
ignBlanks:
ignBlanks1:
	jsr		MonGetch
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
	st		r1,SPSave
	tsr		sp8,r1
	st		r1,SP8Save
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
	jsr		MonGetch
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
	jsr		MonGetch
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
	lda		#(1364*768)>>2		; a = # words to clear
	ldx		#0x29292929			; acc = color for four pixels
	ldy		#BITMAPSCR			; y = screen address
	stos
;cbsj4
;	sta		(y)					; store pixel data
;	iny							; advance screen address
;	dex							; decrement pixel count and loop back
;	bne		cbsj4
	ply
	plx
	pla
	rts

;==============================================================================
;==============================================================================
;--------------------------------------------------------------------------
; Setup the AC97/LM4550 audio controller. Check keyboard for a CTRL-C
; interrupt which may be necessary if the audio controller isn't 
; responding.
;--------------------------------------------------------------------------
;
SetupAC97:
	pha
	phx
	phy
	push	r4
	ld		r4,Milliseconds
sac974:
	stz		AC97+0x26		; trigger a read of register 26 (status reg)
sac971:						; wait for status to register 0xF (all ready)
	ld		r3,Milliseconds
	sub		r3,r3,r4
	cmp		r3,#1000
	bhi		sac97Abort
	jsr		KeybdGetChar	; see if we needed to CTRL-C
	cmp		#CTRLC
	beq		sac973
	lda		AC97+0x68		; wait for dirty bit to clear
	bne		sac971
	lda		AC97+0x26		; check status at reg h26, wait for
	and		#0x0F			; analogue to be ready
	cmp		#$0F
	bne		sac974
sac973:
	stz		AC97+2			; master volume, 0db attenuation, mute off
	stz		AC97+4			; headphone volume, 0db attenuation, mute off
	stz		AC97+0x18		; PCM gain (mixer) mute off, no attenuation
	stz		AC97+0x0A		; mute PC beep
	lda		#0x8000			; bypass 3D sound
	sta		AC97+0x20
	ld		r4,Milliseconds
sac972:
	ld		r3,Milliseconds
	sub		r3,r3,r4
	cmp		r3,#1000
	bhi		sac97Abort
	jsr		KeybdGetChar
	cmp		#CTRLC
	beq		sac975
	lda		AC97+0x68		; wait for dirty bits to clear
	bne		sac972			; wait a while for the settings to take effect
sac975:
	pop		r4
	ply
	plx
	pla
	rts
sac97Abort:
	lda		#msgAC97bad
	jsr		DisplayStringCRLFB
	pop		r4
	ply
	plx
	pla
	rts

msgAC97bad:
	db	"The AC97 controller is not responding.",CR,LF,0

;--------------------------------------------------------------------------
; Sound a 800 Hz beep
;--------------------------------------------------------------------------
;
Beep:
	lda		#15				; master volume to max
	sta		PSG+64
	lda		#13422			; 800Hz
	sta		PSGFREQ0
	; decay  (16.384 ms)2
	; attack (8.192 ms)1
	; release (1.024 s)A
	; sustain level C
	lda		#0xCA12
	sta		PSGADSR0
	lda		#0x1104			; gate, output enable, triangle waveform
	sta		PSGCTRL0
	lda		#100			; delay about 1s
	jsr		Sleep
	lda		#0x0104			; gate off, output enable, triangle waveform
	sta		PSGCTRL0
	lda		#100			; delay about 1s
	jsr		Sleep
	lda		#83
	sta		LEDS
	lda		#0x0000			; gate off, output enable off, no waveform
	sta		PSGCTRL0
	rts

;--------------------------------------------------------------------------
;--------------------------------------------------------------------------
; 
Piano:
	jsr		RequestIOFocus
	lda		#15				; master volume to max
	sta		PSG+64
playnt:
	jsr		KeybdGetChar
	cmp		#CTRLC
	beq		PianoX
	cmp		#'a'
	beq		playnt1a
	cmp		#'b'
	beq		playnt1b
	cmp		#'c'
	beq		playnt1c
	cmp		#'d'
	beq		playnt1d
	cmp		#'e'
	beq		playnt1e
	cmp		#'f'
	beq		playnt1f
	cmp		#'g'
	beq		playnt1g
	bra		playnt
PianoX:
	jsr		ReleaseIOFocus
	rts

playnt1a:
	lda		#7217
	jsr		Tone
	bra		playnt
playnt1b:
	lda		#8101
	jsr		Tone
	bra		playnt
playnt1c:
	lda		#4291
	jsr		Tone
	bra		playnt
playnt1d:
	lda		#4817
	jsr		Tone
	bra		playnt
playnt1e:
	lda		#5407
	jsr		Tone
	bra		playnt
playnt1f:
	lda		#5728
	jsr		Tone
	bra		playnt
playnt1g:
	lda		#6430
	jsr		Tone
	bra		playnt

Tone:
	pha
	sta		PSGFREQ0
	; decay  (16.384 ms)2
	; attack (8.192 ms)1
	; release (1.024 s)A
	; sustain level C
	lda		#0xCA12
	sta		PSGADSR0
	lda		#0x1104			; gate, output enable, triangle waveform
	sta		PSGCTRL0
	lda		#1				; delay about 10ms
	jsr		Sleep
	lda		#0x0104			; gate off, output enable, triangle waveform
	sta		PSGCTRL0
	lda		#1				; delay about 10ms
	jsr		Sleep
	lda		#0x0000			; gate off, output enable off, no waveform
	sta		PSGCTRL0
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
;	lda		#spi_init_ok_msg
;	jsr		DisplayStringB
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

; SPI read multiple sector
;
; r1= sector number to read
; r2= address to write data
; r3= number of sectors to read
;
; Returns:
; r1 = 0 if successful
;
spi_read_multiple:
	push	r4
	ld		r4,#0
spi_rm1:
	pha
	jsr		spi_read_sector
	add		r4,r4,r1
	add		r2,r2,#512
	pla
	ina
	dey
	bne		spi_rm1
	ld		r1,r4
	pop		r4
	rts

; SPI write multiple sector
;
; r1= sector number to write
; r2= address to get data from
; r3= number of sectors to write
;
; Returns:
; r1 = 0 if successful
;
spi_write_multiple:
	push	r4
	ld		r4,#0
spi_wm1:
	pha
	jsr		spi_write_sector
	add		r4,r4,r1		; accumulate an error count
	add		r2,r2,#512		; 512 bytes per sector
	pla
	ina
	dey
	bne		spi_wm1
	ld		r1,r4
	pop		r4
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
	lb		r1,BYTE_SECTOR_BUF+BSI_SecPerFAT+1			; sectors per FAT
	asl		r1,r1,#8
	orb		r1,r1,BYTE_SECTOR_BUF+BSI_SecPerFAT
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

do_fmt:
	jsr		spi_init
	cmp		#0
	bne		fmt_abrt
	ldx		#DIRBUF
	ldy		#65536
	; clear out the directory buffer
dfmt1:
	stz		(x)
	inx
	dey
	bne		dfmt1
	jsr		store_dir
fmt_abrt:
	rts

do_dir:
	jsr		CRLF
	jsr		spi_init
	cmp		#0
	bne		dirabrt
	jsr		load_dir
	ld		r4,#0			; r4 = entry counter
ddir3:
	asl		r3,r4,#6		; y = start of entry, 64 bytes per entry
	ldx		#32				; 32 chars in filename
ddir4:
	lb		r1,DIRBUF<<2,y
	beq		ddir2			; move to next dir entry if null is found
	cmp		#$20			; don't display control chars
	bmi		ddir1
	jsr		DisplayChar
	bra		ddir5
ddir1:
	lda		#' '
	jsr		DisplayChar
ddir5:
	iny
	dex
	bne		ddir4
	lda		#' '
	jsr		DisplayChar
	asl		r3,r4,#4		; y = start of entry, 16 words per entry
	lda		DIRBUF+$D,y
	ldx		#5
	jsr		PRTNUM
	jsr		CRLF
ddir2:
	jsr		KeybdGetChar
	cmp		#CTRLC
	beq		ddir6
	inc		r4
	cmp		r4,#512		; max 512 dir entries
	bne		ddir3
ddir6:

dirabrt:
	rts

load_dir:
	pha
	phx
	phy
	lda		#4000
	ldx		#DIRBUF<<2
	ldy		#64
	jsr		spi_read_multiple
	ply
	plx
	pla
	rts
store_dir:
	pha
	phx
	phy
	lda		#4000
	ldx		#DIRBUF<<2
	ldy		#64
	jsr		spi_write_multiple
	ply
	plx
	pla
	rts

; r1 = pointer to file name
; r2 = pointer to buffer to save
; r3 = length of buffer
;
do_save:
	pha
	jsr		spi_init
	cmp		#0
	bne		dsavErr
	pla
	jsr		load_dir
	ld		r4,#0
dsav4:
	asl		r5,r4,#6
	ld		r7,#0
	ld		r10,r1
dsav2:
	lb		r6,DIRBUF<<2,r5
	lb		r8,0,r10
	cmp		r6,r8
	bne		dsav1
	inc		r5
	inc		r7
	inc		r10
	cmp		r7,#32
	bne		dsav2
	; here the filename matched
dsav8:
	asl		r7,r4,#7	; compute file address	64k * entry #
	add		r7,r7,#5000	; start at sector 5,000
	ld		r1,r7		; r1 = sector number
	lsr		r3,r3,#9	; r3/512
	iny					; +1
	jsr		spi_write_multiple
dsav3:
	rts
	; Here the filename didn't match
dsav1:
	inc		r4
	cmp		r4,#512
	bne		dsav4
	; Here none of the filenames in the directory matched
	; Find an empty entry.
	ld		r4,#0
dsav6:
	asl		r5,r4,#6
	lb		r6,DIRBUF<<2,r5
	beq		dsav5
	inc		r4
	cmp		r4,#512
	bne		dsav6
	; Here there were no empty entries
	lda		#msgDiskFull
	jsr		DisplayStringB
	rts
dsav5:
	ld		r7,#32
	ld		r10,r1
dsav7:
	lb		r6,0,r10	; copy the filename into the directory entry
	sb		r6,DIRBUF<<2,r5
	inc		r5
	inc		r10
	dec		r7
	bne		dsav7
						; copy the file size into the directory entry
	asl		r5,r4,#4	; 16 words per dir entry
	sty		DIRBUF+$D,r5
	jsr		store_dir
	bra		dsav8
dsavErr:
	pla
	rts

msgDiskFull
	db	CR,LF,"The disk is full, unable to save file.",CR,LF,0

do_load:
	pha
	jsr		spi_init
	cmp		#0
	bne		dsavErr
	pla
	jsr		load_dir
	ld		r4,#0
dlod4:
	asl		r5,r4,#6
	ld		r7,#0
	ld		r10,r1
dlod2:
	lb		r6,DIRBUF<<2,r5
	lb		r8,0,r10
	cmp		r6,r8
	bne		dlod1
	inc		r5
	inc		r7
	inc		r10
	cmp		r7,#32
	bne		dlod2
	; here the filename matched
dlod8:
	asl		r5,r4,#4				; 16 words
	ld		r3,DIRBUF+$d,r5			; get file size into y register
	asl		r7,r4,#7	; compute file address	64k * entry #
	add		r7,r7,#5000	; start at sector 5,000
	ld		r1,r7		; r1 = sector number
	lsr		r3,r3,#9	; r3/512
	iny					; +1
	jsr		spi_read_multiple
dlod3:
	rts
	; Here the filename didn't match
dlod1:
	inc		r4
	cmp		r4,#512
	bne		dlod4
	; Here none of the filenames in the directory matched
	; 
	lda		#msgFileNotFound
	jsr		DisplayStringB
	rts

msgFileNotFound:
	db	CR,LF,"File not found.",CR,LF
	
;==============================================================================
; Ethernet
;==============================================================================
my_MAC1	EQU	0x00
my_MAC2	EQU	0xFF
my_MAC3	EQU	0xEE
my_MAC4	EQU	0xF0
my_MAC5	EQU	0xDA
my_MAC6	EQU	0x42

; r1 = PHY
; r2 = regnum
; r3 = data
;
eth_mii_write:
	pha
	phx
	push	r4
	ld		r4,#ETHMAC
	asl		r2,r2,#8
	or		r1,r1,r2
	sta		ETH_MIIADDRESS,r4
	sty		ETH_MIITX_DATA,r4
	lda		#ETH_WCTRLDATA
	sta		ETH_MIICOMMAND,r4
	stz		ETH_MIICOMMAND,r4
emiw1:
	lda		ETH_MIISTATUS,r4
	bit		#ETH_MIISTATUS_BUSY
	bne		emiw1
	pop		r4
	plx
	pla
	rts

; r1 = PHY
; r2 = reg

eth_mii_read:
	phx
	phy
	ldy		#ETHMAC
	asl		r2,r2,#8
	or		r1,r1,r2
	sta		ETH_MIIADDRESS,y	
	lda		#ETH_MIICOMMAND_RSTAT
	sta		ETH_MIICOMMAND,y
	stz		ETH_MIICOMMAND,y
emir1:
	lda		ETH_MIISTATUS,y
	bit		#ETH_MIISTATUS_BUSY
	bne		emir1	
	lda		ETH_MIIRX_DATA,y
	ply
	plx
	rts

ethmac_setup:
	ld		r4,#ETHMAC
	lda		#ETH_MIIMODER_RST
	sta		ETH_MIIMODER,r4
	lda		ETH_MIIMODER,r4
	and		#~ETH_MIIMODER_RST
	sta		ETH_MIIMODER,r4
	lda		#$10				; /16=1.25MHz
	sta		ETH_MIIMODER,r4		; Clock divider for MII Management interface 
	lda		#ETH_MODER_RST
	sta		ETH_MODER,r4
	lda		ETH_MODER,r4
	and		#~ETH_MODER_RST
	sta		ETH_MODER,r4

	stz		ETH_MIITX_DATA,r4
	stz		ETH_MIIADDRESS,r4
	stz		ETH_MIICOMMAND,r4
	
	lda		#0xEEF0DA42
	sta		ETH_MAC_ADDR0,r4		; MAC0
	lda		#0x00FF
	sta		ETH_MAC_ADDR1,r4		; MAC1

	lda		#-1
	sta		ETH_INT_SOURCE,r4

	; Advertise support for 10/100 FD/HD
	lda		#ETH_PHY
	ldx		#ETH_MII_ADVERTISE
	jsr		eth_mii_read
	or		r3,r1,#ETH_ADVERTISE_ALL
	lda		#ETH_PHY
	ldx		#ETH_MII_ADVERTISE
	jsr		eth_mii_write

	; Do NOT advertise support for 1000BT
	lda		#ETH_PHY
	ldx		#ETH_MII_CTRL1000
	jsr		eth_mii_read
	and		r3,r1,#~(ETH_ADVERTISE_1000FULL|ETH_ADVERTISE_1000HALF)
	lda		#ETH_PHY
	ldx		#ETH_MII_CTRL1000
	jsr		eth_mii_write
 
	; Disable 1000BT
	lda		#ETH_PHY
	ldx		#ETH_MII_EXPANSION
	jsr		eth_mii_read
	and		r3,r1,#~(ETH_ESTATUS_1000_THALF|ETH_ESTATUS_1000_TFULL)
	ldx		#ETH_MII_EXPANSION
	jsr		eth_mii_write
  
	; Restart autonegotiation
	lda		#0
	ldx		#ETH_MII_BMCR
	jsr		eth_mii_read
	and		r3,r1,#~(ETH_BMCR_ANRESTART|ETH_BMCR_ANENABLE)
	lda		#7
	jsr		eth_mii_write
	
	; Enable BOTH the transmiter and receiver
	lda		#$A003
	sta		ETH_MODER,r4
	rts
  
; Initialize the ethmac controller.
; Supply a MAC address, set MD clock
;
message "eth_init"
eth_init:
	pha
	phy
	ldy		#ETHMAC
	lda		#$A003
	sta		ETH_MODER,y
;	lda		#0x64				; 100
;	sta		ETH_MIIMODER,y
;	lda		#7					; PHY address
;	sta		ETH_MIIADDRESS,y
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
	bit		r2,#4				; get bit #2
	beq		eth1
	ldx		0x180,y				; get from descriptor
	lsr		r2,r2,#16
	ldy		#0
	pha
	jsr		GetScreenLocation
	add		r4,r1,3780			; second last line of screen
	pla
eth20:
	add		r5,r1,r3
	lb		r2,0,r5				; get byte
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
	bit		r4,#$8000
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

msgEthTest
	db		CR,LF,"Ethernet test - press CTRL-C to exit.",CR,LF,0

message "eth_main"
eth_main:
	jsr		RequestIOFocus
	jsr		ClearScreen
	jsr		HomeCursor
	lda		#msgEthTest
	jsr		DisplayStringB
;	jsr		eth_init
	jsr		ethmac_setup
eth_loop:
	jsr		KeybdGetChar
	cmp		#-1
	beq		eth17
	cmp		#CTRLC
	bne		eth17
	lda		#$A000					; tunr off transmit/recieve
	sta		ETH_MODER+ETHMAC
	jsr		ReleaseIOFocus
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
message "RandomizeSprram"
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
message "RandomLines"
RandomLines:
	pha
	phx
	phy
	push	r4
	push	r5
	jsr		RequestIOFocus
	jsr		ClearScreen
	jsr		HomeCursor
	lda		#msgRandomLines
	jsr		DisplayStringB
rl5:
	tsr		LFSR,r1
	tsr		LFSR,r2
	tsr		LFSR,r3
	mod		r1,r1,#1364
	mod		r2,r2,#768
	jsr		DrawPixel
	tsr		LFSR,r1
	sta		LineColor		; select a random color
rl1:						; random X0
	tsr		LFSR,r1
	mod		r1,r1,#1364
rl2:						; random X1
	tsr		LFSR,r3
	mod		r3,r3,#1364
rl3:						; random Y0
	tsr		LFSR,r2
	mod		r2,r2,#768
rl4:						; random Y1
	tsr		LFSR,r4
	mod		r4,r4,#768
rl8:
	ld		r5,GA_STATE		; make sure state is IDLE
	bne		rl8
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

msgRandomLines:
	db		CR,LF,"Random lines running - press CTRL-C to exit.",CR,LF,0

;--------------------------------------------------------------------------
; Draw a pixel on the bitmap screen.
; r1 = x coordinate
; r2 = y coordinate
; r3 = color
;--------------------------------------------------------------------------
message "DrawPixel"
DrawPixel:
	pha
	sta		GA_X0
	stx		GA_Y0
	sty		GA_PEN
	lda		#1
	sta		GA_CMD
	pla
	rts

comment ~	
	pha
	phx
	push	r4
	mod		r2,r2,#768
	mod		r1,r1,#1364
	mul		r2,r2,#1364	; y * 1364
	add		r1,r1,r2	; + x
	sb		r3,BITMAPSCR<<2,r1
	pop		r4
	plx
	pla
	rts
~

;--------------------------------------------------------------------------
; Draw a line on the bitmap screen.
;--------------------------------------------------------------------------
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

message "DrawLine"
DrawLine:
	pha
	sta		GA_X0
	stx		GA_Y0
	sty		GA_X1
	st		r4,GA_Y1
	lda		LineColor
	sta		GA_PEN
	lda		#2
	sta		GA_CMD
	pla
	rts

comment ~
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
	phy
	ldy		LineColor
	jsr		DrawPixel
	ply
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
~

;include "float.asm"

;--------------------------------------------------------------------------
; RTF65002 code to display the date and time from the date/time device.
;--------------------------------------------------------------------------
DisplayDatetime
	pha
	phx
	lda		#' '
	jsr		DisplayChar
	stz		DATETIME_SNAPSHOT	; take a snapshot of the running date/time
	lda		DATETIME_DATE
	tax
	lsr		r1,r1,#16
	jsr		DisplayHalf		; display the year
	lda		#'/'
	jsr		DisplayChar
	txa
	lsr		r1,r1,#8
	and		#$FF
	jsr		DisplayByte		; display the month
	lda		#'/'
	jsr		DisplayChar
	txa
	and		#$FF
	jsr		DisplayByte		; display the day
	lda		#' '
	jsr		DisplayChar
	lda		#' '
	jsr		DisplayChar
	lda		DATETIME_TIME
	tax
	lsr		r1,r1,#24
	jsr		DisplayByte		; display hours
	lda		#':'
	jsr		DisplayChar
	txa
	lsr		r1,r1,#16
	jsr		DisplayByte		; display minutes
	lda		#':'
	jsr		DisplayChar
	txa
	lsr		r1,r1,#8
	jsr		DisplayByte		; display seconds
	lda		#'.'
	jsr		DisplayChar
	txa
	jsr		DisplayByte		; display 100ths seconds
	jsr		CRLF
	plx
	pla
	rts

;--------------------------------------------------------------------------
; ReadTemp
;    Read and display the temperature from a DS1626 temperature sensor
; device. RTF65002 source code.
;--------------------------------------------------------------------------
DS1626_CMD	=$FFDC0300
DS1626_DAT	=$FFDC0301
; Commands
START_CNV = $51;
STOP_CNV = $22;
READ_TEMP = $AA;
READ_CONFIG = $AC;
READ_TH = $A1;
READ_TL = $A2;
WRITE_TH = $01;
WRITE_TL = $02;
WRITE_CONFIG = $0C;
POR = $54;

ReadTemp:
	lda		CONFIGREC	; Do we even have a temperature sensor ?
	bit		#$10
	beq		rdtmp3		; If not, output '0.000'
rdtmp1:
	; On power up the DS1626 interface circuit sends a power on reset (POR)
	; command to the DS1626. Waiting here makes sure this command has been
	; completed.
	jsr		rdt_busy_wait
	lda		#$0F			; 12 bits resolution, cpu mode, one-shot mode
	sta		DS1626_DAT
	lda		#WRITE_CONFIG	; write the desired config to the device
	sta		DS1626_CMD
	jsr		rdt_busy_wait
	lda		#10
	jsr		tSleep
	lda		#0
	sta		DS1626_DAT
	lda		#START_CNV		; issue a start conversion command
	sta		DS1626_CMD
	jsr		rdt_busy_wait
	lda		#10
	jsr		tSleep
	; Now poll the config register to determine when the conversion has completed.
rdtmp2:
	lda		#READ_CONFIG	; issue the READ_CONFIG command
	sta		DS1626_CMD
	jsr		rdt_busy_wait
	pha
	lda		#10				; Wait a bit before checking again. The conversion
	jsr		tSleep			; can take up to 1s to complete.
	pla
	bit		#$80			; test done bit
	beq		rdtmp2			; loop back if not done conversion
	lda		#0
	sta		DS1626_DAT		; issue a stop conversion command
	lda		#STOP_CNV
	sta		DS1626_CMD
	jsr		rdt_busy_wait
	lda		#10
	jsr		tSleep
	lda		#READ_TEMP		; issue the READ_TEMP command
	sta		DS1626_CMD
	jsr		rdt_busy_wait
	pha
	lda		#10
	jsr		tSleep
	pla
rdtmp4:
	jsr		CRLF
	and		#$FFF
	bit		#$800		; check for negative temperature
	beq		rdtmp7
	sub		r1,r0,r1	; negate the number
	and		#$FFF
	pha
	lda		#'-'		; output a minus sign
	jsr		DisplayChar
	pla
rdtmp7:
	pha					; save off value
	lsr		r1,r1,#4	; get rid of fractional portion
	and		#$7F		; strip off sign bit
	ldx		#3			; output the whole number part
	jsr		PRTNUM
	lda		#'.'		; followed by a decimal point
	jsr		DisplayChar
	pla					; get back temp value
	and		#$0F
	mul		r1,r1,#625	; 1/16th's per degree
	pha					; save off fraction bits
	div		r1,r1,#100	; calculate the first digit
	add		#'0'
	jsr		DisplayChar	; output digit
	pla					; get back fractions bits
	pha					; and save again
	div		r1,r1,#10	; shift over to second digit
	mod		r1,r1,#10	; ignore high order bits
	add		#'0'
	jsr		DisplayChar	; display the digit
	pla					; get back fraction
	mod		r1,r1,#10	; compute low order digit
	add		#'0'
	jsr		DisplayChar	; display low order digit
	jsr		CRLF
	rts
rdtmp3:
	lda		#0
	bra		rdtmp4

; Returns:
;	acc = value from data register
;
rdt_busy_wait:
	jsr		KeybdGetChar
	cmp		#CTRLC
	beq		Monitor
	lda		DS1626_DAT
	bit		#$8000
	bne		rdt_busy_wait
	rts

tSleep:
	ldx		Milliseconds
	txa
tSleep1:
	ldx		Milliseconds
	sub		r2,r2,r1
	cpx		#100
	blo		tSleep1
	rts

;==============================================================================
; Memory Management routines follow.
;==============================================================================
MemInit:
	lda		#1					; initialize memory semaphore
	sta		MEM_SEMA
	lda		#$4D454D20
	sta		HeapStart+MEM_CHK
	sta		HeapStart+MEM_FLAG
	sta		HeapEnd-2
	sta		HeapEnd-3
	lda		#0
	sta		HeapStart+MEM_PREV	; prev of first MEMHDR
	sta		HeapEnd			; next of last MEMHDR
	lda		#HeapEnd
	ina
	sub		#$4
	sta		HeapStart+MEM_NEXT	; next of first MEMHDR
	lda		#HeapStart
	sta		HeapEnd-1		; prev of last MEMHDR
	rts

ReportMemFree:
	jsr		CRLF
	lda		#HeapEnd
	ina
	sub		#HeapStart
	ldx		#5
	jsr		PRTNUM
	lda		#msgMemFree
	jsr		DisplayStringB
	rts

msgMemFree:
	db	" words free",CR,LF,0
	
;------------------------------------------------------------------------------
; Allocate memory from the heap.
;------------------------------------------------------------------------------
MemAlloc:
	phx
	phy
	push	r4
memaSpin:
	ldx		MEM_SEMA+1
	beq		memaSpin
	ldx		#HeapStart
mema4:
	ldy		MEM_FLAG,x		; Check the flag word to see if this block is available
	cpy		#$4D454D20
	bne		mema1			; block not available, go to next block
	ld		r4,MEM_NEXT,x	; compute the size of this block
	sub		r4,r4,r2
	sub		r4,r4,#4		; minus size of block header
	cmp		r1,r4			; is the block large enough ?
	bmi		mema2			; if yes, go allocate
mema1:
	ldx		MEM_NEXT,x		; go to the next block
	beq		mema3			; if no more blocks, out of memory error
	bra		mema4
mema2:
	ldy		#$6D656D20
	sty		MEM_FLAG,x
	sub		r4,r4,r1
	cmp		r4,#4			; is the block large enough to split
	bpl		memaSplit
	stz		MEM_SEMA+1
	txa
	pop		r4
	ply
	plx
	rts
mema3:						; insufficient memory
	stz		MEM_SEMA+1
	pop		r4
	ply
	plx
	lda		#0
	rts
memaSplit:
	add		r4,r1,r2
	add		r4,r4,#4
	ldy		#$4D454D20
	sty		(r4)
	sty		MEM_FLAG,r4
	stx		MEM_PREV,r4
	ldy		MEM_NEXT,x
	sty		MEM_NEXT,r4
	st		r4,MEM_PREV,y
	ld		r1,r4
	stz		MEM_SEMA+1
	pop		r4
	ply
	plx
	rts

;------------------------------------------------------------------------------
; Free previously allocated memory. Recombine with next and previous blocks
; if they are free as well.
;------------------------------------------------------------------------------
MemFree:
	cmp		#0			; null pointer ?
	beq		memf2
	phx
	phy
memfSpin:
	ldx		MEM_SEMA+1
	beq		memfSpin
	ldx		MEM_FLAG,r1
	cpx		#$6D656D20	; is the block allocated ?
	bne		memf1
	ldx		#$4D454D20
	stx		MEM_FLAG,r1	; mark block as free
	ldx		MEM_PREV,r1	; is the previous block free ?
	beq		memf3		; no previous block
	ldy		MEM_FLAG,x
	cpy		#$4D454D20
	bne		memf3		; the previous block is not free
	ldy		MEM_NEXT,r1
	sty		MEM_NEXT,x
	beq		memf1		; no next block
	stx		MEM_PREV,y
memf3:
	ldy		MEM_NEXT,r1
	ldx		MEM_FLAG,y
	cpx		#$4D454D20
	bne		memf1		; next block not free
	ldx		MEM_PREV,r1
	stx		MEM_PREV,y
	beq		memf1		; no previous block
	sty		MEM_NEXT,x
memf1:
	stz		MEM_SEMA+1
	ply
	plx
memf2:
	rts

;------------------------------------------------------------------------------
; Bus Error Routine
; This routine display a message then restarts the BIOS.
;------------------------------------------------------------------------------
;
message "bus_err_rout"
bus_err_rout:
	cld
	ldx		#87
	stx		LEDS
	pla							; get rid of the stacked flags
	ply							; get the error PC
	ldx		#$05FFFFF8			; setup stack pointer top of memory
	txs
	ldx		#88
	stx		LEDS
	jsr		CRLF
	stz		RunningTCB
	stz		IOFocusNdx
	lda		#msgBusErr
	jsr		DisplayStringB
	tya
	jsr		DisplayWord			; display the originating PC address
	lda		#msgDataAddr
	jsr		DisplayStringB
	tsr		#9,r1
	jsr		DisplayWord
	ldx		#89
	stx		LEDS
	ldx		#128
ber2:
	lda		#' '
	jsr		DisplayChar
	tsr		hist,r1
	jsr		DisplayWord
	dex
	bne		ber2
	jsr		CRLF
ber3:
	nop
	jmp		ber3
	;cli							; enable interrupts so we can get a char
ber1:
	jsr		KeybdGetCharDirect	; Don't use the keyboard buffer
	cmp		#-1
	beq		ber1
	lda		RunningTCB
	jsr		KillTask
	jmp		SelectTaskToRun
	
msgBusErr:
	db		"Bus error at: ",0
msgDataAddr:
	db		" data address: ",0


;------------------------------------------------------------------------------
; Reschedule tasks to run without affecting the timeout list timing.
;------------------------------------------------------------------------------
;
reschedule:
	cld		; clear extended precision mode

	pusha	; save off regs on the stack

	ldx		RunningTCB
	tsa						; save off the stack pointer
	sta		TCB_SPSave,x
	tsr		sp8,r1			; and the eight bit mode stack pointer
	sta		TCB_SP8Save,x
	tsr		abs8,r1
	sta		TCB_ABS8Save,x	; 8 bit emulation base register
	jmp		SelectTaskToRun
	
strStartQue:
	db		1,0,0,0,2,0,0,0,3,0,1,0,4,0,0,0
;	db		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

;------------------------------------------------------------------------------
; 100 Hz interrupt
; - takes care of "flashing" the cursor
; - decrements timeouts for tasks on timeout list
; - switching tasks
;------------------------------------------------------------------------------
;
p100Hz:
	; Handle every other interrupt because 100Hz interrupts may be too fast.
	pha
	lda		#3				; reset the edge sense circuit
	sta		PIC_RSTE
	lda		IRQFlag
	ina
	sta		IRQFlag
	ror
	pla
	bcc		p100Hz11	
	rti

p100Hz11:

	cld		; clear extended precision mode

	pusha	; save off regs on the stack

	ldx		RunningTCB
	tsa						; save off the stack pointer
	sta		TCB_SPSave,x
	tsr		sp8,r1			; and the eight bit mode stack pointer
	sta		TCB_SP8Save,x
	tsr		abs8,r1
	sta		TCB_ABS8Save,x	; 8 bit emulation base register
	lda		#TS_READY
	sta		TCB_Status,x
p100Hz4:

	; support EhBASIC's IRQ functionality
	; code derived from minimon.asm
	lda		#3				; Timer is IRQ #3
	sta		IrqSource		; stuff a byte indicating the IRQ source for PEEK()
	lb		r1,IrqBase		; get the IRQ flag byte
	lsr		r4,r1
	or		r1,r1,r4
	and		#$E0
	sb		r1,IrqBase

	inc		TEXTSCR+55		; update IRQ live indicator on screen
	
	; flash the cursor
	cpx		IOFocusNdx		; only bother to flash the cursor for the task with the IO focus.
	bne		p100Hz1a
	lda		CursorFlash		; test if we want a flashing cursor
	beq		p100Hz1a
	jsr		CalcScreenLoc	; compute cursor location in memory
	tay
	lda		$10000,y		; get color code $10000 higher in memory
	ld		r4,IRQFlag		; get counter
	lsr		r4,r4
	and		r4,r4,#$0F		; limit to low order nybble
	and		#$F0			; prepare to or in new value, mask off foreground color
	or		r1,r1,r4		; set new foreground color for cursor
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
									; there could be a string of tasks to make ready.
p100Hz14:
	dea								; decrement the entry's timeout
	sta		TCB_Timeout,x
	
p100Hz12:
	; Falls through into selecting a task to run

;------------------------------------------------------------------------------
; Search the ready queues for a ready task.
; The search is occasionally started at a lower priority queue in order
; to prevent starvation of lower priority tasks. This is managed by 
; using a tick count as an index to a string containing the start que.
;------------------------------------------------------------------------------
;
SelectTaskToRun:
	ld		r6,#5			; number of queues to search
	ldy		IRQFlag			; use the IRQFlag as a buffer index
	lsr		r3,r3,#1		; the LSB is always the same
	and		r3,r3,#$0F		; counts from 0 to 15
	lb		r3,strStartQue,y	; get the queue to start search at
sttr2:
	lda		QNdx0,y
	bmi		sttr1
	lda		TCB_NxtRdy,r1		; Advance the queue index
	sta		QNdx0,y
	; This is the only place the RunningTCB is set (except for initialization).
	sta		RunningTCB
	ldx		#TS_RUNNING			; flag the task as the running task
	stx		TCB_Status,r1
	; The mmu map better have the task control block area mapped
	; properly.
	tax
	lda		CONFIGREC
	bit		#4096
	beq		sttr4
	lda		TCB_mmu_map,x
	sta		MMU_OKEY			; select the mmu map for the task
	lda		#2
	sta		MMU_FUSE			; set fuse to 2 clocks before mapping starts
sttr4:
	lda		TCB_ABS8Save,x		; 8 bit emulation base register
	trs		r0,abs8
	lda		TCB_SP8Save,x		; get back eight bit stack pointer
	trs		r1,sp8
	ldx		TCB_SPSave,x		; get back stack pointer
	txs
	popa						; restore registers
	rti

	; Set index to check the next ready list for a task to run
sttr1:
	iny
	cpy		#5
	bne		sttr5
	ldy		#0
sttr5
	dec		r6
	bne		sttr2

	; Here there were no tasks ready
	; This should not be able to happen, so hang the machine.
sttr3:
	ldx		#94
	stx		LEDS
	bra		sttr3

;------------------------------------------------------------------------------
; 1000 Hz interrupt
; This IRQ must be fast.
; Increments the millisecond counter
;------------------------------------------------------------------------------
;
p1000Hz:
	pha
	lda		#2						; reset edge sense circuit
	sta		PIC_RSTE
	inc		Milliseconds			; increment milliseconds count
	pla
	rti

;------------------------------------------------------------------------------
; Sleep interrupt
; This interrupt just selects another task to run. The current task is
; stuck in an infinite loop.
;------------------------------------------------------------------------------
slp_rout:
	cld		; clear extended precision mode
	pusha
	lda		RunningTCB
	cmp		#MAX_TASKNO
	bhi		slp1
	jsr		RemoveTaskFromReadyList
	tax
	tsa						; save off the stack pointer
	sta		TCB_SPSave,x
	tsr		sp8,r1			; and the eight bit mode stack pointer
	sta		TCB_SP8Save,x
	tsr		abs8,r1
	sta		TCB_ABS8Save,x
	lda		#TS_SLEEP		; set the task status to SLEEP
	sta		TCB_Status,x
slp1:
	jmp		SelectTaskToRun

;------------------------------------------------------------------------------
; Check for and emulate unsupoorted instructions.
;------------------------------------------------------------------------------
InvalidOpIRQ:
	pha
	phx
	phy
	tsx
	lda		4,x		; get the address of the invalid op off the stack
	lb		r3,0,r1	; get the opcode byte
	cpy		#$44	; is it MVP ?
	beq		EmuMVP
	cpy		#$54	; is it MVN ?
	beq		EmuMVN
	; We don't know what the op is. Treat it like a NOP
	; Increment the address and return.
	pha
	lda		#msgUnimp
	jsr		DisplayStringB
	pla
	jsr		DisplayWord
	jsr		CRLF
	ina
	sta		4,x		; save incremented return address back to stack
	ldx		#64
ioi1:
	tsr		hist,r1
	jsr		DisplayWord
	lda		#' '
	jsr		DisplayChar
	dex
	bne		ioi1
	jsr		CRLF
	ply
	plx
	pla
	rti

EmuMVP:
	push	r4
	push	r5
	tsr		sp,r4
	lda		4,r4
	ldx		3,r4
	ldy		2,r4
EmuMVP1:
	ld		r5,(x)
	st		r5,(y)
	dex
	dey
	dea
	cmp		#$FFFFFFFF
	bne		EmuMVP1
	sta		4,r4
	stx		3,r4
	sty		2,r4
	inc		6,r4		; increment the return address by one.
	pop		r5
	pop		r4
	ply
	plx
	pla
	rti

EmuMVN:
	push	r4
	push	r5
	tsr		sp,r4
	lda		4,r4
	ldx		3,r4
	ldy		2,r4
EmuMVN1:
	ld		r5,(x)
	st		r5,(y)
	inx
	iny
	dea
	cmp		#$FFFFFFFF
	bne		EmuMVN1
	sta		4,r4
	stx		3,r4
	sty		2,r4
	inc		6,r4		; increment the return address by one.
	pop		r5
	pop		r4
	ply
	plx
	pla
	rti

msgUnimp:
	db	"Unimplemented at: ",0

brk_rout:
	rti
nmirout:
	pha
	phx
	lda		#msgPerr
	jsr		DisplayStringB
	tsx
	lda		4,x
	jsr		DisplayWord
	jsr		CRLF
	plx
	pla
	rti

msgPerr:
	db	"Parity error at: ",0

message "1298"
include "TinyBasic65002.asm"
message "1640"
	org $0FFFFFFF4		; NMI vector
	dw	nmirout

	org	$0FFFFFFF8		; reset vector, native mode
	dw	start
	
	end
	