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
// Datapath calculations for 32 bit mode.                       
// ============================================================================
//
CALC:
	begin
		state <= IFETCH;
		case(ir[7:0])
		//The following handled in the DECODE stage which reduces the CPI at a cost of clock frequency.
		`RR:
			case(ir[23:20])
//				`ADD_RR:	res <= a + b;
//				`SUB_RR:	res <= a - b;	// Also CMP
//				`AND_RR:	res <= a & b;	// Also BIT
//				`OR_RR:		res <= a | b;
//				`EOR_RR:	res <= a ^ b;
//				`MUL_RR:	prod <= a * b;	// slows the whole core down
			`ASL_RRR:	res <= shlo;
			`LSR_RRR:	res <= shro;
			endcase
		`ADD_ZPX,`ADD_IX,`ADD_IY,`ADD_ABS,`ADD_ABSX,`ADD_RIND:	begin res <= a + b;	end
		`SUB_ZPX,`SUB_IX,`SUB_IY,`SUB_ABS,`SUB_ABSX,`SUB_RIND:	begin res <= a - b;	end // Also CMP
		`AND_ZPX,`AND_IX,`AND_IY,`AND_ABS,`AND_ABSX,`AND_RIND:	begin res <= a & b; end	// Also BIT
		`OR_ZPX,`OR_IX,`OR_IY,`OR_ABS,`OR_ABSX,`OR_RIND:			begin res <= a | b; end	// Also LD
		`EOR_ZPX,`EOR_IX,`EOR_IY,`EOR_ABS,`EOR_ABSX,`EOR_RIND:	begin res <= a ^ b; end
		`LDX_ZPY,`LDX_ABS,`LDX_ABSY:	begin res <= b; end
		`LDY_ZPX,`LDY_ABS,`LDY_ABSX:	begin res <= b; end
		`CPX_ZPX,`CPX_ABS:	begin res <= x - b; end
		`CPY_ZPX,`CPY_ABS:	begin res <= y - b; end
		`ASL_IMM8:	res <= shlo;
		`LSR_IMM8:	res <= shro;
		//The following handled in the DECODE stage which reduces the CPI at a cost of clock frequency.
//			`ASL_RR:	begin res <= {a,1'b0}; end
//			`ROL_RR:	begin res <= {a,cf}; end
//			`LSR_RR:	begin res <= {a[0],1'b0,a[31:1]}; end
//			`ROR_RR:	begin res <= {a[0],cf,a[31:1]}; end
		`ASL_ZPX,`ASL_ABS,`ASL_ABSX:	begin res <= {b,1'b0}; wdat <= {b,1'b0}; wadr <= radr; wadr2LSB <= radr2LSB; state <= STORE1; end
		`ROL_ZPX,`ROL_ABS,`ROL_ABSX:	begin res <= {b,cf}; wdat <= {b,cf}; wadr <= radr; wadr2LSB <= radr2LSB; state <= STORE1; end
		`LSR_ZPX,`LSR_ABS,`LSR_ABSX:	begin res <= {b[0],1'b0,b[31:1]}; wdat <= {b[0],1'b0,b[31:1]}; wadr <= radr; wadr2LSB <= radr2LSB; state <= STORE1; end
		`ROR_ZPX,`ROR_ABS,`ROR_ABSX:	begin res <= {b[0],cf,b[31:1]}; wdat <= {b[0],cf,b[31:1]}; wadr <= radr; wadr2LSB <= radr2LSB; state <= STORE1; end
		`INC_ZPX,`INC_ABS,`INC_ABSX:	begin res <= b + 1; wdat <= b + 1; wadr <= radr; wadr2LSB <= radr2LSB; state <= STORE1; end
		`DEC_ZPX,`DEC_ABS,`DEC_ABSX:	begin res <= b - 1; wdat <= b - 1; wadr <= radr; wadr2LSB <= radr2LSB; state <= STORE1; end
		`ORB_ZPX,`ORB_ABS,`ORB_ABSX:	begin res <= a | {24'h0,b8}; end
		endcase
	end
