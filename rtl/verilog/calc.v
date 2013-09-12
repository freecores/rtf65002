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
CALC:
	begin
		state <= IFETCH;
		if (em) begin
			case(ir[7:0])
			`ADC_IMM,`ADC_ZP,`ADC_ZPX,`ADC_IX,`ADC_IY,`ADC_ABS,`ADC_ABSX,`ADC_ABSY,`ADC_I:	begin res8 <= acc8 + b8 + {7'b0,cf}; end
			`SBC_IMM,`SBC_ZP,`SBC_ZPX,`SBC_IX,`SBC_IY,`SBC_ABS,`SBC_ABSX,`SBC_ABSY,`SBC_I:	begin res8 <= acc8 - b8 - {7'b0,~cf}; end
			`CMP_IMM,`CMP_ZP,`CMP_ZPX,`CMP_IX,`CMP_IY,`CMP_ABS,`CMP_ABSX,`CMP_ABSY,`CMP_I:	begin res8 <= acc8 - b8; end
			`AND_IMM,`AND_ZP,`AND_ZPX,`AND_IX,`AND_IY,`AND_ABS,`AND_ABSX,`AND_ABSY,`AND_I:	begin res8 <= acc8 & b8; end
			`ORA_IMM,`ORA_ZP,`ORA_ZPX,`ORA_IX,`ORA_IY,`ORA_ABS,`ORA_ABSX,`ORA_ABSY,`ORA_I:	begin res8 <= acc8 | b8; end
			`EOR_IMM,`EOR_ZP,`EOR_ZPX,`EOR_IX,`EOR_IY,`EOR_ABS,`EOR_ABSX,`EOR_ABSY,`EOR_I:	begin res8 <= acc8 ^ b8; end
			`LDA_IMM,`LDA_ZP,`LDA_ZPX,`LDA_IX,`LDA_IY,`LDA_ABS,`LDA_ABSX,`LDA_ABSY,`LDA_I: begin res8 <= b8; end
			`BIT_IMM,`BIT_ZP,`BIT_ZPX,`BIT_ABS,`BIT_ABSX:	begin res8 <= acc8 & b8; end
			`TRB_ZP,`TRB_ABS:	begin res8 <= ~acc8 & b8; wdat <= {4{~acc8 & b8}}; wadr <= radr; wadr2LSB <= radr2LSB; state <= STORE1; end
			`TSB_ZP,`TSB_ABS:	begin res8 <= acc8 | b8; wdat <= {4{acc8 | b8}}; wadr <= radr; wadr2LSB <= radr2LSB; state <= STORE1; end
			`LDX_IMM,`LDX_ZP,`LDX_ZPY,`LDX_ABS,`LDX_ABSY:	begin res8 <= b8; end
			`LDY_IMM,`LDY_ZP,`LDY_ZPX,`LDY_ABS,`LDY_ABSX:	begin res8 <= b8; end
			`CPX_IMM,`CPX_ZP,`CPX_ABS:	begin res8 <= x8 - b8; end
			`CPY_IMM,`CPY_ZP,`CPY_ABS:	begin res8 <= y8 - b8; end
			`ASL_ZP,`ASL_ZPX,`ASL_ABS,`ASL_ABSX:	begin res8 <= {b8,1'b0}; wdat <= {4{b8[6:0],1'b0}}; wadr <= radr; wadr2LSB <= radr2LSB; state <= STORE1; end
			`ROL_ZP,`ROL_ZPX,`ROL_ABS,`ROL_ABSX:	begin res8 <= {b8,cf}; wdat <= {4{b8[6:0],cf}}; wadr <= radr; wadr2LSB <= radr2LSB; state <= STORE1; end
			`LSR_ZP,`LSR_ZPX,`LSR_ABS,`LSR_ABSX:	begin res8 <= {b8[0],1'b0,b8[7:1]}; wdat <= {4{1'b0,b8[7:1]}}; wadr <= radr; wadr2LSB <= radr2LSB; state <= STORE1; end
			`ROR_ZP,`ROR_ZPX,`ROR_ABS,`ROR_ABSX:	begin res8 <= {b8[0],cf,b8[7:1]}; wdat <= {4{cf,b8[7:1]}}; wadr <= radr; wadr2LSB <= radr2LSB; state <= STORE1; end
			`INC_ZP,`INC_ZPX,`INC_ABS,`INC_ABSX:	begin res8 <= b8 + 8'd1; wdat <= {4{b8+8'd1}}; wadr <= radr; wadr2LSB <= radr2LSB; state <= STORE1; end
			`DEC_ZP,`DEC_ZPX,`DEC_ABS,`DEC_ABSX:	begin res8 <= b8 - 8'd1; wdat <= {4{b8-8'd1}}; wadr <= radr; wadr2LSB <= radr2LSB; state <= STORE1; end
			endcase
		end
		else begin
			case(ir[7:0])
/*			The following handled in the DECODE stage which reduces the CPI at a cost of clock frequency.
			`RR:
				case(ir[23:20])
				`ADD_RR:	res <= a + b;
				`SUB_RR:	res <= a - b;	// Also CMP
				`AND_RR:	res <= a & b;	// Also BIT
				`OR_RR:		res <= a | b;
				`EOR_RR:	res <= a ^ b;
				`MUL_RR:	prod <= a * b;	// slows the whole core down
				endcase*/
			`ADD_IMM8,`ADD_IMM16,`ADD_IMM32,`ADD_ZPX,`ADD_IX,`ADD_IY,`ADD_ABS,`ADD_ABSX,`ADD_RIND:	begin res <= a + b;	end
			`SUB_IMM8,`SUB_IMM16,`SUB_IMM32,`SUB_ZPX,`SUB_IX,`SUB_IY,`SUB_ABS,`SUB_ABSX,`SUB_RIND:	begin res <= a - b;	end // Also CMP
			`AND_IMM8,`AND_IMM16,`AND_IMM32,`AND_ZPX,`AND_IX,`AND_IY,`AND_ABS,`AND_ABSX,`AND_RIND:	begin res <= a & b; end	// Also BIT
			`OR_IMM8,`OR_IMM16,`OR_IMM32,`OR_ZPX,`OR_IX,`OR_IY,`OR_ABS,`OR_ABSX,`OR_RIND:			begin res <= a | b; end	// Also LD
			`EOR_IMM8,`EOR_IMM16,`EOR_IMM32,`EOR_ZPX,`EOR_IX,`EOR_IY,`EOR_ABS,`EOR_ABSX,`EOR_RIND:	begin res <= a ^ b; end
			`LDX_ZPY,`LDX_ABS,`LDX_ABSY:	begin res <= b; end
			`LDY_ZPX,`LDY_ABS,`LDY_ABSX:	begin res <= b; end
			`CPX_IMM32,`CPX_ZPX,`CPX_ABS:	begin res <= x - b; end
			`CPY_IMM32,`CPY_ZPX,`CPY_ABS:	begin res <= y - b; end
			`ASL_RR:	begin res <= {a,1'b0}; end
			`ROL_RR:	begin res <= {a,cf}; end
			`LSR_RR:	begin res <= {a[0],1'b0,a[31:1]}; end
			`ROR_RR:	begin res <= {a[0],cf,a[31:1]}; end
			`ASL_ZPX,`ASL_ABS,`ASL_ABSX:	begin res <= {b,1'b0}; wdat <= {b,1'b0}; wadr <= radr; wadr2LSB <= radr2LSB; state <= STORE1; end
			`ROL_ZPX,`ROL_ABS,`ROL_ABSX:	begin res <= {b,cf}; wdat <= {b,cf}; wadr <= radr; wadr2LSB <= radr2LSB; state <= STORE1; end
			`LSR_ZPX,`LSR_ABS,`LSR_ABSX:	begin res <= {b[0],1'b0,b[31:1]}; wdat <= {b[0],1'b0,b[31:1]}; wadr <= radr; wadr2LSB <= radr2LSB; state <= STORE1; end
			`ROR_ZPX,`ROR_ABS,`ROR_ABSX:	begin res <= {b[0],cf,b[31:1]}; wdat <= {b[0],cf,b[31:1]}; wadr <= radr; wadr2LSB <= radr2LSB; state <= STORE1; end
			`INC_ZPX,`INC_ABS,`INC_ABSX:	begin res <= b + 1; wdat <= b + 1; wadr <= radr; wadr2LSB <= radr2LSB; state <= STORE1; end
			`DEC_ZPX,`DEC_ABS,`DEC_ABSX:	begin res <= b - 1; wdat <= b - 1; wadr <= radr; wadr2LSB <= radr2LSB; state <= STORE1; end
			`ORB_ZPX,`ORB_ABS,`ORB_ABSX:	begin res <= a | {24'h0,b8}; end
			endcase
		end
	end
