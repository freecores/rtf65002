`timescale 1ns / 1ps
// ============================================================================
//        __
//   \\__/ o\    (C) 2013  Robert Finch, Stratford
//    \  __ /    All rights reserved.
//     \/_//     robfinch<remove>@opencores.org
//       ||
//
// rtf65002.v
//  - 32 bit CPU
//
// This source file is free software: you can redistribute it and/or modify 
// it under the terms of the GNU Lesser General Public License as published 
// by the Free Software Foundation, either version 3 of the License, or     
// (at your option) any later version.                                      
//                                                                          
// This source file is distributed in the hope that it will be useful,      
// but WITHOUT ANY WARRANTY; without even the implied warranty of           
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            
// GNU General Public License for more details.                             
//                                                                          
// You should have received a copy of the GNU General Public License        
// along with this program.  If not, see <http://www.gnu.org/licenses/>.    
//                                                                          
// ============================================================================
//
`define TRUE		1'b1
`define FALSE		1'b0

//`define SUPPORT_ICACHE	1'b1
`define SUPPORT_DCACHE	1'b1
`define SUPPORT_BCD		1'b1
`define SUPPORT_DIVMOD		1'b1
//`define SUPPORT_EM8		1'b1
//`define SUPPORT_BYTE_IRQ	1'b1
`define SUPPORT_EXEC	1'b1
`define SUPPORT_BERR	1'b1
`define SUPPORT_STRING	1'b1
`define SUPPORT_SHIFT	1'b1

`define RST_VECT	34'h3FFFFFFF8
`define NMI_VECT	34'h3FFFFFFF4
`define IRQ_VECT	34'h3FFFFFFF0
`define BRK_VECTNO	9'd0
`define SLP_VECTNO	9'd1
`define BYTE_RST_VECT	34'h00000FFFC
`define BYTE_NMI_VECT	34'h00000FFFA
`define BYTE_IRQ_VECT	34'h00000FFFE

`define BRK			8'h00
`define RTI			8'h40
`define RTS			8'h60
`define PHP			8'h08
`define CLC			8'h18
`define PLP			8'h28
`define SEC			8'h38
`define PHA			8'h48
`define CLI			8'h58
`define PLA			8'h68
`define SEI			8'h78
`define DEY			8'h88
`define TYA			8'h98
`define TAY			8'hA8
`define CLV			8'hB8
`define INY			8'hC8
`define CLD			8'hD8
`define INX			8'hE8
`define SED			8'hF8
`define ROR_ACC		8'h6A
`define TXA			8'h8A
`define TXS			8'h9A
`define TAX			8'hAA
`define TSX			8'hBA
`define DEX			8'hCA
`define NOP			8'hEA
`define TXY			8'h9B
`define TYX			8'hBB
`define TAS			8'h1B
`define TSA			8'h3B
`define TRS			8'h8B
`define TSR			8'hAB
`define STP			8'hDB
`define NAT			8'hFB
`define EMM			8'hFB
`define INA			8'h1A
`define DEA			8'h3A

`define RR			8'h02
`define ADD_RR			4'd0
`define SUB_RR			4'd1
`define CMP_RR			4'd2
`define AND_RR			4'd3
`define EOR_RR			4'd4
`define OR_RR			4'd5
`define MUL_RR			4'd8
`define MULS_RR			4'd9
`define DIV_RR			4'd10
`define DIVS_RR			4'd11
`define MOD_RR			4'd12
`define MODS_RR			4'd13
`define ASL_RRR			4'd14
`define LSR_RRR			4'd15
`define LD_RR		8'h7B

`define ADD_IMM8	8'h65		// 8 bit operand
`define ADD_IMM16	8'h79		// 16 bit operand
`define ADD_IMM32	8'h69		// 32 bit operand
`define ADD_ZPX		8'h75		// there is no ZP mode, use R0 to syntheisze
`define ADD_IX		8'h61
`define ADD_IY		8'h71
`define ADD_ABS		8'h6D
`define ADD_ABSX	8'h7D
`define ADD_RIND	8'h72
`define ADD_DSP		8'h63

`define SUB_IMM8	8'hE5
`define SUB_IMM16	8'hF9
`define SUB_IMM32	8'hE9
`define SUB_ZPX		8'hF5
`define SUB_IX		8'hE1
`define SUB_IY		8'hF1
`define SUB_ABS		8'hED
`define SUB_ABSX	8'hFD
`define SUB_RIND	8'hF2
`define SUB_DSP		8'hE3

// CMP = SUB r0,....

`define ADC_IMM		8'h69
`define ADC_ZP		8'h65
`define ADC_ZPX		8'h75
`define ADC_IX		8'h61
`define ADC_IY		8'h71
`define ADC_ABS		8'h6D
`define ADC_ABSX	8'h7D
`define ADC_ABSY	8'h79
`define ADC_I		8'h72

`define SBC_IMM		8'hE9
`define SBC_ZP		8'hE5
`define SBC_ZPX		8'hF5
`define SBC_IX		8'hE1
`define SBC_IY		8'hF1
`define SBC_ABS		8'hED
`define SBC_ABSX	8'hFD
`define SBC_ABSY	8'hF9
`define SBC_I		8'hF2

`define CMP_IMM8	8'hC5
`define CMP_IMM32	8'hC9
`define CMP_IMM		8'hC9
`define CMP_ZP		8'hC5
`define CMP_ZPX		8'hD5
`define CMP_IX		8'hC1
`define CMP_IY		8'hD1
`define CMP_ABS		8'hCD
`define CMP_ABSX	8'hDD
`define CMP_ABSY	8'hD9
`define CMP_I		8'hD2


`define LDA_IMM8	8'hA5
`define LDA_IMM16	8'hB9
`define LDA_IMM32	8'hA9

`define AND_IMM8	8'h25
`define AND_IMM16	8'h39
`define AND_IMM32	8'h29
`define AND_IMM		8'h29
`define AND_ZP		8'h25
`define AND_ZPX		8'h35
`define AND_IX		8'h21
`define AND_IY		8'h31
`define AND_ABS		8'h2D
`define AND_ABSX	8'h3D
`define AND_ABSY	8'h39
`define AND_RIND	8'h32
`define AND_I		8'h32
`define AND_DSP		8'h23

`define OR_IMM8		8'h05
`define OR_IMM16	8'h19
`define OR_IMM32	8'h09
`define OR_ZPX		8'h15
`define OR_IX		8'h01
`define OR_IY		8'h11
`define OR_ABS		8'h0D
`define OR_ABSX		8'h1D
`define OR_RIND		8'h12
`define OR_DSP		8'h03

`define ORA_IMM		8'h09
`define ORA_ZP		8'h05
`define ORA_ZPX		8'h15
`define ORA_IX		8'h01
`define ORA_IY		8'h11
`define ORA_ABS		8'h0D
`define ORA_ABSX	8'h1D
`define ORA_ABSY	8'h19
`define ORA_I		8'h12

`define EOR_IMM		8'h49
`define EOR_IMM8	8'h45
`define EOR_IMM16	8'h59
`define EOR_IMM32	8'h49
`define EOR_ZP		8'h45
`define EOR_ZPX		8'h55
`define EOR_IX		8'h41
`define EOR_IY		8'h51
`define EOR_ABS		8'h4D
`define EOR_ABSX	8'h5D
`define EOR_ABSY	8'h59
`define EOR_RIND	8'h52
`define EOR_I		8'h52
`define EOR_DSP		8'h43

// LD is OR rt,r0,....

`define ST_ZPX		8'h95
`define ST_IX		8'h81
`define ST_IY		8'h91
`define ST_ABS		8'h8D
`define ST_ABSX		8'h9D
`define ST_RIND		8'h92
`define ST_DSP		8'h83

`define ORB_ZPX		8'hB5
`define ORB_IX		8'hA1
`define ORB_IY		8'hB1
`define ORB_ABS		8'hAD
`define ORB_ABSX	8'hBD

`define STB_ZPX		8'h74
`define STB_ABS		8'h9C
`define STB_ABSX	8'h9E


//`define LDB_RIND	8'hB2	// Conflict with LDX #imm16

`define LDA_IMM		8'hA9
`define LDA_ZP		8'hA5
`define LDA_ZPX		8'hB5
`define LDA_IX		8'hA1
`define LDA_IY		8'hB1
`define LDA_ABS		8'hAD
`define LDA_ABSX	8'hBD
`define LDA_ABSY	8'hB9
`define LDA_I		8'hB2

`define STA_ZP		8'h85
`define STA_ZPX		8'h95
`define STA_IX		8'h81
`define STA_IY		8'h91
`define STA_ABS		8'h8D
`define STA_ABSX	8'h9D
`define STA_ABSY	8'h99
`define STA_I		8'h92

`define ASL_IMM8	8'h24
`define ASL_ACC		8'h0A
`define ASL_ZP		8'h06
`define ASL_RR		8'h06
`define ASL_ZPX		8'h16
`define ASL_ABS		8'h0E
`define ASL_ABSX	8'h1E

`define ROL_ACC		8'h2A
`define ROL_ZP		8'h26
`define ROL_RR		8'h26
`define ROL_ZPX		8'h36
`define ROL_ABS		8'h2E
`define ROL_ABSX	8'h3E

`define LSR_IMM8	8'h34
`define LSR_ACC		8'h4A
`define LSR_ZP		8'h46
`define LSR_RR		8'h46
`define LSR_ZPX		8'h56
`define LSR_ABS		8'h4E
`define LSR_ABSX	8'h5E

`define ROR_RR		8'h66
`define ROR_ZP		8'h66
`define ROR_ZPX		8'h76
`define ROR_ABS		8'h6E
`define ROR_ABSX	8'h7E

`define DEC_RR		8'hC6
`define DEC_ZP		8'hC6
`define DEC_ZPX		8'hD6
`define DEC_ABS		8'hCE
`define DEC_ABSX	8'hDE
`define INC_RR		8'hE6
`define INC_ZP		8'hE6
`define INC_ZPX		8'hF6
`define INC_ABS		8'hEE
`define INC_ABSX	8'hFE

`define BIT_IMM		8'h89
`define BIT_ZP		8'h24
`define BIT_ZPX		8'h34
`define BIT_ABS		8'h2C
`define BIT_ABSX	8'h3C

// CMP = SUB r0,...
// BIT = AND r0,...
`define BPL			8'h10
`define BVC			8'h50
`define BCC			8'h90
`define BNE			8'hD0
`define BMI			8'h30
`define BVS			8'h70
`define BCS			8'hB0
`define BEQ			8'hF0
`define BRL			8'h82
`define BRA			8'h80
`define BHI			8'h13
`define BLS			8'h33
`define BGE			8'h93
`define BLT			8'hB3
`define BGT			8'hD3
`define BLE			8'hF3

`define JML			8'h5C
`define JMP			8'h4C
`define JMP_IND		8'h6C
`define JMP_INDX	8'h7C
`define JMP_RIND	8'hD2
`define JSR			8'h20
`define JSL			8'h22
`define JSR_INDX	8'hFC
`define JSR_RIND	8'hC2
`define RTS			8'h60
`define RTL			8'h6B
`define BSR			8'h62
`define NOP			8'hEA

`define BRK			8'h00
`define PLX			8'hFA
`define PLY			8'h7A
`define PHX			8'hDA
`define PHY			8'h5A
`define WAI			8'hCB
`define PUSH		8'h0B
`define POP			8'h2B

`define LDX_IMM		8'hA2
`define LDX_ZP		8'hA6
`define LDX_ZPX		8'hB6
`define LDX_ZPY		8'hB6
`define LDX_ABS		8'hAE
`define LDX_ABSY	8'hBE

`define LDX_IMM32	8'hA2
`define LDX_IMM16	8'hB2
`define LDX_IMM8	8'hA6

`define LDY_IMM		8'hA0
`define LDY_ZP		8'hA4
`define LDY_ZPX		8'hB4
`define LDY_IMM32	8'hA0
`define LDY_ABS		8'hAC
`define LDY_ABSX	8'hBC

`define STX_ZP		8'h86
`define STX_ZPX		8'h96
`define STX_ZPY		8'h96
`define STX_ABS		8'h8E

`define STY_ZP		8'h84
`define STY_ZPX		8'h94
`define STY_ABS		8'h8C

`define STZ_ZP		8'h64
`define STZ_ZPX		8'h74
`define STZ_ABS		8'h9C
`define STZ_ABSX	8'h9E

`define CPX_IMM		8'hE0
`define CPX_IMM32	8'hE0
`define CPX_ZP		8'hE4
`define CPX_ZPX		8'hE4
`define CPX_ABS		8'hEC
`define CPY_IMM		8'hC0
`define CPY_IMM32	8'hC0
`define CPY_ZP		8'hC4
`define CPY_ZPX		8'hC4
`define CPY_ABS		8'hCC

`define TRB_ZP		8'h14
`define TRB_ZPX		8'h14
`define TRB_ABS		8'h1C
`define TSB_ZP		8'h04
`define TSB_ZPX		8'h04
`define TSB_ABS		8'h0C

`define BAZ			8'hC1
`define BXZ			8'hD1
`define BEQ_RR		8'hE2
`define INT0		8'hDC
`define INT1		8'hDD
`define SUB_SP8		8'h85
`define SUB_SP16	8'h99
`define SUB_SP32	8'h89
`define MVP			8'h44
`define MVN			8'h54
`define STS			8'h64
`define EXEC		8'hEB
`define ATNI		8'h4B

`define PG2			8'h42

`define NOTHING		4'd0
`define SR_70		4'd1
`define SR_310		4'd2
`define BYTE_70		4'd3
`define WORD_310	4'd4
`define PC_70		4'd5
`define PC_158		4'd6
`define PC_2316		4'd7
`define PC_3124		4'd8
`define PC_310		4'd9
`define WORD_311	4'd10
`define IA_310		4'd11
`define IA_70		4'd12
`define IA_158		4'd13
`define BYTE_71		4'd14
`define WORD_312	4'd15

`define STW_DEF		6'h0
`define STW_ACC		6'd1
`define STW_X		6'd2
`define STW_Y		6'd3
`define STW_PC		6'd4
`define STW_PC2		6'd5
`define STW_PCHWI	6'd6
`define STW_SR		6'd7
`define STW_RFA		6'd8
`define STW_RFA8	6'd9
`define STW_RFA		6'd10
`define STW_RFA8	6'd11
`define STW_A		6'd12
`define STW_B		6'd13
`define STW_CALC	6'd14

`define STW_ACC8	6'd16
`define STW_X8		6'd17
`define STW_Y8		6'd18
`define STW_PC3124	6'd19
`define STW_PC2316	6'd20
`define STW_PC158	6'd21
`define STW_PC70	6'd22
`define STW_SR70	6'd23

