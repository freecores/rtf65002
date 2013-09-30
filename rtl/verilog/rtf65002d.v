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
`include "rtf65002_defines.v"

module rtf65002d(rst_md, rst_i, clk_i, nmi_i, irq_i, irq_vect, bte_o, cti_o, bl_o, lock_o, cyc_o, stb_o, ack_i, err_i, we_o, sel_o, adr_o, dat_i, dat_o);
parameter IDLE = 3'd0;
parameter LOAD_DCACHE = 3'd1;
parameter LOAD_ICACHE = 3'd2;
parameter LOAD_IBUF1 = 3'd3;
parameter LOAD_IBUF2 = 3'd4;
parameter LOAD_IBUF3 = 3'd5;
parameter RESET1 = 6'd0;
parameter IFETCH = 6'd1;
parameter DECODE = 6'd2;
parameter STORE1 = 6'd3;
parameter STORE2 = 6'd4;
parameter IRQ0 = 6'd5;
parameter IRQ1 = 6'd6;
parameter IRQ2 = 6'd7;
parameter IRQ3 = 6'd8;
parameter CALC = 6'd9;
parameter JSR_INDX1 = 6'd10;
parameter JSR161 = 6'd11;
parameter RTS1 = 6'd12;
parameter IY3 = 6'd13;
parameter BSR1 = 6'd14;
parameter BYTE_IX5 = 6'd15;
parameter BYTE_IY5 = 6'd16;
parameter BYTE_JSR1 = 6'd17;
parameter BYTE_JSR2 = 6'd18;
parameter BYTE_JSR3 = 6'd19;
parameter BYTE_IRQ1 = 6'd20;
parameter BYTE_IRQ2 = 6'd21;
parameter BYTE_IRQ3 = 6'd22;
parameter BYTE_IRQ4 = 6'd23;
parameter BYTE_IRQ5 = 6'd24;
parameter BYTE_IRQ6 = 6'd25;
parameter BYTE_IRQ7 = 6'd26;
parameter BYTE_IRQ8 = 6'd27;
parameter BYTE_IRQ9 = 6'd28;
parameter BYTE_JSR_INDX1 = 6'd29;
parameter BYTE_JSR_INDX2 = 6'd30;
parameter BYTE_JSR_INDX3 = 6'd31;
parameter BYTE_JSL1 = 6'd32;
parameter BYTE_JSL2 = 6'd33;
parameter BYTE_JSL3 = 6'd34;
parameter BYTE_JSL4 = 6'd35;
parameter BYTE_JSL5 = 6'd36;
parameter BYTE_JSL6 = 6'd37;
parameter BYTE_JSL7 = 6'd38;
parameter BYTE_PLP1 = 6'd39;
parameter BYTE_PLP2 = 6'd40;
parameter BYTE_PLA1 = 6'd41;
parameter BYTE_PLA2 = 6'd42;
parameter WAIT_DHIT = 6'd43;
parameter RESET2 = 6'd44;
parameter MULDIV1 = 6'd45;
parameter MULDIV2 = 6'd46;
parameter BYTE_DECODE = 6'd47;
parameter BYTE_CALC = 6'd48;
parameter BUS_ERROR = 6'd49;
parameter INSN_BUS_ERROR = 6'd50;
parameter LOAD_MAC1 = 6'd51;
parameter LOAD_MAC2 = 6'd52;
parameter MVN1 = 6'd53;
parameter MVN2 = 6'd54;
parameter MVN3 = 6'd55;
parameter MVP1 = 6'd56;
parameter MVP2 = 6'd57;
parameter STS1 = 6'd58;

input rst_md;		// reset mode, 1=emulation mode, 0=native mode
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
input err_i;
output reg we_o;
output reg [3:0] sel_o;
output reg [33:0] adr_o;
input [31:0] dat_i;
output reg [31:0] dat_o;

reg [5:0] state;
reg [5:0] retstate;
reg [2:0] cstate;
wire [63:0] insn;
reg [63:0] ibuf;
reg [31:0] bufadr;
reg [63:0] exbuf;

reg cf,nf,zf,vf,bf,im,df,em;
reg em1;
reg gie;
reg hwi;	// hardware interrupt indicator
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
reg [3:0] suppress_pcinc;
reg [31:0] pc;
reg [31:0] opc;
wire [3:0] pc_inc;
wire [31:0] pcp2 = pc + (32'd2 & suppress_pcinc);	// for branches
wire [31:0] pcp4 = pc + (32'd4 & suppress_pcinc);	// for branches
wire [31:0] pcp8 = pc + 32'd8;						// cache controller needs this
reg [31:0] abs8;	// 8 bit mode absolute address register
reg [31:0] vbr;		// vector table base register
wire bhit=pc==bufadr;
reg [31:0] regfile [15:0];
reg [63:0] ir;
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
`ifdef SUPPORT_SHIFT
wire [31:0] shlo = a << b[4:0];
wire [31:0] shro = a >> b[4:0];
`else
wire [31:0] shlo = 32'd0;
wire [31:0] shro = 32'd0;
`endif
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

reg [31:0] vect;
reg [31:0] ia;			// temporary reg to hold indirect address
wire [31:0] iapy8 = abs8 + ia + y[7:0];
reg isInsnCacheLoad;
reg isDataCacheLoad;
reg isCacheReset;
wire hit0,hit1;
`ifdef SUPPORT_DCACHE
wire dhit;
`else
wire dhit = 1'b0;
`endif
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
reg [3:0] load_what;
reg [3:0] store_what;
reg [31:0] derr_address;
reg imiss;
reg dmiss;
reg icacheOn,dcacheOn;
`ifdef SUPPORT_DCACHE
wire unCachedData = radr[31:20]==12'hFFD || !dcacheOn;	// I/O area is uncached
`else
wire unCachedData = 1'b1;
`endif
`ifdef SUPPORT_ICACHE
wire unCachedInsn = pc[31:13]==19'h0 || !icacheOn;		// The lowest 8kB is uncached.
`else
wire unCachedInsn = 1'b1;
`endif

reg [31:0] history_buf [63:0];
reg [5:0] history_ndx;
reg hist_capture;

reg isBrk,isMove,isSts;
reg isRTI,isRTL,isRTS;
reg isOrb,isStb;
reg isRMW;
reg isSub,isSub8;


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

// Registerable decodes
// The following decodes can be registered because they aren't needed until at least the cycle after
// the DECODE stage.

always @(posedge clk)
	if (state==DECODE) begin
		isSub <= ir[7:0]==`SUB_ZPX || ir[7:0]==`SUB_IX || ir[7:0]==`SUB_IY ||
			 ir[7:0]==`SUB_ABS || ir[7:0]==`SUB_ABSX || ir[7:0]==`SUB_IMM8 || ir[7:0]==`SUB_IMM16 || ir[7:0]==`SUB_IMM32;
		isSub8 <= ir[7:0]==`SBC_ZP || ir[7:0]==`SBC_ZPX || ir[7:0]==`SBC_IX || ir[7:0]==`SBC_IY || ir[7:0]==`SBC_I ||
			 ir[7:0]==`SBC_ABS || ir[7:0]==`SBC_ABSX || ir[7:0]==`SBC_ABSY || ir[7:0]==`SBC_IMM;
		isRMW <= em ? isRMW8 : isRMW32;
		isOrb <= ir[7:0]==`ORB_ZPX || ir[7:0]==`ORB_IX || ir[7:0]==`ORB_IY || ir[7:0]==`ORB_ABS || ir[7:0]==`ORB_ABSX;
		isStb <= ir[7:0]==`STB_ZPX || ir[7:0]==`STB_ABS || ir[7:0]==`STB_ABSX;
		isRTI <= ir[7:0]==`RTI;
		isRTL <= ir[7:0]==`RTL;
		isRTS <= ir[7:0]==`RTS;
		isBrk <= ir[7:0]==`BRK;
		isMove <= ir[7:0]==`MVP || ir[7:0]==`MVN;
		isSts <= ir[7:0]==`STS;
	end

`ifdef SUPPORT_EXEC
wire isExec = ir[7:0]==`EXEC;
wire isAtni = ir[7:0]==`ATNI;
`else
wire isExec = 1'b0;
wire isAtni = 1'b0;
`endif
wire ld_muldiv = state==DECODE && ir[7:0]==`RR;
wire md_done;
wire clk;
reg isIY;

rtf65002_pcinc upci1
(
	.opcode(ir[7:0]),
	.suppress_pcinc(suppress_pcinc),
	.inc(pc_inc)
);

mult_div umd1
(
	.rst(rst_i),
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

`ifdef SUPPORT_ICACHE
rtf65002_icachemem icm0 (
	.wclk(clk),
	.wr(ack_i & isInsnCacheLoad),
	.adr(adr_o),
	.dat(dat_i),
	.rclk(~clk),
	.pc(pc),
	.insn(insn)
);

rtf65002_itagmem tgm0 (
	.wclk(clk),
	.wr((ack_i & isInsnCacheLoad)|isCacheReset),
	.adr({adr_o[31:1],!isCacheReset}),
	.rclk(~clk),
	.pc(pc),
	.hit0(hit0),
	.hit1(hit1)
);

wire ihit = (hit0 & hit1);//(pc[2:0] > 3'd1 ? hit1 : 1'b1));
`else
wire ihit = 1'b0;
`endif

`ifdef SUPPORT_DCACHE
rtf65002_dcachemem dcm0 (
	.wclk(clk),
	.wr(wr | (ack_i & isDataCacheLoad)),
	.sel(wr ? wrsel : sel_o),
	.wadr(wr ? wadr : adr_o[33:2]),
	.wdat(wr ? wdat : dat_i),
	.rclk(~clk),
	.radr(radr),
	.rdat(rdat)
);

rtf65002_dtagmem dtm0 (
	.wclk(clk),
	.wr(wr | (ack_i & isDataCacheLoad)),
	.wadr(wr ? wadr : adr_o[33:2]),
	.rclk(~clk),
	.radr(radr),
	.hit(dhit)
);
`endif

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

`ifdef SUPPORT_BCD
BCDAdd ubcdai1 (.ci(cf),.a(acc8),.b(ir[15:8]),.o(bcaio),.c(bcaico));
BCDAdd ubcda2 (.ci(cf),.a(acc8),.b(b8),.o(bcao),.c(bcaco));
BCDSub ubcdsi1 (.ci(cf),.a(acc8),.b(ir[15:8]),.o(bcsio),.c(bcsico));
BCDSub ubcds2 (.ci(cf),.a(acc8),.b(b8),.o(bcso),.c(bcsco));
`endif

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
`BHI:	takb <= cf & !zf;
`BLS:	takb <= !cf | zf;
`BGE:	takb <= (nf & vf)|(!nf & !vf);
`BLT:	takb <= (nf & !vf)|(!nf & vf);
`BGT:	takb <= (nf & vf & !zf) + (!nf & !vf & !zf);
`BLE:	takb <= zf | (nf & !vf)|(!nf & vf);
//`BAZ:	takb <= acc8==8'h00;
//`BXZ:	takb <= x8==8'h00;
default:	takb <= 1'b0;
endcase

wire [31:0] zp_address 		= {abs8[31:12],4'h0,ir[15:8]};
wire [31:0] zpx_address 	= {abs8[31:12],4'h0,ir[15:8]} + x8;
wire [31:0] zpy_address	 	= {abs8[31:12],4'h0,ir[15:8]} + y8;
wire [31:0] abs_address 	= {abs8[31:12],12'h00} + {16'h0,ir[23:8]};
wire [31:0] absx_address 	= {abs8[31:12],12'h00} + {16'h0,ir[23:8] + {8'h0,x8}};	// simulates 64k bank wrap-around
wire [31:0] absy_address 	= {abs8[31:12],12'h00} + {16'h0,ir[23:8] + {8'h0,y8}};
wire [31:0] zpx32xy_address 	= ir[23:12] + rfoa;
wire [31:0] absx32xy_address 	= ir[47:16] + rfob;
wire [31:0] zpx32_address 		= ir[31:20] + rfob;
wire [31:0] absx32_address 		= ir[55:24] + rfob;

reg [32:0] calc_res;
always @(a or b or b8 or x or y or df or cf or Rt or shlo or shro)
begin
	case(ir[7:0])
	`RR:
		case(ir[23:20])
		`ASL_RRR:	calc_res <= shlo;
		`LSR_RRR:	calc_res <= shro;
		default:	calc_res <= 33'd0;
		endcase
	`ADD_ZPX,`ADD_IX,`ADD_IY,`ADD_ABS,`ADD_ABSX,`ADD_RIND:	calc_res <= a + b + {31'b0,df&cf};
	`SUB_ZPX,`SUB_IX,`SUB_IY,`SUB_ABS,`SUB_ABSX,`SUB_RIND:	calc_res <= a - b - {31'b0,df&~cf&|Rt}; // Also CMP
	`AND_ZPX,`AND_IX,`AND_IY,`AND_ABS,`AND_ABSX,`AND_RIND:	calc_res <= a & b;	// Also BIT
	`OR_ZPX,`OR_IX,`OR_IY,`OR_ABS,`OR_ABSX,`OR_RIND:		calc_res <= a | b;	// Also LD
	`EOR_ZPX,`EOR_IX,`EOR_IY,`EOR_ABS,`EOR_ABSX,`EOR_RIND:	calc_res <= a ^ b;
	`LDX_ZPY,`LDX_ABS,`LDX_ABSY:	calc_res <= b;
	`LDY_ZPX,`LDY_ABS,`LDY_ABSX:	calc_res <= b;
	`CPX_ZPX,`CPX_ABS:	calc_res <= x - b;
	`CPY_ZPX,`CPY_ABS:	calc_res <= y - b;
	`ASL_IMM8:	calc_res <= shlo;
	`LSR_IMM8:	calc_res <= shro;
	`ASL_ZPX,`ASL_ABS,`ASL_ABSX:	calc_res <= {b,1'b0};
	`ROL_ZPX,`ROL_ABS,`ROL_ABSX:	calc_res <= {b,cf};
	`LSR_ZPX,`LSR_ABS,`LSR_ABSX:	calc_res <= {b[0],1'b0,b[31:1]};
	`ROR_ZPX,`ROR_ABS,`ROR_ABSX:	calc_res <= {b[0],cf,b[31:1]};
	`INC_ZPX,`INC_ABS,`INC_ABSX:	calc_res <= b + 32'd1;
	`DEC_ZPX,`DEC_ABS,`DEC_ABSX:	calc_res <= b - 32'd1;
	`ORB_ZPX,`ORB_ABS,`ORB_ABSX:	calc_res <= a | {24'h0,b8};
	default:	calc_res <= 33'd0;
	endcase
end


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
	cf <= 1'b0;
	ir <= 64'hEAEAEAEAEAEAEAEA;
	imiss <= `FALSE;
	dmiss <= `FALSE;
	dcacheOn <= 1'b0;
	icacheOn <= 1'b1;
	write_allocate <= 1'b0;
	nmoi <= 1'b1;
	state <= RESET1;
	cstate <= IDLE;
	if (rst_md) begin
		pc <= 32'h0000FFF0;		// set high-order pc to zero
		vect <= `BYTE_RST_VECT;
		em <= 1'b1;
	end
	else begin
		vect <= `RST_VECT;
		em <= 1'b0;
		pc <= 32'hFFFFFFF0;
	end
	suppress_pcinc <= 4'hF;
	exbuf <= 64'd0;
	spage <= 32'h00000100;
	bufadr <= 32'd0;
	abs8 <= 32'd0;
	clk_en <= 1'b1;
	isCacheReset <= `TRUE;
	gie <= 1'b0;
	tick <= 32'd0;
	isIY <= 1'b0;
	load_what <= `NOTHING;
	hist_capture <= `TRUE;
	history_ndx <= 6'd0;
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
		radr <= vect[31:2];
		radr2LSB <= vect[1:0];
		load_what <= em ? `PC_70 : `PC_310;
		state <= LOAD_MAC1;
	end

`include "ifetch.v"
`include "decode.v"
`ifdef SUPPORT_EM8
`include "byte_decode.v"
`include "byte_calc.v"
`include "byte_jsr.v"
`include "byte_jsl.v"
`ifdef SUPPORT_BYTE_IRQ
`include "byte_irq.v"
`endif
`endif

`include "load_mac.v"
`include "store.v"

WAIT_DHIT:
	if (dhit)
		state <= retstate;

`include "calc.v"

JSR_INDX1:
	if (ack_i) begin
		load_what <= `PC_310;
		state <= LOAD_MAC1;
		retstate <= LOAD_MAC1;
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
/*
IRQ0:
	begin
		cyc_o <= 1'b1;
		stb_o <= 1'b1;
		we_o <= 1'b1;
		sel_o <= 4'hF;
		adr_o <= {wadr,2'b00};
		dat_o <= wdat;
		state <= IRQ1;
	end
IRQ1:
	if (ack_i) begin
		ir <= 64'd0;		// Force instruction decoder to BRK
		state <= IRQ2;
		retstate <= IRQ2;
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		we_o <= 1'b0;
		sel_o <= 4'h0;
		isp <= isp_dec;
`ifdef SUPPORT_DCACHE
		if (dhit) begin
			wrsel <= sel_o;
			wr <= 1'b1;
		end
		else if (write_allocate) begin
			state <= WAIT_DHIT;
			dmiss <= `TRUE;
		end
`endif
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
		load_what <= `PC_310;
		state <= LOAD_MAC1;
		retstate <= LOAD_MAC1;
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		we_o <= 1'b0;
		sel_o <= 4'h0;
		isp <= isp_dec;
`ifdef SUPPORT_DCACHE
		if (dhit) begin
			wrsel <= sel_o;
			wr <= 1'b1;
		end
		else if (write_allocate) begin
			dmiss <= `TRUE;
			state <= WAIT_DHIT;
		end
`endif
		radr <= vect[31:2];
		if (hwi)
			im <= 1'b1;
		em <= 1'b0;			// make sure we process in native mode; we might have been called up during emulation mode
	end
*/
MULDIV1:
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

`ifdef SUPPORT_BERR
BUS_ERROR:
	begin
		radr <= isp_dec;
		wadr <= isp_dec;
		wdat <= opc;
		if (em | isOrb | isStb)
			derr_address <= adr_o[31:0];
		else
			derr_address <= adr_o[33:2];
		vect <= {vbr[31:9],9'd508,2'b00};
		hwi <= `TRUE;
		state <= IRQ0;
	end
INSN_BUS_ERROR:
	begin
		radr <= isp_dec;
		wadr <= isp_dec;
		wdat <= opc;
		vect <= {vbr[31:9],9'd509,2'b00};
		hwi <= `TRUE;
		state <= IRQ0;
	end
`endif

`ifdef SUPPORT_STRING
MVN1:
	begin
		radr <= x;
		res <= x + 32'd1;
		retstate <= MVN2;
		load_what <= `WORD_312;
		state <= LOAD_MAC1;
	end
MVN2:
	begin
		radr <= y;
		wadr <= y;
		store_what <= `STW_B;
		x <= res;
		res <= y + 32'd1;
		acc <= acc - 32'd1;
		state <= STORE1;
	end
MVN3:
	begin
		state <= IFETCH;
		y <= res;
		if (acc==32'hFFFFFFFF)
			pc <= pc + 32'd1;
	end
MVP1:
	begin
		radr <= x;
		res <= x - 32'd1;
		retstate <= MVP2;
		load_what <= `WORD_312;
		state <= LOAD_MAC1;
	end
MVP2:
	begin
		radr <= y;
		wadr <= y;
		store_what <= `STW_B;
		x <= res;
		res <= y - 32'd1;
		acc <= acc - 32'd1;
		state <= STORE1;
	end
STS1:
	begin
		radr <= y;
		wadr <= y;
		store_what <= `STW_X;
		res <= y + 32'd1;
		acc <= acc - 32'd1;
		state <= STORE1;
	end
`endif

endcase

`include "cache_controller.v"

end
endmodule
