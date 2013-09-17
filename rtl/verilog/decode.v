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
DECODE:
	begin
		first_ifetch <= `TRUE;
		Rt <= 4'h0;		// Default
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
		`EMM:	begin em <= 1'b1; pc <= pc + 32'd1; end
		`DEX:	begin res <= x - 32'd1; pc <= pc + 32'd1; end
		`INX:	begin res <= x + 32'd1; pc <= pc + 32'd1; end
		`DEY:	begin res <= y - 32'd1; pc <= pc + 32'd1; end
		`INY:	begin res <= y + 32'd1; pc <= pc + 32'd1; end
		`DEA:	begin res <= acc - 32'd1; pc <= pc + 32'd1; end
		`INA:	begin res <= acc + 32'd1; pc <= pc + 32'd1; end
		`TSX,`TSA:	begin res <= isp; pc <= pc + 32'd1; end
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
						4'h9:	res <= derr_address;
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
				`ADD_RR:	begin res <= rfoa + rfob + {31'b0,df&cf}; a <= rfoa; b <= rfob; end
				`SUB_RR:	begin res <= rfoa - rfob - {31'b0,df&~cf&|ir[19:16]}; a <= rfoa; b <= rfob; end
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

		`ADD_IMM8:	begin res <= rfoa + {{24{ir[23]}},ir[23:16]} + {31'b0,df&cf}; Rt <= ir[15:12]; pc <= pc + 32'd3; a <= rfoa; b <= {{24{ir[23]}},ir[23:16]}; end
		`SUB_IMM8:	begin res <= rfoa - {{24{ir[23]}},ir[23:16]} - {31'b0,df&~cf&|ir[15:12]}; Rt <= ir[15:12]; pc <= pc + 32'd3; a <= rfoa; b <= {{24{ir[23]}},ir[23:16]}; end
		`OR_IMM8:	begin res <= rfoa | {{24{ir[23]}},ir[23:16]}; Rt <= ir[15:12]; pc <= pc + 32'd3; b <= {{24{ir[23]}},ir[23:16]}; end
		`AND_IMM8: 	begin res <= rfoa & {{24{ir[23]}},ir[23:16]}; Rt <= ir[15:12]; pc <= pc + 32'd3; b <= {{24{ir[23]}},ir[23:16]}; end
		`EOR_IMM8:	begin res <= rfoa ^ {{24{ir[23]}},ir[23:16]}; Rt <= ir[15:12]; pc <= pc + 32'd3; b <= {{24{ir[23]}},ir[23:16]}; end
		`CMP_IMM8:	begin res <= acc - {{24{ir[15]}},ir[15:8]}; Rt <= 4'h0; pc <= pc + 32'd2; b <= {{24{ir[15]}},ir[15:8]}; end
		`ASL_IMM8:	begin a <= rfoa; b <= ir[20:16]; Rt <= ir[15:12]; pc <= pc + 32'd3; state <= CALC; end
		`LSR_IMM8:	begin a <= rfoa; b <= ir[20:16]; Rt <= ir[15:12]; pc <= pc + 32'd3; state <= CALC; end

		`ADD_IMM16:	begin res <= rfoa + {{16{ir[31]}},ir[31:16]} + {31'b0,df&cf}; Rt <= ir[15:12]; pc <= pc + 32'd4; a <= rfoa; b <= {{16{ir[31]}},ir[31:16]}; end
		`SUB_IMM16:	begin res <= rfoa - {{16{ir[31]}},ir[31:16]} - {31'b0,df&~cf&|ir[15:12]}; Rt <= ir[15:12]; pc <= pc + 32'd4; a <= rfoa; b <= {{16{ir[31]}},ir[31:16]}; end
		`OR_IMM16:	begin res <= rfoa | {{16{ir[31]}},ir[31:16]}; Rt <= ir[15:12]; pc <= pc + 32'd4; b <= {{16{ir[31]}},ir[31:16]}; end
		`AND_IMM16:	begin res <= rfoa & {{16{ir[31]}},ir[31:16]}; Rt <= ir[15:12]; pc <= pc + 32'd4; b <= {{16{ir[31]}},ir[31:16]}; end
		`EOR_IMM16:	begin res <= rfoa ^ {{16{ir[31]}},ir[31:16]}; Rt <= ir[15:12]; pc <= pc + 32'd4; b <= {{16{ir[31]}},ir[31:16]}; end
	
		`ADD_IMM32:	begin res <= rfoa + ir[47:16]; Rt <= ir[15:12] + {31'b0,df&cf}; pc <= pc + 32'd6; a <= rfoa; b <= ir[47:16]; end
		`SUB_IMM32:	begin res <= rfoa - ir[47:16]; Rt <= ir[15:12] - {31'b0,df&~cf&|ir[15:12]}; pc <= pc + 32'd6; a <= rfoa; b <= ir[47:16]; end
		`OR_IMM32:	begin res <= rfoa | ir[47:16]; Rt <= ir[15:12]; pc <= pc + 32'd6; b <= ir[47:16]; end
		`AND_IMM32:	begin res <= rfoa & ir[47:16]; Rt <= ir[15:12]; pc <= pc + 32'd6; b <= ir[47:16]; end
		`EOR_IMM32:	begin res <= rfoa ^ ir[47:16]; Rt <= ir[15:12]; pc <= pc + 32'd6; b <= ir[47:16]; end

		`LDX_IMM32,`LDY_IMM32,`LDA_IMM32:	begin res <= ir[39:8]; pc <= pc + 32'd5; end
		`LDX_IMM16,`LDA_IMM16:	begin res <= {{16{ir[23]}},ir[23:8]}; pc <= pc + 32'd3; end
		`LDX_IMM8,`LDA_IMM8: begin res <= {{24{ir[15]}},ir[15:8]}; pc <= pc + 32'd2; end

		`SUB_SP:	begin res <= isp - {{24{ir[15]}},ir[15:8]}; pc <= pc + 32'd2; end

		`LDX_ZPX,`LDY_ZPX:
			begin
				radr <= zpx32xy_address;
				pc <= pc + 32'd3;
				load_what <= `WORD_311;
				state <= LOAD_MAC1;
			end
		`ORB_ZPX:
			begin
				a <= rfoa;
				Rt <= ir[19:16];
				radr <= zpx32_address[31:2];
				radr2LSB <= zpx32_address[1:0];
				pc <= pc + 32'd4;
				load_what <= `WORD_310;
				state <= LOAD_MAC1;
			end
		`LDX_ABS,`LDY_ABS:
			begin
				radr <= ir[39:8];
				pc <= pc + 32'd5;
				load_what <= `WORD_311;
				state <= LOAD_MAC1;
			end
		`ORB_ABS:
			begin
				a <= rfoa;
				Rt <= ir[15:12];
				radr <= ir[47:18];
				radr2LSB <= ir[17:16];
				pc <= pc + 32'd6;
				load_what <= `WORD_310;
				state <= LOAD_MAC1;
			end
		`LDX_ABSY,`LDY_ABSX:
			begin
				radr <= absx32xy_address;
				pc <= pc + 32'd6;
				load_what <= `WORD_311;
				state <= LOAD_MAC1;
			end
		`ORB_ABSX:
			begin
				a <= rfoa;
				Rt <= ir[19:16];
				radr <= absx32_address[31:2];
				radr2LSB <= absx32_address[1:0];
				pc <= pc + 32'd7;
				load_what <= `WORD_310;
				state <= LOAD_MAC1;
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
		`ST_DSP:
			begin
				wadr <= {{24{ir[23]}},ir[23:16]} + isp;
				wdat <= rfoa;
				pc <= pc + 32'd3;
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
				load_what <= `WORD_310;
				state <= LOAD_MAC1;
			end
		`ASL_ZPX,`ROL_ZPX,`LSR_ZPX,`ROR_ZPX,`INC_ZPX,`DEC_ZPX:
			begin
				radr <= dp + rfoa + ir[23:12];
				pc <= pc + 32'd3;
				load_what <= `WORD_310;
				state <= LOAD_MAC1;
			end
		`ADD_DSP,`SUB_DSP,`OR_DSP,`AND_DSP,`EOR_DSP:
			begin
				a <= rfoa;
				Rt <= ir[15:12];
				radr <= {{24{ir[23]}},ir[23:16]} + isp;
				pc <= pc + 32'd3;
				load_what <= `WORD_310;
				state <= LOAD_MAC1;
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
				load_what <= `IA_310;
				state <= LOAD_MAC1;			
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
					load_what <= `WORD_310;
					state <= LOAD_MAC1;
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
				isIY <= 1'b1;
				radr <= dp + ir[31:20];
				load_what <= `IA_310;
				state <= LOAD_MAC1;	
			end
		`ADD_ABS,`SUB_ABS,`OR_ABS,`AND_ABS,`EOR_ABS:
			begin
				a <= rfoa;
				radr <= ir[47:16];
				Rt <= ir[15:12];
				pc <= pc + 32'd6;
				load_what <= `WORD_310;
				state <= LOAD_MAC1;
			end
		`ASL_ABS,`ROL_ABS,`LSR_ABS,`ROR_ABS,`INC_ABS,`DEC_ABS:
			begin
				radr <= ir[39:8];
				pc <= pc + 32'd5;
				load_what <= `WORD_310;
				state <= LOAD_MAC1;
			end
		`ADD_ABSX,`SUB_ABSX,`OR_ABSX,`AND_ABSX,`EOR_ABSX:
			begin
				a <= rfoa;
				radr <= ir[55:24] + rfob;
				Rt <= ir[19:16];
				pc <= pc + 32'd7;
				load_what <= `WORD_310;
				state <= LOAD_MAC1;
			end
		`ASL_ABSX,`ROL_ABSX,`LSR_ABSX,`ROR_ABSX,`INC_ABSX,`DEC_ABSX:
			begin
				radr <= ir[47:16] + rfob;
				pc <= pc + 32'd6;
				load_what <= `WORD_310;
				state <= LOAD_MAC1;
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
				load_what <= `WORD_310;
				state <= LOAD_MAC1;
			end
		`CPY_ZPX:
			begin
				radr <= dp + ir[23:12] + rfoa;
				pc <= pc + 32'd3;
				load_what <= `WORD_310;
				state <= LOAD_MAC1;
			end
		`CPX_ABS:
			begin
				radr <= ir[39:8];
				pc <= pc + 32'd5;
				load_what <= `WORD_310;
				state <= LOAD_MAC1;
			end
		`CPY_ABS:
			begin
				radr <= ir[39:8];
				pc <= pc + 32'd5;
				load_what <= `WORD_310;
				state <= LOAD_MAC1;
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
		`INT0,`INT1:
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
				vect <= {vbr[31:9],ir[15:7],2'b00};
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
				load_what <= `PC_310;
				state <= LOAD_MAC1;
			end
		`JMP_INDX:
			begin
				radr <= ir[39:8] + x;
				load_what <= `PC_310;
				state <= LOAD_MAC1;
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
				load_what <= `PC_310;
				state <= LOAD_MAC1;
				end
		`RTI:	begin
				radr <= isp;
				load_what <= `SR_310;
				state <= LOAD_MAC1;
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
				pc <= pc + 32'd1;
				load_what <= `SR_310;
				state <= LOAD_MAC1;
			end
		`PLA,`PLX,`PLY:
			begin
				radr <= isp;
				isp <= isp_inc;
				load_what <= `WORD_311;
				state <= LOAD_MAC1;
				pc <= pc + 32'd1;
			end
		`POP:
			begin
				Rt <= ir[15:12];
				radr <= isp;
				isp <= isp_inc;
				load_what <= `WORD_311;
				state <= LOAD_MAC1;
				pc <= pc + 32'd2;
			end
		`MVN:	state <= MVN1;
		`MVP:	state <= MVP1;
		default:	// unimplemented opcode
			begin
				radr <= isp_dec;
				wadr <= isp_dec;
				wdat <= pc + 32'd1;
				cyc_o <= 1'b1;
				stb_o <= 1'b1;
				we_o <= 1'b1;
				sel_o <= 4'hF;
				adr_o <= {isp_dec,2'b00};
				dat_o <= pc + 32'd1;
				vect <= {vbr[31:9],9'd495,2'b00};
				state <= IRQ1;
			end	
		endcase
	end
