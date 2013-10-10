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
`ifdef SUPPORT_STRING
MVN3:
	begin
		state <= IFETCH;
		res <= alu_out;
		if (acc==32'hFFFFFFFF)
			pc <= pc + 32'd1;
	end
CMPS1:
	begin
		state <= IFETCH;
		res <= alu_out;
		if (a!=b || acc==32'hFFFFFFFF) begin
			cf <= !(ltu|eq);
			nf <= lt;
			vf <= 1'b0;
			zf <= eq;
			pc <= pc + 32'd1;
		end
	end
`endif
