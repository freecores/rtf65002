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
// Memory store states
// The store states work for either eight bit or 32 bit mode              
// ============================================================================
//
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
		if (isMove)
			state <= MVN3;
		else
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
			if (isMove)
				retstate <= MVN3;
			else
				retstate <= IFETCH;
		end
	end
	else if (err_i) begin
		lock_o <= 1'b0;
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		we_o <= 1'b0;
		sel_o <= 4'h0;
		dat_o <= 32'h0;
		state <= BUS_ERROR;
	end

	