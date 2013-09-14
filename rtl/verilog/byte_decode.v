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
// Byte mode decode/execute state
// ============================================================================
//
BYTE_DECODE:
	begin
		first_ifetch <= `TRUE;
		state <= IFETCH;
		case(ir[7:0])
		`STP:	begin clk_en <= 1'b0; pc <= pc + 32'd1; end
		`NAT:	begin em <= 1'b0; pc <= pc + 32'd1; end
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
			end
		`ADC_IMM:
			begin
				pc <= pc + 32'd2;
				res8 <= acc8 + ir[15:8] + {7'b0,cf};
				b8 <= ir[15:8];		// for overflow calc
			end
		`SBC_IMM:
			begin
				pc <= pc + 32'd2;
//				res8 <= acc8 - ir[15:8] - ~cf;
				res8 <= acc8 - ir[15:8] - {7'b0,~cf};
				$display("sbc: %h= %h-%h-%h", acc8 - ir[15:8] - {7'b0,~cf},acc8,ir[15:8],~cf);
				b8 <= ir[15:8];		// for overflow calc
			end
		`AND_IMM,`BIT_IMM:
			begin
				pc <= pc + 32'd2;
				res8 <= acc8 & ir[15:8];
				b8 <= ir[15:8];	// for bit flags
			end
		`ORA_IMM:
			begin
				pc <= pc + 32'd2;
				res8 <= acc8 | ir[15:8];
			end
		`EOR_IMM:
			begin
				pc <= pc + 32'd2;
				res8 <= acc8 ^ ir[15:8];
			end
		`CMP_IMM:
			begin
				pc <= pc + 32'd2;
				res8 <= acc8 - ir[15:8];
			end
		`CPX_IMM:
			begin
				pc <= pc + 32'd2;
				res8 <= x8 - ir[15:8];
			end
		`CPY_IMM:
			begin
				pc <= pc + 32'd2;
				res8 <= y8 - ir[15:8];
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
			end
		`JML:
			begin
				pc <= ir[39:8];
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
	