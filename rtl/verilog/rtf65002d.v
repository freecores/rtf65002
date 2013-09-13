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
// 9000 LUT's / 850 ff's / 56 MHz
// 15 Block RAMs
// ============================================================================
//
`define TRUE		1'b1
`define FALSE		1'b0

`define RST_VECT	34'h3FFFFFFF8
`define NMI_VECT	34'h3FFFFFFF4
`define IRQ_VECT	34'h3FFFFFFF0
`define BRK_VECTNO	9'd0
`define SLP_VECTNO	9'd1
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

`define SUB_IMM8	8'hE5
`define SUB_IMM16	8'hF9
`define SUB_IMM32	8'hE9
`define SUB_ZPX		8'hF5
`define SUB_IX		8'hE1
`define SUB_IY		8'hF1
`define SUB_ABS		8'hED
`define SUB_ABSX	8'hFD
`define SUB_RIND	8'hF2

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

`define OR_IMM8		8'h05
`define OR_IMM16	8'h19
`define OR_IMM32	8'h09
`define OR_ZPX		8'h15
`define OR_IX		8'h01
`define OR_IY		8'h11
`define OR_ABS		8'h0D
`define OR_ABSX		8'h1D
`define OR_RIND		8'h12

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

// LD is OR rt,r0,....

`define ST_ZPX		8'h95
`define ST_IX		8'h81
`define ST_IY		8'h91
`define ST_ABS		8'h8D
`define ST_ABSX		8'h9D
`define ST_RIND		8'h92

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
`define BRA			8'h80
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

module icachemem(wclk, wr, adr, dat, rclk, pc, insn);
input wclk;
input wr;
input [33:0] adr;
input [31:0] dat;
input rclk;
input [31:0] pc;
output reg [55:0] insn;

wire [63:0] insn0;
wire [63:0] insn1;
wire [31:0] pcp8 = pc + 32'd8;
reg [31:0] rpc;

always @(posedge rclk)
	rpc <= pc;

// memL and memH combined allow a 64 bit read
syncRam2kx32_1rw1r ramL0
(
	.wrst(1'b0),
	.wclk(wclk),
	.wce(~adr[2]),
	.we(wr),
	.wsel(4'hF),
	.wadr(adr[13:3]),
	.i(dat),
	.wo(),
	.rrst(1'b0),
	.rclk(rclk),
	.rce(1'b1),
	.radr(pc[13:3]),
	.o(insn0[31:0])
);

syncRam2kx32_1rw1r ramH0
(
	.wrst(1'b0),
	.wclk(wclk),
	.wce(adr[2]),
	.we(wr),
	.wsel(4'hF),
	.wadr(adr[13:3]),
	.i(dat),
	.wo(),
	.rrst(1'b0),
	.rclk(rclk),
	.rce(1'b1),
	.radr(pc[13:3]),
	.o(insn0[63:32])
);

syncRam2kx32_1rw1r ramL1
(
	.wrst(1'b0),
	.wclk(wclk),
	.wce(~adr[2]),
	.we(wr),
	.wsel(4'hF),
	.wadr(adr[13:3]),
	.i(dat),
	.wo(),
	.rrst(1'b0),
	.rclk(rclk),
	.rce(1'b1),
	.radr(pcp8[13:3]),
	.o(insn1[31:0])
);

syncRam2kx32_1rw1r ramH1
(
	.wrst(1'b0),
	.wclk(wclk),
	.wce(adr[2]),
	.we(wr),
	.wsel(4'hF),
	.wadr(adr[13:3]),
	.i(dat),
	.wo(),
	.rrst(1'b0),
	.rclk(rclk),
	.rce(1'b1),
	.radr(pcp8[13:3]),
	.o(insn1[63:32])
);

always @(rpc or insn0 or insn1)
case(rpc[2:0])
3'd0:	insn <= insn0[55:0];
3'd1:	insn <= insn0[63:8];
3'd2:	insn <= {insn1[7:0],insn0[63:16]};
3'd3:	insn <= {insn1[15:0],insn0[63:24]};
3'd4:	insn <= {insn1[23:0],insn0[63:32]};
3'd5:	insn <= {insn1[31:0],insn0[63:40]};
3'd6:	insn <= {insn1[39:0],insn0[63:48]};
3'd7:	insn <= {insn1[47:0],insn0[63:56]};
endcase 
endmodule

module tagmem(wclk, wr, adr, rclk, pc, hit0, hit1);
input wclk;
input wr;
input [33:0] adr;
input rclk;
input [31:0] pc;
output hit0;
output hit1;

wire [31:0] pcp8 = pc + 32'd8;
wire [31:0] tag0;
wire [31:0] tag1;
reg [31:0] rpc;
reg [31:0] rpcp8;

always @(posedge rclk)
	rpc <= pc;
always @(posedge rclk)
	rpcp8 <= pcp8;

syncRam1kx32_1rw1r ram0 (
	.wrst(1'b0),
	.wclk(wclk),
	.wce(adr[3:2]==2'b11),
	.we(wr),
	.wsel(4'hF),
	.wadr(adr[13:4]),
	.i(adr[31:0]),
	.wo(),

	.rrst(1'b0),
	.rclk(rclk),
	.rce(1'b1),
	.radr(pc[13:4]),
	.o(tag0)
);

syncRam1kx32_1rw1r ram1 (
	.wrst(1'b0),
	.wclk(wclk),
	.wce(adr[3:2]==2'b11),
	.we(wr),
	.wsel(4'hF),
	.wadr(adr[13:4]),
	.i(adr[31:0]),
	.wo(),

	.rrst(1'b0),
	.rclk(rclk),
	.rce(1'b1),
	.radr(pcp8[13:4]),
	.o(tag1)
);

assign hit0 = tag0[31:14]==rpc[31:14] && tag0[0];
assign hit1 = tag1[31:14]==rpcp8[31:14] && tag1[0];

endmodule

module dcachemem(wclk, wr, sel, wadr, wdat, rclk, radr, rdat);
input wclk;
input wr;
input [3:0] sel;
input [31:0] wadr;
input [31:0] wdat;
input rclk;
input [31:0] radr;
output [31:0] rdat;

syncRam2kx32_1rw1r ram0 (
	.wrst(1'b0),
	.wclk(wclk),
	.wce(1'b1),
	.we(wr),
	.wsel(sel),
	.wadr(wadr[10:0]),
	.i(wdat),
	.wo(),
	.rrst(1'b0),
	.rclk(rclk),
	.rce(1'b1),
	.radr(radr[10:0]),
	.o(rdat)
);

endmodule

module dtagmem(wclk, wr, wadr, rclk, radr, hit);
input wclk;
input wr;
input [31:0] wadr;
input rclk;
input [31:0] radr;
output hit;

reg [31:0] rradr;
wire [31:0] tag;

syncRam512x32_1rw1r u1
	(
		.wrst(1'b0),
		.wclk(wclk),
		.wce(wadr[1:0]==2'b11),
		.we(wr),
		.wadr(wadr[10:2]),
		.i(wadr),
		.wo(),
		.rrst(1'b0),
		.rclk(rclk),
		.rce(1'b1),
		.radr(radr[10:2]),
		.o(tag)
	);


always @(rclk)
	rradr <= radr;
	
assign hit = tag[31:11]==rradr[31:11];

endmodule

module overflow(op, a, b, s, v);

input op;	// 0=add,1=sub
input a;
input b;
input s;	// sum
output v;

// Overflow:
// Add: the signs of the inputs are the same, and the sign of the
// sum is different
// Sub: the signs of the inputs are different, and the sign of
// the sum is the same as B
assign v = (op ^ s ^ b) & (~op ^ a ^ b);

endmodule


module rtf65002d(rst_i, clk_i, nmi_i, irq_i, irq_vect, bte_o, cti_o, bl_o, lock_o, cyc_o, stb_o, ack_i, we_o, sel_o, adr_o, dat_i, dat_o);
parameter IDLE = 3'd0;
parameter LOAD_DCACHE = 3'd1;
parameter LOAD_ICACHE = 3'd2;
parameter LOAD_IBUF1 = 3'd3;
parameter LOAD_IBUF2 = 3'd4;
parameter LOAD_IBUF3 = 3'd5;
parameter RESET1 = 7'd0;
parameter IFETCH = 7'd1;
parameter JMP_IND1 = 7'd2;
parameter JMP_IND2 = 7'd3;
parameter DECODE = 7'd4;
parameter STORE1 = 7'd5;
parameter STORE2 = 7'd6;
parameter LOAD1 = 7'd7;
parameter LOAD2 = 7'd8;
parameter IRQ1 = 7'd9;
parameter IRQ2 = 7'd10;
parameter IRQ3 = 7'd11;
parameter CALC = 7'd12;
parameter JSR1 = 7'd13;
parameter JSR_INDX1 = 7'd14;
parameter JSR161 = 7'd15;
parameter RTS1 = 7'd16;
parameter RTS2 = 7'd17;
parameter IX1 = 7'd18;
parameter IX2 = 7'd19;
parameter IX3 = 7'd20;
parameter IX4 = 7'd21;
parameter IY1 = 7'd22;
parameter IY2 = 7'd23;
parameter IY3 = 7'd24;
parameter PHP1 = 7'd27;
parameter PLP1 = 7'd28;
parameter PLP2 = 7'd29;
parameter PLA1 = 7'd30;
parameter PLA2 = 7'd31;
parameter BSR1 = 7'd32;
parameter BYTE_IX1 = 7'd33;
parameter BYTE_IX2 = 7'd34;
parameter BYTE_IX3 = 7'd35;
parameter BYTE_IX4 = 7'd36;
parameter BYTE_IX5 = 7'd37;
parameter BYTE_IY1 = 7'd38;
parameter BYTE_IY2 = 7'd39;
parameter BYTE_IY3 = 7'd40;
parameter BYTE_IY4 = 7'd41;
parameter BYTE_IY5 = 7'd42;
parameter RTS3 = 7'd43;
parameter RTS4 = 7'd44;
parameter RTS5 = 7'd45;
parameter BYTE_JSR1 = 7'd46;
parameter BYTE_JSR2 = 7'd47;
parameter BYTE_JSR3 = 7'd48;
parameter BYTE_IRQ1 = 7'd49;
parameter BYTE_IRQ2 = 7'd50;
parameter BYTE_IRQ3 = 7'd51;
parameter BYTE_IRQ4 = 7'd52;
parameter BYTE_IRQ5 = 7'd53;
parameter BYTE_IRQ6 = 7'd54;
parameter BYTE_IRQ7 = 7'd55;
parameter BYTE_IRQ8 = 7'd56;
parameter BYTE_IRQ9 = 7'd57;
parameter BYTE_JMP_IND1 = 7'd58;
parameter BYTE_JMP_IND2 = 7'd59;
parameter BYTE_JMP_IND3 = 7'd60;
parameter BYTE_JMP_IND4 = 7'd61;
parameter BYTE_JSR_INDX1 = 7'd62;
parameter BYTE_JSR_INDX2 = 7'd63;
parameter BYTE_JSR_INDX3 = 7'd64;
parameter RTI1 = 7'd65;
parameter RTI2 = 7'd66;
parameter RTI3 = 7'd67;
parameter RTI4 = 7'd68;
parameter BYTE_RTS1 = 7'd69;
parameter BYTE_RTS2 = 7'd70;
parameter BYTE_RTS3 = 7'd71;
parameter BYTE_RTS4 = 7'd72;
parameter BYTE_RTS5 = 7'd73;
parameter BYTE_RTS6 = 7'd74;
parameter BYTE_RTS7 = 7'd75;
parameter BYTE_RTS8 = 7'd76;
parameter BYTE_RTS9 = 7'd77;
parameter BYTE_RTI1 = 7'd78;
parameter BYTE_RTI2 = 7'd79;
parameter BYTE_RTI3 = 7'd80;
parameter BYTE_RTI4 = 7'd81;
parameter BYTE_RTI5 = 7'd82;
parameter BYTE_RTI6 = 7'd83;
parameter BYTE_RTI7 = 7'd84;
parameter BYTE_RTI8 = 7'd85;
parameter BYTE_RTI9 = 7'd86;
parameter BYTE_RTI10 = 7'd87;
parameter BYTE_JSL1 = 7'd88;
parameter BYTE_JSL2 = 7'd89;
parameter BYTE_JSL3 = 7'd90;
parameter BYTE_JSL4 = 7'd91;
parameter BYTE_JSL5 = 7'd92;
parameter BYTE_JSL6 = 7'd93;
parameter BYTE_JSL7 = 7'd94;
parameter BYTE_PLP1 = 7'd95;
parameter BYTE_PLP2 = 7'd96;
parameter BYTE_PLA1 = 7'd97;
parameter BYTE_PLA2 = 7'd98;
parameter WAIT_DHIT = 7'd99;
parameter RESET2 = 7'd100;
parameter MULDIV1 = 7'd101;
parameter MULDIV2 = 7'd102;

input rst_i;
input clk_i;
input nmi_i;
input irq_i;
input [8:0] irq_vect;
output reg [1:0] bte_o;
output reg [2:0] cti_o;
output reg [5:0] bl_o;
output reg lock_o;
output reg cyc_o;
output reg stb_o;
input ack_i;
output reg we_o;
output reg [3:0] sel_o;
output reg [33:0] adr_o;
input [31:0] dat_i;
output reg [31:0] dat_o;

reg [6:0] state;
reg [6:0] retstate;
reg [2:0] cstate;
wire [55:0] insn;
reg [55:0] ibuf;
reg [31:0] bufadr;

reg cf,nf,zf,vf,bf,im,df,em;
reg em1;
reg gie;
reg nmoi;	// native mode on interrupt
wire [31:0] sr = {nf,vf,em,24'b0,bf,df,im,zf,cf};
wire [7:0] sr8 = {nf,vf,1'b0,bf,df,im,zf,cf};
reg nmi1,nmi_edge;
reg wai;
reg [31:0] acc;
reg [31:0] x;
reg [31:0] y;
reg [7:0] sp;
reg [31:0] spage;	// stack page
wire [7:0] acc8 = acc[7:0];
wire [7:0] x8 = x[7:0];
wire [7:0] y8 = y[7:0];
reg [31:0] isp;		// interrupt stack pointer
wire [63:0] prod;
wire [31:0] q,r;
reg [31:0] tick;
wire [7:0] sp_dec = sp - 8'd1;
wire [7:0] sp_inc = sp + 8'd1;
wire [31:0] isp_dec = isp - 32'd1;
wire [31:0] isp_inc = isp + 32'd1;
reg [31:0] pc;
wire [31:0] pcp1 = pc + 32'd1;
wire [31:0] pcp2 = pc + 32'd2;
wire [31:0] pcp3 = pc + 32'd3;
wire [31:0] pcp4 = pc + 32'd4;
wire [31:0] pcp8 = pc + 32'd8;
reg [31:0] dp;		// 32 bit mode direct page register
reg [31:0] dp8;		// 8 bit mode direct page register
reg [31:0] abs8;	// 8 bit mode absolute address register
reg [31:0] vbr;		// vector table base register
wire bhit=pc==bufadr;
reg [31:0] regfile [15:0];
reg [55:0] ir;
wire [3:0] Ra = ir[11:8];
wire [3:0] Rb = ir[15:12];
reg [31:0] rfoa;
reg [31:0] rfob;
always @(Ra or x or y or acc)
case(Ra)
4'h0:	rfoa <= 32'd0;
4'h1:	rfoa <= acc;
4'h2:	rfoa <= x;
4'h3:	rfoa <= y;
default:	rfoa <= regfile[Ra];
endcase
always @(Rb or x or y or acc)
case(Rb)
4'h0:	rfob <= 32'd0;
4'h1:	rfob <= acc;
4'h2:	rfob <= x;
4'h3:	rfob <= y;
default:	rfob <= regfile[Rb];
endcase
reg [3:0] Rt;
reg [33:0] ea;
reg first_ifetch;
reg [31:0] lfsr;
wire lfsr_fb; 
xnor(lfsr_fb,lfsr[0],lfsr[1],lfsr[21],lfsr[31]);
reg [31:0] a, b;
wire [31:0] shlo = a << b[4:0];
wire [31:0] shro = a >> b[4:0];
reg [7:0] b8;
reg [32:0] res;
reg [8:0] res8;
wire resv8,resv32;
wire resc8 = res8[8];
wire resc32 = res[32];
wire resz8 = res8[7:0]==8'h00;
wire resz32 = res[31:0]==32'd0;
wire resn8 = res8[7];
wire resn32 = res[31];
wire resn = em ? res8[7] : res[31];
wire resz = em ? res8[7:0]==8'h00 : res[31:0]==32'd0;
wire resc = em ? res8[8] : res[32];
wire resv = em ? resv8 : resv32;

reg [31:0] vect;
reg [31:0] ia;			// temporary reg to hold indirect address
wire [31:0] iapy8 = ia + y[7:0];
reg isInsnCacheLoad;
reg isDataCacheLoad;
reg isCacheReset;
wire hit0,hit1;
wire dhit;
reg write_allocate;
reg wr;
reg [3:0] wrsel;
reg [31:0] radr;
reg [1:0] radr2LSB;
wire [33:0] radr34 = {radr,radr2LSB};
wire [33:0] radr34p1 = radr34 + 34'd1;
reg [31:0] wadr;
reg [1:0] wadr2LSB;
reg [31:0] wdat;
wire [31:0] rdat;
reg imiss;
reg dmiss;
reg icacheOn,dcacheOn;
wire unCachedData = radr[31:28]==4'hD || !dcacheOn;
wire unCachedInsn =/* pc[31:28]==4'hF || */!icacheOn;

wire isSub = ir[7:0]==`SUB_ZPX || ir[7:0]==`SUB_IX || ir[7:0]==`SUB_IY ||
			 ir[7:0]==`SUB_ABS || ir[7:0]==`SUB_ABSX || ir[7:0]==`SUB_IMM8 || ir[7:0]==`SUB_IMM16 || ir[7:0]==`SUB_IMM32;
wire isSub8 = ir[7:0]==`SBC_ZP || ir[7:0]==`SBC_ZPX || ir[7:0]==`SBC_IX || ir[7:0]==`SBC_IY || ir[7:0]==`SBC_I ||
			 ir[7:0]==`SBC_ABS || ir[7:0]==`SBC_ABSX || ir[7:0]==`SBC_ABSY || ir[7:0]==`SBC_IMM;
wire isCmp = ir[7:0]==`CPX_ZPX || ir[7:0]==`CPX_ABS || ir[7:0]==`CPX_IMM32 ||
			 ir[7:0]==`CPY_ZPX || ir[7:0]==`CPY_ABS || ir[7:0]==`CPY_IMM32;
wire isRMW32 =
			 ir[7:0]==`ASL_ZPX || ir[7:0]==`ROL_ZPX || ir[7:0]==`LSR_ZPX || ir[7:0]==`ROR_ZPX || ir[7:0]==`INC_ZPX || ir[7:0]==`DEC_ZPX ||
			 ir[7:0]==`ASL_ABS || ir[7:0]==`ROL_ABS || ir[7:0]==`LSR_ABS || ir[7:0]==`ROR_ABS || ir[7:0]==`INC_ABS || ir[7:0]==`DEC_ABS ||
			 ir[7:0]==`ASL_ABSX || ir[7:0]==`ROL_ABSX || ir[7:0]==`LSR_ABSX || ir[7:0]==`ROR_ABSX || ir[7:0]==`INC_ABSX || ir[7:0]==`DEC_ABSX ||
			 ir[7:0]==`TRB_ZP || ir[7:0]==`TRB_ZPX || ir[7:0]==`TRB_ABS || ir[7:0]==`TSB_ZP || ir[7:0]==`TSB_ZPX || ir[7:0]==`TSB_ABS;
			 ;
wire isRMW8 =
			 ir[7:0]==`ASL_ZP || ir[7:0]==`ROL_ZP || ir[7:0]==`LSR_ZP || ir[7:0]==`ROR_ZP || ir[7:0]==`INC_ZP || ir[7:0]==`DEC_ZP ||
			 ir[7:0]==`ASL_ZPX || ir[7:0]==`ROL_ZPX || ir[7:0]==`LSR_ZPX || ir[7:0]==`ROR_ZPX || ir[7:0]==`INC_ZPX || ir[7:0]==`DEC_ZPX ||
			 ir[7:0]==`ASL_ABS || ir[7:0]==`ROL_ABS || ir[7:0]==`LSR_ABS || ir[7:0]==`ROR_ABS || ir[7:0]==`INC_ABS || ir[7:0]==`DEC_ABS ||
			 ir[7:0]==`ASL_ABSX || ir[7:0]==`ROL_ABSX || ir[7:0]==`LSR_ABSX || ir[7:0]==`ROR_ABSX || ir[7:0]==`INC_ABSX || ir[7:0]==`DEC_ABSX ||
			 ir[7:0]==`TRB_ZP || ir[7:0]==`TRB_ZPX || ir[7:0]==`TRB_ABS || ir[7:0]==`TSB_ZP || ir[7:0]==`TSB_ZPX || ir[7:0]==`TSB_ABS;
			 ;
wire isRMW = em ? isRMW8 : isRMW32;
wire isOrb = ir[7:0]==`ORB_ZPX || ir[7:0]==`ORB_IX || ir[7:0]==`ORB_IY || ir[7:0]==`ORB_ABS || ir[7:0]==`ORB_ABSX;
wire isStb = ir[7:0]==`STB_ZPX || ir[7:0]==`STB_ABS || ir[7:0]==`STB_ABSX;

wire ld_muldiv = state==DECODE && ir[7:0]==`RR;
wire md_done;
wire clk;

mult_div umd1
(
	.rst(rst),
	.clk(clk),
	.ld(ld_muldiv),
	.op(ir[23:20]),
	.a(rfoa),
	.b(rfob),
	.p(prod),
	.q(q),
	.r(r),
	.done(md_done)
);

icachemem icm0 (
	.wclk(clk),
	.wr(ack_i & isInsnCacheLoad),
	.adr(adr_o),
	.dat(dat_i),
	.rclk(~clk_i),
	.pc(pc),
	.insn(insn)
);

tagmem tgm0 (
	.wclk(clk),
	.wr((ack_i & isInsnCacheLoad)|isCacheReset),
	.adr({adr_o[31:1],!isCacheReset}),
	.rclk(~clk_i),
	.pc(pc),
	.hit0(hit0),
	.hit1(hit1)
);

wire ihit = (hit0 & hit1);//(pc[2:0] > 3'd1 ? hit1 : 1'b1));

dcachemem dcm0 (
	.wclk(clk),
	.wr(wr | (ack_i & isDataCacheLoad)),
	.sel(wr ? wrsel : sel_o),
	.wadr(wr ? wadr : adr_o[33:2]),
	.wdat(wr ? wdat : dat_i),
	.rclk(~clk_i),
	.radr(radr),
	.rdat(rdat)
);

dtagmem dtm0 (
	.wclk(clk),
	.wr(wr | (ack_i & isDataCacheLoad)),
	.wadr(wr ? wadr : adr_o[33:2]),
	.rclk(~clk_i),
	.radr(radr),
	.hit(dhit)
);

overflow uovr1 (
	.op(isSub),
	.a(a[31]),
	.b(b[31]),
	.s(res[31]),
	.v(resv32)
);

overflow uovr2 (
	.op(isSub8),
	.a(acc8[7]),
	.b(b8[7]),
	.s(res8[7]),
	.v(resv8)
);

wire [7:0] bcaio;
wire [7:0] bcao;
wire [7:0] bcsio;
wire [7:0] bcso;
wire bcaico,bcaco,bcsico,bcsco;

BCDAdd ubcdai1 (.ci(cf),.a(acc8),.b(ir[15:8]),.o(bcaio),.c(bcaico));
BCDAdd ubcda2 (.ci(cf),.a(acc8),.b(b8),.o(bcao),.c(bcaco));
BCDSub ubcdsi1 (.ci(cf),.a(acc8),.b(ir[15:8]),.o(bcsio),.c(bcsico));
BCDSub ubcds2 (.ci(cf),.a(acc8),.b(b8),.o(bcso),.c(bcsco));

reg [7:0] dati;
always @(radr2LSB or dat_i)
case(radr2LSB)
2'd0:	dati <= dat_i[7:0];
2'd1:	dati <= dat_i[15:8];
2'd2:	dati <= dat_i[23:16];
2'd3:	dati <= dat_i[31:24];
endcase
reg [7:0] rdat8;
always @(radr2LSB or rdat)
case(radr2LSB)
2'd0:	rdat8 <= rdat[7:0];
2'd1:	rdat8 <= rdat[15:8];
2'd2:	rdat8 <= rdat[23:16];
2'd3:	rdat8 <= rdat[31:24];
endcase

reg takb;
always @(ir or cf or vf or nf or zf)
case(ir[7:0])
`BEQ:	takb <= zf;
`BNE:	takb <= !zf;
`BPL:	takb <= !nf;
`BMI:	takb <= nf;
`BCS:	takb <= cf;
`BCC:	takb <= !cf;
`BVS:	takb <= vf;
`BVC:	takb <= !vf;
`BRA:	takb <= 1'b1;
`BRL:	takb <= 1'b1;
//`BAZ:	takb <= acc8==8'h00;
//`BXZ:	takb <= x8==8'h00;
default:	takb <= 1'b0;
endcase

wire [31:0] zpx_address = dp8 + ir[15:8] + x8;
wire [31:0] zpy_address = dp8 + ir[15:8] + y8;
wire [31:0] zp_address = dp8 + ir[15:8];
wire [31:0] abs_address = abs8 + {16'h0,ir[23:8]};
wire [31:0] absx_address = abs8 + {16'h0,ir[23:8] + {8'h0,x8}};
wire [31:0] absy_address = abs8 + {16'h0,ir[23:8] + {8'h0,y8}};
wire [31:0] zpx32xy_address = dp + ir[23:12] + rfoa;
wire [31:0] absx32xy_address = ir[47:16] + rfob;
wire [31:0] zpx32_address = dp + ir[31:20] + rfob;
wire [31:0] absx32_address = ir[55:24] + rfob;

//-----------------------------------------------------------------------------
// Clock control
// - reset or NMI reenables the clock
// - this circuit must be under the clk_i domain
//-----------------------------------------------------------------------------
//
reg cpu_clk_en;
reg clk_en;
BUFGCE u20 (.CE(cpu_clk_en), .I(clk_i), .O(clk) );

always @(posedge clk_i)
if (rst_i) begin
	cpu_clk_en <= 1'b1;
	nmi1 <= 1'b0;
end
else begin
	nmi1 <= nmi_i;
	if (nmi_i)
		cpu_clk_en <= 1'b1;
	else
		cpu_clk_en <= clk_en;
end

always @(posedge clk)
if (rst_i) begin
	bte_o <= 2'b00;
	cti_o <= 3'b000;
	bl_o <= 6'd0;
	cyc_o <= 1'b0;
	stb_o <= 1'b0;
	we_o <= 1'b0;
	sel_o <= 4'h0;
	adr_o <= 34'd0;
	dat_o <= 32'd0;
	nmi_edge <= 1'b0;
	wai <= 1'b0;
	first_ifetch <= `TRUE;
	wr <= 1'b0;
	em <= 1'b0;
	cf <= 1'b0;
	ir <= 56'hEAEAEAEAEAEAEA;
	imiss <= `FALSE;
	dmiss <= `FALSE;
	dcacheOn <= 1'b0;
	icacheOn <= 1'b1;
	write_allocate <= 1'b0;
	nmoi <= 1'b1;
	state <= RESET1;
	cstate <= IDLE;
	vect <= `RST_VECT;
	pc <= 32'hFFFFFFF0;
	spage <= 32'h00000100;
	bufadr <= 32'd0;
	dp <= 32'd0;
	dp8 <= 32'd0;
	abs8 <= 32'd0;
	clk_en <= 1'b1;
	isCacheReset <= `TRUE;
	gie <= 1'b0;
	tick <= 32'd0;
end
else begin
tick <= tick + 32'd1;
wr <= 1'b0;
if (nmi_i & !nmi1)
	nmi_edge <= 1'b1;
if (nmi_i|nmi1)
	clk_en <= 1'b1;
case(state)
RESET1:
	begin
		adr_o <= adr_o + 32'd4;
		if (adr_o[13:4]==10'h3FF) begin
			state <= RESET2;
			isCacheReset <= `FALSE;
		end
	end
RESET2:
	begin
		vect <= `RST_VECT;
		radr <= vect[31:2];
		state <= JMP_IND1;
	end
IFETCH:
	begin
		if (nmi_edge & !imiss & gie) begin	// imiss indicates cache controller is active and this state is in a waiting loop
			nmi_edge <= 1'b0;
			wai <= 1'b0;
			bf <= 1'b0;
			if (em & !nmoi) begin
				radr <= {spage[31:8],sp[7:2]};
				radr2LSB <= sp[1:0];
				wadr <= {spage[31:8],sp[7:2]};
				wadr2LSB <= sp[1:0];
				wdat <= {4{pc[31:24]}};
				cyc_o <= 1'b1;
				stb_o <= 1'b1;
				we_o <= 1'b1;
				case(sp[1:0])
				2'd0:	sel_o <= 4'b0001;
				2'd1:	sel_o <= 4'b0010;
				2'd2:	sel_o <= 4'b0100;
				2'd3:	sel_o <= 4'b1000;
				endcase
				adr_o <= {spage[31:8],sp[7:2],2'b00};
				dat_o <= {4{pc[31:24]}};
				sp <= sp_dec;
				vect <= `BYTE_NMI_VECT;
				state <= BYTE_IRQ1;
			end
			else begin
				radr <= isp_dec;
				wadr <= isp_dec;
				wdat <= pc;
				cyc_o <= 1'b1;
				stb_o <= 1'b1;
				we_o <= 1'b1;
				sel_o <= 4'hF;
				adr_o <= {isp_dec,2'b00};
				dat_o <= pc;
				vect <= `NMI_VECT;
				state <= IRQ1;
			end
		end
		else if (irq_i && !imiss & gie) begin
			if (im) begin
				wai <= 1'b0;
				if (unCachedInsn) begin
					if (bhit) begin
						ir <= ibuf;
						state <= DECODE;
					end
					else
						imiss <= `TRUE;
				end
				else begin
					if (ihit) begin
						ir <= insn;
						state <= DECODE;
					end
					else
						imiss <= `TRUE;
				end
			end
			else begin
				bf <= 1'b0;
				wai <= 1'b0;
				if (em & !nmoi) begin
					radr <= {spage[31:8],sp[7:2]};
					radr2LSB <= sp[1:0];
					wadr <= {spage[31:8],sp[7:2]};
					wadr2LSB <= sp[1:0];
					wdat <= {4{pc[31:24]}};
					cyc_o <= 1'b1;
					stb_o <= 1'b1;
					we_o <= 1'b1;
					case(sp[1:0])
					2'd0:	sel_o <= 4'b0001;
					2'd1:	sel_o <= 4'b0010;
					2'd2:	sel_o <= 4'b0100;
					2'd3:	sel_o <= 4'b1000;
					endcase
					adr_o <= {spage[31:8],sp[7:2],2'b00};
					dat_o <= {4{pc[31:24]}};
					sp <= sp_dec;
					vect <= `BYTE_IRQ_VECT;
					state <= BYTE_IRQ1;
				end
				else begin
					radr <= isp_dec;
					wadr <= isp_dec;
					wdat <= pc;
					cyc_o <= 1'b1;
					stb_o <= 1'b1;
					we_o <= 1'b1;
					sel_o <= 4'hF;
					adr_o <= {isp_dec,2'b00};
					dat_o <= pc;
					vect <= {vbr[31:9],irq_vect,2'b00};
					state <= IRQ1;
				end
			end
		end
		else if (!wai) begin
			if (unCachedInsn) begin
				if (bhit) begin
					ir <= ibuf;
					state <= DECODE;
				end
				else
					imiss <= `TRUE;
			end
			else begin
				if (ihit) begin
					ir <= insn;
					state <= DECODE;
				end
				else
					imiss <= `TRUE;
			end
		end
		if (first_ifetch) begin
			first_ifetch <= `FALSE;
			if (em) begin
				case(ir[7:0])
				`NAT:	em <= 1'b0;
				`TAY,`TXY,`DEY,`INY:	begin y[7:0] <= res8; nf <= resn8; zf <= resz8; end
				`TAX,`TYX,`TSX,`DEX,`INX:	begin x[7:0] <= res8; nf <= resn8; zf <= resz8; end
				`TSA,`TYA,`TXA,`INA,`DEA:	begin acc[7:0] <= res8; nf <= resn8; zf <= resz8; end
				`TAS,`TXS: begin sp <= res8[7:0]; end
				`ADC_IMM:
					begin
						acc[7:0] <= df ? bcaio : res8;
						cf <= df ? bcaico : resc8;
//						vf <= resv8;
						vf <= (res8[7] ^ b8[7]) & (1'b1 ^ acc[7] ^ b8[7]);
						nf <= df ? bcaio[7] : resn8;
						zf <= df ? bcaio==8'h00 : resz8;
					end
				`ADC_ZP,`ADC_ZPX,`ADC_IX,`ADC_IY,`ADC_ABS,`ADC_ABSX,`ADC_ABSY,`ADC_I:
					begin
						acc[7:0] <= df ? bcao : res8;
						cf <= df ? bcaco : resc8;
						vf <= (res8[7] ^ b8[7]) & (1'b1 ^ acc[7] ^ b8[7]);
						nf <= df ? bcao[7] : resn8;
						zf <= df ? bcao==8'h00 : resz8;
					end
				`SBC_IMM:
					begin
						acc[7:0] <= df ? bcsio : res8;
						cf <= ~(df ? bcsico : resc8);
						vf <= (1'b1 ^ res8[7] ^ b8[7]) & (acc[7] ^ b8[7]);
						nf <= df ? bcsio[7] : resn8;
						zf <= df ? bcsio==8'h00 : resz8;
					end
				`SBC_ZP,`SBC_ZPX,`SBC_IX,`SBC_IY,`SBC_ABS,`SBC_ABSX,`SBC_ABSY,`SBC_I:
					begin
						acc[7:0] <= df ? bcso : res8;
						vf <= (1'b1 ^ res8[7] ^ b8[7]) & (acc[7] ^ b8[7]);
						cf <= ~(df ? bcsco : resc8);
						nf <= df ? bcso[7] : resn8;
						zf <= df ? bcso==8'h00 : resz8;
					end
				`CMP_IMM,`CMP_ZP,`CMP_ZPX,`CMP_IX,`CMP_IY,`CMP_ABS,`CMP_ABSX,`CMP_ABSY,`CMP_I,
				`CPX_IMM,`CPX_ZP,`CPX_ABS,
				`CPY_IMM,`CPY_ZP,`CPY_ABS:
						begin cf <= ~resc8; nf <= resn8; zf <= resz8; end
				`BIT_IMM,`BIT_ZP,`BIT_ZPX,`BIT_ABS,`BIT_ABSX:
						begin nf <= b8[7]; vf <= b8[6]; zf <= resz8; end
				`TRB_ZP,`TRB_ABS,`TSB_ZP,`TSB_ABS:
					begin zf <= resz8; end
				`LDA_IMM,`LDA_ZP,`LDA_ZPX,`LDA_IX,`LDA_IY,`LDA_ABS,`LDA_ABSX,`LDA_ABSY,`LDA_I,
				`AND_IMM,`AND_ZP,`AND_ZPX,`AND_IX,`AND_IY,`AND_ABS,`AND_ABSX,`AND_ABSY,`AND_I,
				`ORA_IMM,`ORA_ZP,`ORA_ZPX,`ORA_IX,`ORA_IY,`ORA_ABS,`ORA_ABSX,`ORA_ABSY,`ORA_I,
				`EOR_IMM,`EOR_ZP,`EOR_ZPX,`EOR_IX,`EOR_IY,`EOR_ABS,`EOR_ABSX,`EOR_ABSY,`EOR_I:
					begin acc[7:0] <= res8; nf <= resn8; zf <= resz8; end
				`ASL_ACC:	begin acc[7:0] <= res8; cf <= resc8; nf <= resn8; zf <= resz8; end
				`ROL_ACC:	begin acc[7:0] <= res8; cf <= resc8; nf <= resn8; zf <= resz8; end
				`LSR_ACC:	begin acc[7:0] <= res8; cf <= resc8; nf <= resn8; zf <= resz8; end
				`ROR_ACC:	begin acc[7:0] <= res8; cf <= resc8; nf <= resn8; zf <= resz8; end
				`ASL_ZP,`ASL_ZPX,`ASL_ABS,`ASL_ABSX: begin cf <= resc8; nf <= resn8; zf <= resz8; end
				`ROL_ZP,`ROL_ZPX,`ROL_ABS,`ROL_ABSX: begin cf <= resc8; nf <= resn8; zf <= resz8; end
				`LSR_ZP,`LSR_ZPX,`LSR_ABS,`LSR_ABSX: begin cf <= resc8; nf <= resn8; zf <= resz8; end
				`ROR_ZP,`ROR_ZPX,`ROR_ABS,`ROR_ABSX: begin cf <= resc8; nf <= resn8; zf <= resz8; end
				`INC_ZP,`INC_ZPX,`INC_ABS,`INC_ABSX: begin nf <= resn8; zf <= resz8; end
				`DEC_ZP,`DEC_ZPX,`DEC_ABS,`DEC_ABSX: begin nf <= resn8; zf <= resz8; end
				`PLA:	begin acc[7:0] <= res8; zf <= resz8; nf <= resn8; end
				`PLX:	begin x[7:0] <= res8; zf <= resz8; nf <= resn8; end
				`PLY:	begin y[7:0] <= res8; zf <= resz8; nf <= resn8; end
				`LDX_IMM,`LDX_ZP,`LDX_ZPY,`LDX_ABS,`LDX_ABSY:	begin x[7:0] <= res8; nf <= resn8; zf <= resz8; end
				`LDY_IMM,`LDY_ZP,`LDY_ZPX,`LDY_ABS,`LDY_ABSX:	begin y[7:0] <= res8; nf <= resn8; zf <= resz8; end
				endcase
			end
			else begin
				regfile[Rt] <= res;
				case(Rt)
				4'h1:	acc <= res;
				4'h2:	x <= res;
				4'h3:	y <= res;
				default:	;
				endcase
				case(ir[7:0])
				`EMM:	em <= 1'b1;
				`TAY,`TXY,`DEY,`INY:	begin y <= res; nf <= resn32; zf <= resz32; end
				`TAX,`TYX,`TSX,`DEX,`INX:	begin x <= res; nf <= resn32; zf <= resz32; end
				`TAS,`TXS:	begin isp <= res; gie <= 1'b1; end
				`TSA,`TYA,`TXA,`INA,`DEA:	begin acc <= res; nf <= resn32; zf <= resz32; end
				`TRS:
					begin
						case(ir[15:12])
						4'h0:	begin
								$display("res=%h",res);
								icacheOn <= res[0];
								dcacheOn <= res[1];
								write_allocate <= res[2];
								end
						4'h1:	dp <= res;
						4'h5:	lfsr <= res;
						4'h6:	dp8 <= res;
						4'h7:	abs8 <= res;
						4'h8:	begin vbr <= {res[31:9],9'h000}; nmoi <= res[0]; end
						4'hE:	begin sp <= res[7:0]; spage[31:8] <= res[31:8]; end
						4'hF:	begin isp <= res; gie <= 1'b1; end
						endcase
					end
				`RR:
					case(ir[23:20])
					`ADD_RR:	begin vf <= resv32; cf <= resc32; nf <= resn32; zf <= resz32; end
					`SUB_RR:	
							if (Rt==4'h0)	// CMP doesn't set overflow
								begin cf <= ~resc32; nf <= resn32; zf <= resz32; end
							else
								begin vf <= resv32; cf <= ~resc32; nf <= resn32; zf <= resz32; end
					`AND_RR:
						if (Rt==4'h0)	// BIT sets overflow
							begin nf <= b[31]; vf <= b[30]; zf <= resz32; end
						else
							begin nf <= resn32; zf <= resz32; end
					`OR_RR:	begin nf <= resn32; zf <= resz32; end
					`EOR_RR:	begin nf <= resn32; zf <= resz32; end
					`MUL_RR:	begin nf <= resn32; zf <= resz32; end
					`MULS_RR:	begin nf <= resn32; zf <= resz32; end
					`DIV_RR:	begin nf <= resn32; zf <= resz32; end
					`DIVS_RR:	begin nf <= resn32; zf <= resz32; end
					`MOD_RR:	begin nf <= resn32; zf <= resz32; end
					`MODS_RR:	begin nf <= resn32; zf <= resz32; end
					`ASL_RRR:	begin nf <= resn32; zf <= resz32; end
					`LSR_RRR:	begin nf <= resn32; zf <= resz32; end
					endcase
				`LD_RR:	begin zf <= resz32; nf <= resn32; end
				`DEC_RR,`INC_RR: begin zf <= resz32; nf <= resn32; end
				`ASL_RR,`ROL_RR,`LSR_RR,`ROR_RR: begin cf <= resc32; nf <= resn32; zf <= resz32; end
				`ADD_IMM8,`ADD_IMM16,`ADD_IMM32,`ADD_ZPX,`ADD_IX,`ADD_IY,`ADD_ABS,`ADD_ABSX,`ADD_RIND:
					begin vf <= resv32; cf <= resc32; nf <= resn32; zf <= resz32; end
				`SUB_IMM8,`SUB_IMM16,`SUB_IMM32,`SUB_ZPX,`SUB_IX,`SUB_IY,`SUB_ABS,`SUB_ABSX,`SUB_RIND:
					if (Rt==4'h0)	// CMP doesn't set overflow
						begin cf <= ~resc32; nf <= resn32; zf <= resz32; end
					else
						begin vf <= resv32; cf <= ~resc32; nf <= resn32; zf <= resz32; end
				`AND_IMM8,`AND_IMM16,`AND_IMM32,`AND_ZPX,`AND_IX,`AND_IY,`AND_ABS,`AND_ABSX,`AND_RIND:
					if (Rt==4'h0)	// BIT sets overflow
						begin nf <= b[31]; vf <= b[30]; zf <= resz32; end
					else
						begin nf <= resn32; zf <= resz32; end
				`ORB_ZPX,`ORB_ABS,`ORB_ABSX,
				`OR_IMM8,`OR_IMM16,`OR_IMM32,`OR_ZPX,`OR_IX,`OR_IY,`OR_ABS,`OR_ABSX,`OR_RIND,
				`EOR_IMM8,`EOR_IMM16,`EOR_IMM32,`EOR_ZPX,`EOR_IX,`EOR_IY,`EOR_ABS,`EOR_ABSX,`EOR_RIND:
					begin nf <= resn32; zf <= resz32; end
				`ASL_ACC:	begin acc <= res; cf <= resc32; nf <= resn32; zf <= resz32; end
				`ROL_ACC:	begin acc <= res; cf <= resc32; nf <= resn32; zf <= resz32; end
				`LSR_ACC:	begin acc <= res; cf <= resc32; nf <= resn32; zf <= resz32; end
				`ROR_ACC:	begin acc <= res; cf <= resc32; nf <= resn32; zf <= resz32; end
				`ASL_ZPX,`ASL_ABS,`ASL_ABSX: begin cf <= resc32; nf <= resn32; zf <= resz32; end
				`ROL_ZPX,`ROL_ABS,`ROL_ABSX: begin cf <= resc32; nf <= resn32; zf <= resz32; end
				`LSR_ZPX,`LSR_ABS,`LSR_ABSX: begin cf <= resc32; nf <= resn32; zf <= resz32; end
				`ROR_ZPX,`ROR_ABS,`ROR_ABSX: begin cf <= resc32; nf <= resn32; zf <= resz32; end
				`ASL_IMM8: begin nf <= resn32; zf <= resz32; end
				`LSR_IMM8: begin nf <= resn32; zf <= resz32; end
				`INC_ZPX,`INC_ABS,`INC_ABSX: begin nf <= resn32; zf <= resz32; end
				`DEC_ZPX,`DEC_ABS,`DEC_ABSX: begin nf <= resn32; zf <= resz32; end
				`PLA:	begin acc <= res; zf <= resz32; nf <= resn32; end
				`PLX:	begin x <= res; zf <= resz32; nf <= resn32; end
				`PLY:	begin y <= res; zf <= resz32; nf <= resn32; end
				`LDX_IMM32,`LDX_IMM16,`LDX_IMM8,`LDX_ZPY,`LDX_ABS,`LDX_ABSY:	begin x <= res; nf <= resn32; zf <= resz32; end
				`LDY_IMM32,`LDY_ZPX,`LDY_ABS,`LDY_ABSX:	begin y <= res; nf <= resn32; zf <= resz32; end
				`CPX_IMM32,`CPX_ZPX,`CPX_ABS:	begin cf <= ~resc32; nf <= resn32; zf <= resz32; end
				`CPY_IMM32,`CPY_ZPX,`CPY_ABS:	begin cf <= ~resc32; nf <= resn32; zf <= resz32; end
				`CMP_IMM8: begin cf <= ~resc32; nf <= resn32; zf <= resz32; end
				`LDA_IMM32,`LDA_IMM16,`LDA_IMM8:	begin acc <= res; nf <= resn32; zf <= resz32; end
				endcase
			end
		end
	end
DECODE:
	begin
	first_ifetch <= `TRUE;
	Rt <= 4'h0;		// Default
	if (em) begin
		state <= IFETCH;
		case(ir[7:0])
		`STP:	begin clk_en <= 1'b0; pc <= pc + 32'd1; end
		`NAT:	pc <= pc + 32'd1;
		`NOP:	pc <= pc + 32'd1;
		`CLC:	begin cf <= 1'b0; pc <= pc + 32'd1; end
		`SEC:	begin cf <= 1'b1; pc <= pc + 32'd1; end
		`CLV:	begin vf <= 1'b0; pc <= pc + 32'd1; end
		`CLI:	begin im <= 1'b0; pc <= pc + 32'd1; end
		`SEI:	begin im <= 1'b1; pc <= pc + 32'd1; end
		`CLD:	begin df <= 1'b0; pc <= pc + 32'd1; end
		`SED:	begin df <= 1'b1; pc <= pc + 32'd1; end
		`WAI:	begin wai <= 1'b1; pc <= pc + 32'd1; end
		`DEX:	begin res8 <= x[7:0] - 8'd1; pc <= pc + 32'd1; end
		`INX:	begin res8 <= x[7:0] + 8'd1; pc <= pc + 32'd1; end
		`DEY:	begin res8 <= y[7:0] - 8'd1; pc <= pc + 32'd1; end
		`INY:	begin res8 <= y[7:0] + 8'd1; pc <= pc + 32'd1; end
		`DEA:	begin res8 <= acc[7:0] - 8'd1; pc <= pc + 32'd1; end
		`INA:	begin res8 <= acc[7:0] + 8'd1; pc <= pc + 32'd1; end
		`TSX,`TSA:	begin res8 <= sp[7:0]; pc <= pc + 32'd1; end
		`TXS,`TXA,`TXY:	begin res8 <= x[7:0]; pc <= pc + 32'd1; end
		`TAX,`TAY,`TAS:	begin res8 <= acc[7:0]; pc <= pc + 32'd1; end
		`TYA,`TYX:	begin res8 <= y[7:0]; pc <= pc + 32'd1; end
		`ASL_ACC:	begin res8 <= {acc8,1'b0}; pc <= pc + 32'd1; end
		`ROL_ACC:	begin res8 <= {acc8,cf}; pc <= pc + 32'd1; end
		`LSR_ACC:	begin res8 <= {acc8[0],1'b0,acc8[7:1]}; pc <= pc + 32'd1; end
		`ROR_ACC:	begin res8 <= {acc8[0],cf,acc8[7:1]}; pc <= pc + 32'd1; end
		// Handle # mode
		`LDA_IMM,`LDX_IMM,`LDY_IMM:
			begin
				pc <= pc + 32'd2;
				res8 <= ir[15:8];
				state <= IFETCH;
			end
		`ADC_IMM:
			begin
				pc <= pc + 32'd2;
				res8 <= acc8 + ir[15:8] + {7'b0,cf};
				b8 <= ir[15:8];		// for overflow calc
				state <= IFETCH;
			end
		`SBC_IMM:
			begin
				pc <= pc + 32'd2;
//				res8 <= acc8 - ir[15:8] - ~cf;
				res8 <= acc8 - ir[15:8] - {7'b0,~cf};
				$display("sbc: %h= %h-%h-%h", acc8 - ir[15:8] - {7'b0,~cf},acc8,ir[15:8],~cf);
				b8 <= ir[15:8];		// for overflow calc
				state <= IFETCH;
			end
		`AND_IMM,`BIT_IMM:
			begin
				pc <= pc + 32'd2;
				res8 <= acc8 & ir[15:8];
				b8 <= ir[15:8];	// for bit flags
				state <= IFETCH;
			end
		`ORA_IMM:
			begin
				pc <= pc + 32'd2;
				res8 <= acc8 | ir[15:8];
				state <= IFETCH;
			end
		`EOR_IMM:
			begin
				pc <= pc + 32'd2;
				res8 <= acc8 ^ ir[15:8];
				state <= IFETCH;
			end
		`CMP_IMM:
			begin
				pc <= pc + 32'd2;
				res8 <= acc8 - ir[15:8];
				state <= IFETCH;
			end
		`CPX_IMM:
			begin
				pc <= pc + 32'd2;
				res8 <= x8 - ir[15:8];
				state <= IFETCH;
			end
		`CPY_IMM:
			begin
				pc <= pc + 32'd2;
				res8 <= y8 - ir[15:8];
				state <= IFETCH;
			end
		// Handle zp mode
		`ADC_ZP,`SBC_ZP,`AND_ZP,`ORA_ZP,`EOR_ZP,`CMP_ZP,`LDA_ZP,
		`LDX_ZP,`LDY_ZP,`BIT_ZP,`CPX_ZP,`CPY_ZP,
		`ASL_ZP,`ROL_ZP,`LSR_ZP,`ROR_ZP,`INC_ZP,`DEC_ZP,`TRB_ZP,`TSB_ZP:
			begin
				pc <= pc + 32'd2;
				radr <= zp_address[31:2];
				radr2LSB <= zp_address[1:0];
				state <= LOAD1;
			end
		`STA_ZP:
			begin
				pc <= pc + 32'd2;
				wadr <= zp_address[31:2];
				wadr2LSB <= zp_address[1:0];
				wdat <= {4{acc8}};
				state <= STORE1;
			end
		`STX_ZP:
			begin
				pc <= pc + 32'd2;
				wadr <= zp_address[31:2];
				wadr2LSB <= zp_address[1:0];
				wdat <= {4{x8}};
				state <= STORE1;
			end
		`STY_ZP:
			begin
				pc <= pc + 32'd2;
				wadr <= zp_address[31:2];
				wadr2LSB <= zp_address[1:0];
				wdat <= {4{y8}};
				state <= STORE1;
			end
		`STZ_ZP:
			begin
				pc <= pc + 32'd2;
				wadr <= zp_address[31:2];
				wadr2LSB <= zp_address[1:0];
				wdat <= {4{8'h00}};
				state <= STORE1;
			end
		// Handle zp,x mode
		`ADC_ZPX,`SBC_ZPX,`AND_ZPX,`ORA_ZPX,`EOR_ZPX,`CMP_ZPX,`LDA_ZPX,
		`LDY_ZPX,`BIT_ZPX,
		`ASL_ZPX,`ROL_ZPX,`LSR_ZPX,`ROR_ZPX,`INC_ZPX,`DEC_ZPX:
			begin
				pc <= pc + 32'd2;
				radr <= zpx_address[31:2];
				radr2LSB <= zpx_address[1:0];
				state <= LOAD1;
			end
		`STA_ZPX:
			begin
				pc <= pc + 32'd2;
				wadr <= zpx_address[31:2];
				wadr2LSB <= zpx_address[1:0];
				wdat <= {4{acc8}};
				state <= STORE1;
			end
		`STY_ZPX:
			begin
				pc <= pc + 32'd2;
				wadr <= zpx_address[31:2];
				wadr2LSB <= zpx_address[1:0];
				wdat <= {4{y8}};
				state <= STORE1;
			end
		`STZ_ZPX:
			begin
				pc <= pc + 32'd2;
				wadr <= zpx_address[31:2];
				wadr2LSB <= zpx_address[1:0];
				wdat <= {4{8'h00}};
				state <= STORE1;
			end
		// Handle zp,y
		`LDX_ZPY:
			begin
				pc <= pc + 32'd2;
				radr <= zpy_address[31:2];
				radr2LSB <= zpy_address[1:0];
				state <= LOAD1;
			end
		`STX_ZPY:
			begin
				pc <= pc + 32'd2;
				wadr <= zpy_address[31:2];
				wadr2LSB <= zpy_address[1:0];
				wdat <= {4{x8}};
				state <= STORE1;
			end
		// Handle (zp,x)
		`ADC_IX,`SBC_IX,`AND_IX,`ORA_IX,`EOR_IX,`CMP_IX,`LDA_IX,`STA_IX:
			begin
				pc <= pc + 32'd2;
				radr <= zpx_address[31:2];
				radr2LSB <= zpx_address[1:0];
				state <= BYTE_IX1;
			end
		// Handle (zp),y
		`ADC_IY,`SBC_IY,`AND_IY,`ORA_IY,`EOR_IY,`CMP_IY,`LDA_IY,`STA_IY:
			begin
				pc <= pc + 32'd2;
				radr <= zp_address[31:2];
				radr2LSB <= zp_address[1:0];
				state <= BYTE_IY1;
			end
		// Handle abs
		`ADC_ABS,`SBC_ABS,`AND_ABS,`ORA_ABS,`EOR_ABS,`CMP_ABS,`LDA_ABS,
		`ASL_ABS,`ROL_ABS,`LSR_ABS,`ROR_ABS,`INC_ABS,`DEC_ABS,`TRB_ABS,`TSB_ABS,
		`LDX_ABS,`LDY_ABS,
		`CPX_ABS,`CPY_ABS,
		`BIT_ABS:
			begin
				pc <= pc + 32'd3;
				radr <= abs_address[31:2];
				radr2LSB <= abs_address[1:0];
				state <= LOAD1;
			end
		`STA_ABS:
			begin
				pc <= pc + 32'd3;
				wadr <= abs_address[31:2];
				wadr2LSB <= abs_address[1:0];
				wdat <= {4{acc8}};
				state <= STORE1;
			end
		`STX_ABS:
			begin
				pc <= pc + 32'd3;
				wadr <= abs_address[31:2];
				wadr2LSB <= abs_address[1:0];
				wdat <= {4{x8}};
				state <= STORE1;
			end	
		`STY_ABS:
			begin
				pc <= pc + 32'd3;
				wadr <= abs_address[31:2];
				wadr2LSB <= abs_address[1:0];
				wdat <= {4{y8}};
				state <= STORE1;
			end
		`STZ_ABS:
			begin
				pc <= pc + 32'd3;
				wadr <= abs_address[31:2];
				wadr2LSB <= abs_address[1:0];
				wdat <= {4{8'h00}};
				state <= STORE1;
			end
		// Handle abs,x
		`ADC_ABSX,`SBC_ABSX,`AND_ABSX,`ORA_ABSX,`EOR_ABSX,`CMP_ABSX,`LDA_ABSX,
		`ASL_ABSX,`ROL_ABSX,`LSR_ABSX,`ROR_ABSX,`INC_ABSX,`DEC_ABSX,`BIT_ABSX,
		`LDY_ABSX:
			begin
				pc <= pc + 32'd3;
				radr <= absx_address[31:2];
				radr2LSB <= absx_address[1:0];
				state <= LOAD1;
			end
		`STA_ABSX:
			begin
				pc <= pc + 32'd3;
				wadr <= absx_address[31:2];
				wadr2LSB <= absx_address[1:0];
				wdat <= {4{acc8}};
				state <= STORE1;
			end
		`STZ_ABSX:
			begin
				pc <= pc + 32'd3;
				wadr <= absx_address[31:2];
				wadr2LSB <= absx_address[1:0];
				wdat <= {4{8'h00}};
				state <= STORE1;
			end
		// Handle abs,y
		`ADC_ABSY,`SBC_ABSY,`AND_ABSY,`ORA_ABSY,`EOR_ABSY,`CMP_ABSY,`LDA_ABSY,
		`LDX_ABSY:
			begin
				pc <= pc + 32'd3;
				radr <= absy_address[31:2];
				radr2LSB <= absy_address[1:0];
				state <= LOAD1;
			end
		`STA_ABSY:
			begin
				pc <= pc + 32'd3;
				wadr <= absy_address[31:2];
				wadr2LSB <= absy_address[1:0];
				wdat <= {4{acc8}};
				state <= STORE1;
			end
		// Handle (zp)
		`ADC_I,`SBC_I,`AND_I,`ORA_I,`EOR_I,`CMP_I,`LDA_I,`STA_I:
			begin
				pc <= pc + 32'd2;
				radr <= zp_address[31:2];
				radr2LSB <= zp_address[1:0];
				state <= BYTE_IX1;
			end
		`BRK:
			begin
				radr <= {spage[31:8],sp[7:2]};
				radr2LSB <= sp[1:0];
				wadr <= {spage[31:8],sp[7:2]};
				wadr2LSB <= sp[1:0];
				wdat <= {4{pcp1[31:24]}};
				cyc_o <= 1'b1;
				stb_o <= 1'b1;
				we_o <= 1'b1;
				case(sp[1:0])
				2'd0:	sel_o <= 4'b0001;
				2'd1:	sel_o <= 4'b0010;
				2'd2:	sel_o <= 4'b0100;
				2'd3:	sel_o <= 4'b1000;
				endcase
				adr_o <= {spage[31:8],sp[7:2],2'b00};
				dat_o <= {4{pcp1[31:24]}};
				sp <= sp_dec;
				vect <= `BYTE_IRQ_VECT;
				state <= BYTE_IRQ1;
				bf <= 1'b1;
			end
		`JMP:
			begin
				pc[15:0] <= abs_address[15:0];
				state <= IFETCH;
			end
		`JML:
			begin
				pc <= ir[39:8];
				state <= IFETCH;
			end
		`JMP_IND:
			begin
				radr <= abs_address[31:2];
				radr2LSB <= abs_address[1:0];
				state <= BYTE_JMP_IND1;
			end
		`JMP_INDX:
			begin
				radr <= absx_address[31:2];
				radr2LSB <= absx_address[1:0];
				state <= BYTE_JMP_IND1;
			end	
		`JSR:
			begin
				radr <= {spage[31:8],sp[7:2]};
				wadr <= {spage[31:8],sp[7:2]};
				radr2LSB <= sp[1:0];
				wadr2LSB <= sp[1:0];
				wdat <= {4{pcp2[15:8]}};
				cyc_o <= 1'b1;
				stb_o <= 1'b1;
				we_o <= 1'b1;
				case(sp[1:0])
				2'd0:	sel_o <= 4'b0001;
				2'd1:	sel_o <= 4'b0010;
				2'd2:	sel_o <= 4'b0100;
				2'd3:	sel_o <= 4'b1000;
				endcase
				adr_o <= {spage[31:8],sp[7:2],2'b00};
				dat_o <= {4{pcp2[15:8]}};
				sp <= sp_dec;
				state <= BYTE_JSR1;
			end
		`JSL:
			begin
				radr <= {spage[31:8],sp[7:2]};
				wadr <= {spage[31:8],sp[7:2]};
				radr2LSB <= sp[1:0];
				wadr2LSB <= sp[1:0];
				wdat <= {4{pcp4[31:24]}};
				cyc_o <= 1'b1;
				stb_o <= 1'b1;
				we_o <= 1'b1;
				case(sp[1:0])
				2'd0:	sel_o <= 4'b0001;
				2'd1:	sel_o <= 4'b0010;
				2'd2:	sel_o <= 4'b0100;
				2'd3:	sel_o <= 4'b1000;
				endcase
				adr_o <= {spage[31:8],sp[7:2],2'b00};
				dat_o <= {4{pcp4[31:24]}};
				sp <= sp_dec;
				state <= BYTE_JSL1;
			end
		`JSR_INDX:
			begin
				radr <= {spage[31:8],sp[7:2]};
				wadr <= {spage[31:8],sp[7:2]};
				radr2LSB <= sp[1:0];
				wadr2LSB <= sp[1:0];
				wdat <= {4{pcp2[15:8]}};
				cyc_o <= 1'b1;
				stb_o <= 1'b1;
				we_o <= 1'b1;
				case(sp_dec[1:0])
				2'd0:	sel_o <= 4'b0001;
				2'd1:	sel_o <= 4'b0010;
				2'd2:	sel_o <= 4'b0100;
				2'd3:	sel_o <= 4'b1000;
				endcase
				adr_o <= {spage[31:8],sp[7:2],2'b00};
				dat_o <= {4{pcp2[15:8]}};
				sp <= sp_dec;
				state <= BYTE_JSR_INDX1;
			end
		`RTS,`RTL:
			begin
				radr <= {spage[31:8],sp_inc[7:2]};
				radr2LSB <= sp_inc[1:0];
				sp <= sp_inc;
				state <= BYTE_RTS1;
			end
		`RTI:	begin
				radr <= {spage[31:8],sp_inc[7:2]};
				radr2LSB <= sp_inc[1:0];
				sp <= sp_inc;
				state <= BYTE_RTI9;
				end
		`BEQ,`BNE,`BPL,`BMI,`BCC,`BCS,`BVC,`BVS,`BRA:
			begin
				state <= IFETCH;
//				if (ir[15:8]==8'hFE) begin
//					radr <= {24'h1,sp[7:2]};
//					radr2LSB <= sp[1:0];
//					wadr <= {24'h1,sp[7:2]};
//					wadr2LSB <= sp[1:0];
//					case(sp[1:0])
//					2'd0:	sel_o <= 4'b0001;
//					2'd1:	sel_o <= 4'b0010;
//					2'd2:	sel_o <= 4'b0100;
//					2'd3:	sel_o <= 4'b1000;
//					endcase
//					wdat <= {4{pcp2[31:24]}};
//					cyc_o <= 1'b1;
//					stb_o <= 1'b1;
//					we_o <= 1'b1;
//					adr_o <= {24'h1,sp[7:2],2'b00};
//					dat_o <= {4{pcp2[31:24]}};
//					vect <= `SLP_VECT;
//					state <= BYTE_IRQ1;
//				end
//				else
				if (ir[15:8]==8'hFF) begin
					if (takb)
						pc <= pc + {{16{ir[31]}},ir[31:16]};
					else
						pc <= pc + 32'd4;
				end
				else begin
					if (takb)
						pc <= pc + {{24{ir[15]}},ir[15:8]} + 32'd2;
					else
						pc <= pc + 32'd2;
				end
			end
		`PHP:
			begin
				cyc_o <= 1'b1;
				stb_o <= 1'b1;
				we_o <= 1'b1;
				radr <= {spage[31:8],sp[7:2]};
				radr2LSB <= sp[1:0];
				wadr <= {spage[31:8],sp[7:2]};
				wadr2LSB <= sp[1:0];
				case(sp[1:0])
				2'd0:	sel_o <= 4'b0001;
				2'd1:	sel_o <= 4'b0010;
				2'd2:	sel_o <= 4'b0100;
				2'd3:	sel_o <= 4'b1000;
				endcase
				adr_o <= {spage[31:8],sp[7:2],2'b00};
				dat_o <= {4{sr8}};
				wdat <= {4{sr8}};
				sp <= sp_dec;
				state <= PHP1;
			end
		`PHA:
			begin
				cyc_o <= 1'b1;
				stb_o <= 1'b1;
				we_o <= 1'b1;
				radr <= {spage[31:8],sp[7:2]};
				radr2LSB <= sp[1:0];
				wadr <= {spage[31:8],sp[7:2]};
				wadr2LSB <= sp[1:0];
				case(sp[1:0])
				2'd0:	sel_o <= 4'b0001;
				2'd1:	sel_o <= 4'b0010;
				2'd2:	sel_o <= 4'b0100;
				2'd3:	sel_o <= 4'b1000;
				endcase
				adr_o <= {spage[31:8],sp[7:2],2'b00};
				dat_o <= {4{acc8}};
				wdat <= {4{acc8}};
				sp <= sp_dec;
				state <= PHP1;
			end
		`PHX:
			begin
				cyc_o <= 1'b1;
				stb_o <= 1'b1;
				we_o <= 1'b1;
				radr <= {spage[31:8],sp[7:2]};
				radr2LSB <= sp[1:0];
				wadr <= {spage[31:8],sp[7:2]};
				wadr2LSB <= sp[1:0];
				case(sp[1:0])
				2'd0:	sel_o <= 4'b0001;
				2'd1:	sel_o <= 4'b0010;
				2'd2:	sel_o <= 4'b0100;
				2'd3:	sel_o <= 4'b1000;
				endcase
				adr_o <= {spage[31:8],sp[7:2],2'b00};
				dat_o <= {4{x8}};
				wdat <= {4{x8}};
				sp <= sp_dec;
				state <= PHP1;
			end
		`PHY:
			begin
				cyc_o <= 1'b1;
				stb_o <= 1'b1;
				we_o <= 1'b1;
				radr <= {spage[31:8],sp[7:2]};
				radr2LSB <= sp[1:0];
				wadr <= {spage[31:8],sp[7:2]};
				wadr2LSB <= sp[1:0];
				case(sp[1:0])
				2'd0:	sel_o <= 4'b0001;
				2'd1:	sel_o <= 4'b0010;
				2'd2:	sel_o <= 4'b0100;
				2'd3:	sel_o <= 4'b1000;
				endcase
				adr_o <= {spage[31:8],sp[7:2],2'b00};
				dat_o <= {4{y8}};
				wdat <= {4{y8}};
				sp <= sp_dec;
				state <= PHP1;
			end
		`PLP:
			begin
				radr <= {spage[31:8],sp_inc[7:2]};
				radr2LSB <= sp_inc[1:0];
				sp <= sp_inc;
				state <= BYTE_PLP1;
				pc <= pc + 32'd1;
			end
		`PLA,`PLX,`PLY:
			begin
				radr <= {spage[31:8],sp_inc[7:2]};
				radr2LSB <= sp_inc[1:0];
				sp <= sp_inc;
				state <= PLA1;
				pc <= pc + 32'd1;
			end
		default:	// unimplemented opcode
			pc <= pc + 32'd1;
		endcase
	end
	else begin
		state <= IFETCH;
		case(ir[7:0])
		`STP:	begin clk_en <= 1'b0; pc <= pc + 32'd1; end
		`NOP:	begin pc <= pc + 32'd1; end
		`CLC:	begin cf <= 1'b0; pc <= pc + 32'd1; end
		`SEC:	begin cf <= 1'b1; pc <= pc + 32'd1; end
		`CLV:	begin vf <= 1'b0; pc <= pc + 32'd1; end
		`CLI:	begin im <= 1'b0; pc <= pc + 32'd1; end
		`CLD:	begin df <= 1'b0; pc <= pc + 32'd1; end
		`SED:	begin df <= 1'b1; pc <= pc + 32'd1; end
		`SEI:	begin im <= 1'b1; pc <= pc + 32'd1; end
		`WAI:	begin wai <= 1'b1; pc <= pc + 32'd1; end
		`EMM:	begin pc <= pc + 32'd1; end
		`DEX:	begin res <= x - 32'd1; pc <= pc + 32'd1; end
		`INX:	begin res <= x + 32'd1; pc <= pc + 32'd1; end
		`DEY:	begin res <= y - 32'd1; pc <= pc + 32'd1; end
		`INY:	begin res <= y + 32'd1; pc <= pc + 32'd1; end
		`DEA:	begin res <= acc - 32'd1; pc <= pc + 32'd1; end
		`INA:	begin res <= acc + 32'd1; pc <= pc + 32'd1; end
		`TSX:	begin res <= isp; pc <= pc + 32'd1; end
		`TXS,`TXA,`TXY:	begin res <= x; pc <= pc + 32'd1; end
		`TAX,`TAY,`TAS:	begin res <= acc; pc <= pc + 32'd1; end
		`TYA,`TYX:	begin res <= y; pc <= pc + 32'd1; end
		`TRS:		begin 
						res <= rfoa; pc <= pc + 32'd2; end
		`TSR:		begin
						Rt <= ir[15:12];
						case(ir[11:8])
						4'h0:	res <= {write_allocate,dcacheOn,icacheOn};
						4'h1:	res <= dp;
						4'h2:	res <= prod[31:0];
						4'h3:	res <= prod[63:32];
						4'h4:	res <= tick;
						4'h5:	begin res <= lfsr; lfsr <= {lfsr[30:0],lfsr_fb}; end
						4'h6:	res <= dp8;
						4'h7:	res <= abs8;
						4'h8:	res <= {vbr[31:1],nmoi};
						4'hE:	res <= {spage[31:8],sp};
						4'hF:	res <= isp;
						endcase
						pc <= pc + 32'd2;
					end
		`ASL_ACC:	begin res <= {acc,1'b0}; pc <= pc + 32'd1; end
		`ROL_ACC:	begin res <= {acc,cf}; pc <= pc + 32'd1; end
		`LSR_ACC:	begin res <= {acc[0],1'b0,acc[31:1]}; pc <= pc + 32'd1; end
		`ROR_ACC:	begin res <= {acc[0],cf,acc[31:1]}; pc <= pc + 32'd1; end

		`RR:
			begin
				state <= IFETCH;
				case(ir[23:20])
				`ADD_RR:	begin res <= rfoa + rfob; a <= rfoa; b <= rfob; end
				`SUB_RR:	begin res <= rfoa - rfob; a <= rfoa; b <= rfob; end
				`AND_RR:	begin res <= rfoa & rfob; a <= rfoa; b <= rfob; end	// for bit flags
				`OR_RR:		begin res <= rfoa | rfob; a <= rfoa; b <= rfob; end
				`EOR_RR:	begin res <= rfoa ^ rfob; a <= rfoa; b <= rfob; end
				`MUL_RR:	begin state <= MULDIV1; end
				`MULS_RR:	begin state <= MULDIV1; end
				`DIV_RR:	begin state <= MULDIV1; end
				`DIVS_RR:	begin state <= MULDIV1; end
				`MOD_RR:	begin state <= MULDIV1; end
				`MODS_RR:	begin state <= MULDIV1; end
				`ASL_RRR:	begin a <= rfoa; b <= rfob; state <= CALC; end
				`LSR_RRR:	begin a <= rfoa; b <= rfob; state <= CALC; end
				endcase
				Rt <= ir[19:16];
				pc <= pc + 32'd3;
			end
		`LD_RR:		begin res <= rfoa; Rt <= ir[15:12]; pc <= pc + 32'd2; end
		`ASL_RR:	begin res <= {rfoa,1'b0}; pc <= pc + 32'd2; Rt <= ir[15:12]; end
		`ROL_RR:	begin res <= {rfoa,cf}; pc <= pc + 32'd2; Rt <= ir[15:12]; end
		`LSR_RR:	begin res <= {rfoa[0],1'b0,rfoa[31:1]}; pc <= pc + 32'd2; Rt <= ir[15:12]; end
		`ROR_RR:	begin res <= {rfoa[0],cf,rfoa[31:1]}; pc <= pc + 32'd2; Rt <= ir[15:12]; end
		`DEC_RR:	begin res <= rfoa - 32'd1; pc <= pc + 32'd2; Rt <= ir[15:12]; end
		`INC_RR:	begin res <= rfoa + 32'd1; pc <= pc + 32'd2; Rt <= ir[15:12]; end

		`ADD_IMM8:	begin res <= rfoa + {{24{ir[23]}},ir[23:16]}; Rt <= ir[15:12]; pc <= pc + 32'd3; a <= rfoa; b <= {{24{ir[23]}},ir[23:16]}; end
		`SUB_IMM8:	begin res <= rfoa - {{24{ir[23]}},ir[23:16]}; Rt <= ir[15:12]; pc <= pc + 32'd3; a <= rfoa; b <= {{24{ir[23]}},ir[23:16]}; end
		`OR_IMM8:	begin res <= rfoa | {{24{ir[23]}},ir[23:16]}; Rt <= ir[15:12]; pc <= pc + 32'd3; b <= {{24{ir[23]}},ir[23:16]}; end
		`AND_IMM8: 	begin res <= rfoa & {{24{ir[23]}},ir[23:16]}; Rt <= ir[15:12]; pc <= pc + 32'd3; b <= {{24{ir[23]}},ir[23:16]}; end
		`EOR_IMM8:	begin res <= rfoa ^ {{24{ir[23]}},ir[23:16]}; Rt <= ir[15:12]; pc <= pc + 32'd3; b <= {{24{ir[23]}},ir[23:16]}; end
		`CMP_IMM8:	begin res <= acc - {{24{ir[15]}},ir[15:8]}; Rt <= 4'h0; pc <= pc + 32'd2; b <= {{24{ir[15]}},ir[15:8]}; end
		`ASL_IMM8:	begin a <= rfoa; b <= ir[20:16]; Rt <= ir[15:12]; pc <= pc + 32'd3; state <= CALC; end
		`LSR_IMM8:	begin a <= rfoa; b <= ir[20:16]; Rt <= ir[15:12]; pc <= pc + 32'd3; state <= CALC; end

		`ADD_IMM16:	begin res <= rfoa + {{16{ir[31]}},ir[31:16]}; Rt <= ir[15:12]; pc <= pc + 32'd4; a <= rfoa; b <= {{16{ir[31]}},ir[31:16]}; end
		`SUB_IMM16:	begin res <= rfoa - {{16{ir[31]}},ir[31:16]}; Rt <= ir[15:12]; pc <= pc + 32'd4; a <= rfoa; b <= {{16{ir[31]}},ir[31:16]}; end
		`OR_IMM16:	begin res <= rfoa | {{16{ir[31]}},ir[31:16]}; Rt <= ir[15:12]; pc <= pc + 32'd4; b <= {{16{ir[31]}},ir[31:16]}; end
		`AND_IMM16:	begin res <= rfoa & {{16{ir[31]}},ir[31:16]}; Rt <= ir[15:12]; pc <= pc + 32'd4; b <= {{16{ir[31]}},ir[31:16]}; end
		`EOR_IMM16:	begin res <= rfoa ^ {{16{ir[31]}},ir[31:16]}; Rt <= ir[15:12]; pc <= pc + 32'd4; b <= {{16{ir[31]}},ir[31:16]}; end
	
		`ADD_IMM32:	begin res <= rfoa + ir[47:16]; Rt <= ir[15:12]; pc <= pc + 32'd6; a <= rfoa; b <= ir[47:16]; end
		`SUB_IMM32:	begin res <= rfoa - ir[47:16]; Rt <= ir[15:12]; pc <= pc + 32'd6; a <= rfoa; b <= ir[47:16]; end
		`OR_IMM32:	begin res <= rfoa | ir[47:16]; Rt <= ir[15:12]; pc <= pc + 32'd6; b <= ir[47:16]; end
		`AND_IMM32:	begin res <= rfoa & ir[47:16]; Rt <= ir[15:12]; pc <= pc + 32'd6; b <= ir[47:16]; end
		`EOR_IMM32:	begin res <= rfoa ^ ir[47:16]; Rt <= ir[15:12]; pc <= pc + 32'd6; b <= ir[47:16]; end

		`LDX_IMM32,`LDY_IMM32,`LDA_IMM32:	begin res <= ir[39:8]; pc <= pc + 32'd5; end
		`LDX_IMM16,`LDA_IMM16:	begin res <= {{16{ir[23]}},ir[23:8]}; pc <= pc + 32'd3; end
		`LDX_IMM8,`LDA_IMM8: begin res <= {{24{ir[15]}},ir[15:8]}; pc <= pc + 32'd2; end

		`LDX_ZPX,`LDY_ZPX:
			begin
				radr <= zpx32xy_address;
				pc <= pc + 32'd3;
				state <= LOAD1;
			end
		`ORB_ZPX:
			begin
				a <= rfoa;
				Rt <= ir[19:16];
				radr <= zpx32_address[31:2];
				radr2LSB <= zpx32_address[1:0];
				pc <= pc + 32'd4;
				state <= LOAD1;
			end
		`LDX_ABS,`LDY_ABS:
			begin
				radr <= ir[39:8];
				pc <= pc + 32'd5;
				state <= LOAD1;
			end
		`ORB_ABS:
			begin
				a <= rfoa;
				Rt <= ir[15:12];
				radr <= ir[47:18];
				radr2LSB <= ir[17:16];
				pc <= pc + 32'd6;
				state <= LOAD1;
			end
		`LDX_ABSY,`LDY_ABSX:
			begin
				radr <= absx32xy_address;
				pc <= pc + 32'd6;
				state <= LOAD1;
			end
		`ORB_ABSX:
			begin
				a <= rfoa;
				Rt <= ir[19:16];
				radr <= absx32_address[31:2];
				radr2LSB <= absx32_address[1:0];
				pc <= pc + 32'd7;
				state <= LOAD1;
			end
		`ST_ZPX:
			begin
				wadr <= zpx32_address;
				wdat <= rfoa;
				pc <= pc + 32'd4;
				state <= STORE1;
			end
		`STB_ZPX:
			begin
				wadr <= zpx32_address[31:2];
				wadr2LSB <= zpx32_address[1:0];
				pc <= pc + 32'd4;
				state <= STORE1;
			end
		`ST_ABS:
			begin
				wadr <= ir[47:16];
				wdat <= rfoa;
				pc <= pc + 32'd6;
				state <= STORE1;
			end
		`STB_ABS:
			begin
				wadr <= ir[47:18];
				wadr2LSB <= ir[17:16];
				wdat <= {4{rfoa[7:0]}};
				pc <= pc + 32'd6;
				state <= STORE1;
			end
		`ST_ABSX:
			begin
				wadr <= absx32_address;
				wdat <= rfoa;
				pc <= pc + 32'd7;
				state <= STORE1;
			end
		`STB_ABSX:
			begin
				wadr <= absx32_address[31:2];
				wadr2LSB <= absx32_address[1:0];
				wdat <= {4{rfoa[7:0]}};
				pc <= pc + 32'd7;
				state <= STORE1;
			end
		`STX_ZPX:
			begin
				wadr <= dp + ir[23:12] + rfoa;
				wdat <= x;
				pc <= pc + 32'd3;
				state <= STORE1;
			end
		`STX_ABS:
			begin
				wadr <= ir[39:8];
				wdat <= x;
				pc <= pc + 32'd5;
				state <= STORE1;
			end
		`STY_ZPX:
			begin
				wadr <= dp + ir[23:12] + rfoa;
				wdat <= y;
				pc <= pc + 32'd3;
				state <= STORE1;
			end
		`STY_ABS:
			begin
				wadr <= ir[39:8];
				wdat <= y;
				pc <= pc + 32'd5;
				state <= STORE1;
			end
		`ADD_ZPX,`SUB_ZPX,`OR_ZPX,`AND_ZPX,`EOR_ZPX:
			begin
				a <= rfoa;
				Rt <= ir[19:16];
				radr <= zpx32_address;
				pc <= pc + 32'd4;
				state <= LOAD1;			
			end
		`ASL_ZPX,`ROL_ZPX,`LSR_ZPX,`ROR_ZPX,`INC_ZPX,`DEC_ZPX:
			begin
				radr <= dp + rfoa + ir[23:12];
				pc <= pc + 32'd3;
				state <= LOAD1;
			end
		`ADD_IX,`SUB_IX,`OR_IX,`AND_IX,`EOR_IX,`ST_IX:
			begin
				a <= rfoa;
				if (ir[7:0]==`ST_IX)
					res <= rfoa;		// for ST_IX, Rt=0
				else
					Rt <= ir[19:16];
				pc <= pc + 32'd4;
				radr <= dp + ir[31:20] + rfob;
				state <= IX1;			
			end
		`ADD_RIND,`SUB_RIND,`OR_RIND,`AND_RIND,`EOR_RIND,`ST_RIND:
			begin
				radr <= rfob;
				wadr <= rfob;		// for store
				wdat <= rfoa;
				a <= rfoa;
				if (ir[7:0]==`ST_RIND) begin
					res <= rfoa;		// for ST_IX, Rt=0
					pc <= pc + 32'd2;
					state <= STORE1;
				end
				else begin
					Rt <= ir[19:16];
					pc <= pc + 32'd3;
					state <= LOAD1;			
				end
			end
		`ADD_IY,`SUB_IY,`OR_IY,`AND_IY,`EOR_IY,`ST_IY:
			begin
				a <= rfoa;
				if (ir[7:0]==`ST_IY)
					res <= rfoa;		// for ST_IY, Rt=0
				else
					Rt <= ir[19:16];
				pc <= pc + 32'd4;
				radr <= dp + ir[31:20];
				state <= IY1;	
			end
		`ADD_ABS,`SUB_ABS,`OR_ABS,`AND_ABS,`EOR_ABS:
			begin
				a <= rfoa;
				radr <= ir[47:16];
				Rt <= ir[15:12];
				pc <= pc + 32'd6;
				state <= LOAD1;			
			end
		`ASL_ABS,`ROL_ABS,`LSR_ABS,`ROR_ABS,`INC_ABS,`DEC_ABS:
			begin
				radr <= ir[39:8];
				pc <= pc + 32'd5;
				state <= LOAD1;
			end
		`ADD_ABSX,`SUB_ABSX,`OR_ABSX,`AND_ABSX,`EOR_ABSX:
			begin
				a <= rfoa;
				radr <= ir[55:24] + rfob;
				Rt <= ir[19:16];
				pc <= pc + 32'd7;
				state <= LOAD1;			
			end
		`ASL_ABSX,`ROL_ABSX,`LSR_ABSX,`ROR_ABSX,`INC_ABSX,`DEC_ABSX:
			begin
				radr <= ir[47:16] + rfob;
				pc <= pc + 32'd6;
				state <= LOAD1;
			end
		`CPX_IMM32:
			begin
				res <= x - ir[39:8];
				pc <= pc + 32'd5;
				state <= IFETCH;
			end
		`CPY_IMM32:
			begin
				res <= y - ir[39:8];
				pc <= pc + 32'd5;
				state <= IFETCH;
			end
		`CPX_ZPX:
			begin
				radr <= dp + ir[23:12] + rfoa;
				pc <= pc + 32'd3;
				state <= LOAD1;
			end
		`CPY_ZPX:
			begin
				radr <= dp + ir[23:12] + rfoa;
				pc <= pc + 32'd3;
				state <= LOAD1;
			end
		`CPX_ABS:
			begin
				radr <= ir[39:8];
				pc <= pc + 32'd5;
				state <= LOAD1;
			end
		`CPY_ABS:
			begin
				radr <= ir[39:8];
				pc <= pc + 32'd5;
				state <= LOAD1;
			end
		`BRK:
			begin
				bf <= 1'b1;
				radr <= isp_dec;
				wadr <= isp_dec;
				wdat <= pc + 32'd1;
				cyc_o <= 1'b1;
				stb_o <= 1'b1;
				we_o <= 1'b1;
				sel_o <= 4'hF;
				adr_o <= {isp_dec,2'b00};
				dat_o <= pc + 32'd1;
				vect <= {vbr[31:9],`BRK_VECTNO,2'b00};
				state <= IRQ1;
			end
		`JMP:
			begin
				pc[15:0] <= ir[23:8];
				state <= IFETCH;
			end
		`JML:
			begin
				pc <= ir[39:8];
				state <= IFETCH;
			end
		`JMP_IND:
			begin
				radr <= ir[39:8];
				state <= JMP_IND1;
			end
		`JMP_INDX:
			begin
				radr <= ir[39:8] + x;
				state <= JMP_IND1;
			end
		`JMP_RIND:
			begin
				pc <= rfoa;
				res <= pc + 32'd2;
				Rt <= ir[15:12];
				state <= IFETCH;
			end
		`JSR:
			begin
				radr <= isp_dec;
				wadr <= isp_dec;
				wdat <= pc + 32'd3;
				cyc_o <= 1'b1;
				stb_o <= 1'b1;
				we_o <= 1'b1;
				sel_o <= 4'hF;
				adr_o <= {isp_dec,2'b00};
				dat_o <= pc + 32'd3;
				vect <= {pc[31:16],ir[23:8]};
				state <= JSR1;
			end
		`JSR_RIND:
			begin
				radr <= isp_dec;
				wadr <= isp_dec;
				wdat <= pc + 32'd2;
				cyc_o <= 1'b1;
				stb_o <= 1'b1;
				we_o <= 1'b1;
				sel_o <= 4'hF;
				adr_o <= {isp_dec,2'b00};
				dat_o <= pc + 32'd2;
				vect <= rfoa;
				state <= JSR1;
				$stop;
			end
		`JSL:
			begin
				radr <= isp_dec;
				wadr <= isp_dec;
				wdat <= pc + 32'd5;
				cyc_o <= 1'b1;
				stb_o <= 1'b1;
				we_o <= 1'b1;
				sel_o <= 4'hF;
				adr_o <= {isp_dec,2'b00};
				dat_o <= pc + 32'd5;
				vect <= ir[39:8];
				state <= JSR1;
			end
		`BSR:
			begin
				radr <= isp_dec;
				wadr <= isp_dec;
				wdat <= pc + 32'd3;
				cyc_o <= 1'b1;
				stb_o <= 1'b1;
				we_o <= 1'b1;
				sel_o <= 4'hF;
				adr_o <= {isp_dec,2'b00};
				dat_o <= pc + 32'd3;
				vect <= pc + {{16{ir[23]}},ir[23:8]};
				state <= JSR1;
			end
		`JSR_INDX:
			begin
				radr <= isp - 32'd1;
				wadr <= isp - 32'd1;
				wdat <= pc + 32'd5;
				cyc_o <= 1'b1;
				stb_o <= 1'b1;
				we_o <= 1'b1;
				sel_o <= 4'hF;
				adr_o <= {isp-32'd1,2'b00};
				dat_o <= pc + 32'd5;
				state <= JSR_INDX1;
			end
//		`JSR16:
//			begin
//				radr <= isp - 32'd1;
//				wadr <= isp - 32'd1;
//				wdat <= pc + 32'd3;
//				cyc_o <= 1'b1;
//				stb_o <= 1'b1;
//				we_o <= 1'b1;
//				sel_o <= 4'hF;
//				adr_o <= {isp-32'd1,2'b00};
//				dat_o <= pc + 32'd3;
//				state <= JSR161;
//			end
		`RTS,`RTL:
				begin
				radr <= isp;
				state <= RTS1;
				end
		`RTI:	begin
				radr <= isp;
				state <= RTI1;
				end
		`BEQ,`BNE,`BPL,`BMI,`BCC,`BCS,`BVC,`BVS,`BRA:
			begin
				state <= IFETCH;
				if (ir[15:8]==8'h00) begin
					radr <= isp_dec;
					wadr <= isp_dec;
					wdat <= pc + 32'd2;
					cyc_o <= 1'b1;
					stb_o <= 1'b1;
					we_o <= 1'b1;
					sel_o <= 4'hF;
					adr_o <= {isp_dec,2'b00};
					dat_o <= pc + 32'd2;
					vect <= {vbr[31:9],`SLP_VECTNO,2'b00};
					state <= IRQ1;
				end
				else if (ir[15:8]==8'h1) begin
					if (takb)
						pc <= pc + {{16{ir[31]}},ir[31:16]};
					else
						pc <= pc + 32'd4;
				end
				else begin
					if (takb)
						pc <= pc + {{24{ir[15]}},ir[15:8]};
					else
						pc <= pc + 32'd2;
				end
			end
/*		`BEQ_RR:
			begin
				state <= IFETCH;
				if (ir[23:16]==8'h00) begin
					radr <= isp_dec;
					wadr <= isp_dec;
					wdat <= pc + 32'd2;
					cyc_o <= 1'b1;
					stb_o <= 1'b1;
					we_o <= 1'b1;
					sel_o <= 4'hF;
					adr_o <= {isp_dec,2'b00};
					dat_o <= pc + 32'd2;
					vect <= `SLP_VECT;
					state <= IRQ1;
				end
				else if (ir[23:16]==8'h1) begin
					if (rfoa==rfob)
						pc <= pc + {{16{ir[39]}},ir[39:24]};
					else
						pc <= pc + 32'd5;
				end
				else begin
					if (takb)
						pc <= pc + {{24{ir[23]}},ir[23:16]};
					else
						pc <= pc + 32'd3;
				end
			end*/
		`BRL:
			begin
				if (ir[23:8]==16'h0000) begin
					radr <= isp_dec;
					wadr <= isp_dec;
					wdat <= pc + 32'd3;
					cyc_o <= 1'b1;
					stb_o <= 1'b1;
					we_o <= 1'b1;
					sel_o <= 4'hF;
					adr_o <= {isp_dec,2'b00};
					dat_o <= pc + 32'd3;
					vect <= {vbr[31:9],`SLP_VECTNO,2'b00};
					state <= IRQ1;
				end
				else begin
					pc <= pc + {{16{ir[23]}},ir[23:8]};
					state <= IFETCH;
				end
			end
		`PHP:
			begin
				cyc_o <= 1'b1;
				stb_o <= 1'b1;
				sel_o <= 4'hF;
				we_o <= 1'b1;
				radr <= isp_dec;
				wadr <= isp_dec;
				wdat <= sr;
				adr_o <= {isp_dec,2'b00};
				dat_o <= sr;
				isp <= isp_dec;
				state <= PHP1;
			end
		`PHA:
			begin
				cyc_o <= 1'b1;
				stb_o <= 1'b1;
				sel_o <= 4'hF;
				we_o <= 1'b1;
				radr <= isp_dec;
				wadr <= isp_dec;
				wdat <= acc;
				adr_o <= {isp_dec,2'b00};
				dat_o <= acc;
				isp <= isp_dec;
				state <= PHP1;
			end
		`PHX:
			begin
				cyc_o <= 1'b1;
				stb_o <= 1'b1;
				sel_o <= 4'hF;
				we_o <= 1'b1;
				radr <= isp_dec;
				wadr <= isp_dec;
				wdat <= x;
				adr_o <= {isp_dec,2'b00};
				dat_o <= x;
				isp <= isp_dec;
				state <= PHP1;
			end
		`PHY:
			begin
				cyc_o <= 1'b1;
				stb_o <= 1'b1;
				sel_o <= 4'hF;
				we_o <= 1'b1;
				radr <= isp_dec;
				wadr <= isp_dec;
				wdat <= y;
				adr_o <= {isp_dec,2'b00};
				dat_o <= y;
				isp <= isp_dec;
				state <= PHP1;
			end
		`PUSH:
			begin
				cyc_o <= 1'b1;
				stb_o <= 1'b1;
				sel_o <= 4'hF;
				we_o <= 1'b1;
				radr <= isp_dec;
				wadr <= isp_dec;
				wdat <= rfoa;
				adr_o <= {isp_dec,2'b00};
				dat_o <= rfoa;
				state <= PHP1;
				isp <= isp_dec;
				pc <= pc + 32'd1;
			end
		`PLP:
			begin
				radr <= isp;
				state <= PLP1;
				pc <= pc + 32'd1;
			end
		`PLA,`PLX,`PLY:
			begin
				radr <= isp;
				isp <= isp_inc;
				state <= PLA1;
				pc <= pc + 32'd1;
			end
		`POP:
			begin
				Rt <= ir[15:12];
				radr <= isp;
				isp <= isp_inc;
				state <= PLA1;
				pc <= pc + 32'd2;
			end
		default:	// unimplemented opcode
			pc <= pc + 32'd1;
		endcase
		end
	end

// Stores always write through to memory, then optionally update the cache if
// there was a write hit.
STORE1:
	begin
		cyc_o <= 1'b1;
		stb_o <= 1'b1;
		we_o <= 1'b1;
		if (em || isStb)
			case(wadr2LSB)
			2'd0:	sel_o <= 4'b0001;
			2'd1:	sel_o <= 4'b0010;
			2'd2:	sel_o <= 4'b0100;
			2'd3:	sel_o <= 4'b1000;
			endcase
		else
			sel_o <= 4'hf;
		adr_o <= {wadr,2'b00};
		dat_o <= wdat;
		radr <= wadr;		// Do a cache read to test the hit
		state <= STORE2;
	end
	
// Terminal state for stores. Update the data cache if there was a cache hit.
// Clear any previously set lock status
STORE2:
	if (ack_i) begin
		state <= IFETCH;
		lock_o <= 1'b0;
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		we_o <= 1'b0;
		sel_o <= 4'h0;
		adr_o <= 34'h0;
		dat_o <= 32'h0;
		if (dhit) begin
			wrsel <= sel_o;
			wr <= 1'b1;
		end
		else if (write_allocate) begin
			dmiss <= `TRUE;
			state <= WAIT_DHIT;
			retstate <= IFETCH;
		end
	end
WAIT_DHIT:
	if (dhit)
		state <= retstate;

`include "byte_ix.v"
`include "byte_iy.v"

// Indirect and indirect X addressing mode eg. LDA ($12,x) : (zp)
IX1:
	if (unCachedData) begin
		cyc_o <= 1'b1;
		stb_o <= 1'b1;
		sel_o <= 4'hf;
		adr_o <= {radr,2'b00};
		state <= IX2;
	end
	else if (dhit) begin
		radr <= rdat;
		state <= IX3;
	end
	else
		dmiss <= `TRUE;
IX2:
	if (ack_i) begin
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		sel_o <= 4'h0;
		adr_o <= 34'h0;
		radr <= dat_i;
		state <= IX3;
	end
IX3:
	if (ir[7:0]==`ST_IX || ir[7:0]==`ST_RIND) begin
		wadr <= radr;
		wdat <= rfoa;
		state <= STORE1;
	end
	else if (unCachedData) begin
		cyc_o <= 1'b1;
		stb_o <= 1'b1;
		sel_o <= 4'hf;
		adr_o <= {radr,2'b00};
		state <= IX4;
	end
	else if (dhit) begin
		b <= rdat;
		state <= CALC;
	end
	else
		dmiss <= `TRUE;
IX4:
	if (ack_i) begin
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		sel_o <= 4'h0;
		adr_o <= 34'h0;
		b <= dat_i;
		state <= CALC;
	end


// Indirect Y addressing mode eg. LDA ($12),y
IY1:
	if (unCachedData) begin
		cyc_o <= 1'b1;
		stb_o <= 1'b1;
		sel_o <= 4'hf;
		adr_o <= {radr,2'b00};
		state <= IY2;
	end
	else if (dhit) begin
		radr <= rdat;
		state <= IY3;
	end
	else
		dmiss <= `TRUE;
IY2:
	if (ack_i) begin
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		sel_o <= 4'h0;
		adr_o <= 34'h0;
		radr <= dat_i;
		state <= IY3;
	end
IY3:
	begin
		radr <= radr + y;
		wadr <= radr + y;
		wdat <= rfoa;
		if (ir==`ST_IY)
			state <= STORE1;
		else
			state <= LOAD1;
	end

// Performs the data fetch for both eight bit and 32 bit modes
// Handle the following address modes: zp : zp,Rn : abs : abs,Rn
LOAD1:
	if (unCachedData) begin
		if (isRMW)
			lock_o <= 1'b1;
		cyc_o <= 1'b1;
		stb_o <= 1'b1;
		sel_o <= 4'hf;
		adr_o <= {radr,2'b00};
		state <= LOAD2;
	end
	else if (dhit) begin
		b8 <= rdat8;
		b <= rdat;
		state <= CALC;
	end
	else
		dmiss <= `TRUE;
LOAD2:
	if (ack_i) begin
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		sel_o <= 4'h0;
		adr_o <= 34'd0;
		b8 <= dati;
		b <= dat_i;
		state <= CALC;
	end

`include "calc.v"

JSR1:
	if (ack_i) begin
		state <= IFETCH;
		retstate <= IFETCH;
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		we_o <= 1'b0;
		sel_o <= 4'h0;
		adr_o <= 34'd0;
		dat_o <= 32'd0;
		pc <= vect;
		isp <= isp_dec;
		if (dhit) begin
			wrsel <= sel_o;
			wr <= 1'b1;
		end
		else if (write_allocate) begin
			state <= WAIT_DHIT;
			dmiss <= `TRUE;
		end
	end

`include "byte_jsr.v"
`include "byte_jsl.v"

JSR_INDX1:
	if (ack_i) begin
		state <= JMP_IND1;
		retstate <= JMP_IND1;
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		we_o <= 1'b0;
		sel_o <= 4'h0;
		adr_o <= 34'd0;
		dat_o <= 32'd0;
		radr <= ir[39:8] + x;
		isp <= isp_dec;
		if (dhit) begin
			wrsel <= sel_o;
			wr <= 1'b1;
		end
		else if (write_allocate) begin
			dmiss <= `TRUE;
			state <= WAIT_DHIT;
		end
	end
BYTE_JSR_INDX1:
	if (ack_i) begin
		state <= BYTE_JSR_INDX2;
		retstate <= BYTE_JSR_INDX2;
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		we_o <= 1'b0;
		sel_o <= 4'h0;
		if (dhit) begin
			wrsel <= sel_o;
			wr <= 1'b1;
		end
		else if (write_allocate) begin
			state <= WAIT_DHIT;
			dmiss <= `TRUE;
		end
	end
BYTE_JSR_INDX2:
	begin
		radr <= {spage[31:8],sp[7:2]};
		wadr <= {spage[31:8],sp[7:2]};
		radr2LSB <= sp[1:0];
		wadr2LSB <= sp[1:0];
		wdat <= {4{pcp2[7:0]}};
		cyc_o <= 1'b1;
		stb_o <= 1'b1;
		we_o <= 1'b1;
		case(sp[1:0])
		2'd0:	sel_o <= 4'b0001;
		2'd1:	sel_o <= 4'b0010;
		2'd2:	sel_o <= 4'b0100;
		2'd3:	sel_o <= 4'b1000;
		endcase
		adr_o <= {spage[31:8],sp[7:2],2'b00};
		dat_o <= {4{pcp2[7:0]}};
		sp <= sp_dec;
		state <= BYTE_JSR_INDX3;
	end
BYTE_JSR_INDX3:
	if (ack_i) begin
		state <= BYTE_JMP_IND1;
		retstate <= BYTE_JMP_IND1;
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		we_o <= 1'b0;
		sel_o <= 4'h0;
		adr_o <= 34'd0;
		dat_o <= 32'd0;
		radr <= absx_address[15:2];
		radr2LSB <= absx_address[1:0];
		if (dhit) begin
			wrsel <= sel_o;
			wr <= 1'b1;
		end
		else if (write_allocate) begin
			state <= WAIT_DHIT;
			dmiss <= `TRUE;
		end
	end
JSR161:
	if (ack_i) begin
		state <= IFETCH;
		retstate <= IFETCH;
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		we_o <= 1'b0;
		sel_o <= 4'h0;
		pc <= {{16{ir[23]}},ir[23:8]};
		isp <= isp_dec;
		if (dhit) begin
			wrsel <= sel_o;
			wr <= 1'b1;
		end
		else if (write_allocate) begin
			state <= WAIT_DHIT;
			dmiss <= `TRUE;
		end
	end

`include "byte_plp.v"
`include "byte_rts.v"
`include "byte_rti.v"
`include "rti.v"
`include "rts.v"

PHP1:
	if (ack_i) begin
		state <= IFETCH;
		retstate <= IFETCH;
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		we_o <= 1'b0;
		sel_o <= 4'h0;
		adr_o <= 34'd0;
		dat_o <= 32'd0;
		pc <= pc + 32'd1;
		if (dhit) begin
			wr <= 1'b1;
			wrsel <= sel_o;
		end
		else if (write_allocate) begin
			state <= WAIT_DHIT;
			dmiss <= `TRUE;
		end
	end
`include "plp.v"
`include "pla.v"

`include "byte_irq.v"
`include "byte_jmp_ind.v"

IRQ1:
	if (ack_i) begin
		state <= IRQ2;
		retstate <= IRQ2;
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		we_o <= 1'b0;
		sel_o <= 4'h0;
		isp <= isp_dec;
		if (dhit) begin
			wrsel <= sel_o;
			wr <= 1'b1;
		end
		else if (write_allocate) begin
			state <= WAIT_DHIT;
			dmiss <= `TRUE;
		end
	end
IRQ2:
	begin
		cyc_o <= 1'b1;
		stb_o <= 1'b1;
		we_o <= 1'b1;
		sel_o <= 4'hF;
		radr <= isp_dec;
		wadr <= isp_dec;
		wdat <= sr;
		adr_o <= {isp_dec,2'b00};
		dat_o <= sr;
		state <= IRQ3;
	end
IRQ3:
	if (ack_i) begin
		state <= JMP_IND1;
		retstate <= JMP_IND1;
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		we_o <= 1'b0;
		sel_o <= 4'h0;
		isp <= isp_dec;
		if (dhit) begin
			wrsel <= sel_o;
			wr <= 1'b1;
		end
		else if (write_allocate) begin
			dmiss <= `TRUE;
			state <= WAIT_DHIT;
		end
		radr <= vect[31:2];
		if (!bf)
			im <= 1'b1;
		em <= 1'b0;			// make sure we process in native mode; we might have been called up during emulation mode
	end
JMP_IND1:
	if (unCachedData) begin
		cyc_o <= 1'b1;
		stb_o <= 1'b1;
		sel_o <= 4'hF;
		adr_o <= {radr,2'b00};
		state <= JMP_IND2;
	end
	else if (dhit) begin
		pc <= rdat;
		state <= IFETCH;
	end
	else
		dmiss <= `TRUE;
JMP_IND2:
	if (ack_i) begin
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		sel_o <= 4'h0;
		adr_o <= 34'd0;
		pc <= dat_i;
		state <= IFETCH;
	end
MULDIV1:
	state <= MULDIV2;
MULDIV2:
	if (md_done) begin
		state <= IFETCH;
		case(ir[23:20])
		`MUL_RR:	begin res <= prod[31:0]; end
		`MULS_RR:	begin res <= prod[31:0]; end
		`DIV_RR:	begin res <= q; end
		`DIVS_RR:	begin res <= q; end
		`MOD_RR:	begin res <= r; end
		`MODS_RR:	begin res <= r; end
		endcase
	end

endcase

`include "cache_controller.v"

end
endmodule
