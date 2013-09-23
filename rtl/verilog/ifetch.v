// ============================================================================
//        __
//   \\__/ o\    (C) 2013  Robert Finch, Stratford
//    \  __ /    All rights reserved.
//     \/_//     robfinch<remove>@opencores.org
//       ||
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
IFETCH:
	begin
		suppress_pcinc <= 4'hF;				// default: no suppression of increment
		opc <= pc;
		hwi <= `FALSE;
		if (nmi_edge & !imiss & gie & !isExec & !isAtni) begin	// imiss indicates cache controller is active and this state is in a waiting loop
			nmi_edge <= 1'b0;
			wai <= 1'b0;
			bf <= 1'b0;
			hwi <= `TRUE;
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
		else if (irq_i && !imiss & gie & !isExec & !isAtni) begin
			if (im) begin
				wai <= 1'b0;
				if (isExec) begin
					ir <= exbuf;
					exbuf <= 64'd0;
					suppress_pcinc <= 4'h0;
					state <= em ? BYTE_DECODE : DECODE;
				end
				else if (unCachedInsn) begin
					if (bhit) begin
						ir <= ibuf + exbuf;
						exbuf <= 64'd0;
						state <= em ? BYTE_DECODE : DECODE;
					end
					else
						imiss <= `TRUE;
				end
				else begin
					if (ihit) begin
						ir <= insn + exbuf;
						exbuf <= 64'd0;
						state <= em ? BYTE_DECODE : DECODE;
					end
					else
						imiss <= `TRUE;
				end
			end
			else begin
				bf <= 1'b0;
				wai <= 1'b0;
				hwi <= `TRUE;
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
			if (isExec) begin
				ir <= exbuf;
				exbuf <= 64'd0;
				suppress_pcinc <= 4'h0;
				state <= em ? BYTE_DECODE : DECODE;
			end
			else if (unCachedInsn) begin
				if (bhit) begin
					ir <= ibuf + exbuf;
					exbuf <= 64'd0;
					state <= em ? BYTE_DECODE : DECODE;
				end
				else
					imiss <= `TRUE;
			end
			else begin
				if (ihit) begin
					ir <= insn + exbuf;
					exbuf <= 64'd0;
					state <= em ? BYTE_DECODE : DECODE;
				end
				else
					imiss <= `TRUE;
			end
		end
		if (first_ifetch) begin
			first_ifetch <= `FALSE;
			if (em) begin
				case(ir[7:0])
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
				`TAY,`TXY,`DEY,`INY:	begin y <= res; nf <= resn32; zf <= resz32; end
				`TAX,`TYX,`TSX,`DEX,`INX:	begin x <= res; nf <= resn32; zf <= resz32; end
				`TAS,`TXS:	begin isp <= res; gie <= 1'b1; end
				`SUB_SP8,`SUB_SP16,`SUB_SP32:	isp <= res;
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
