// ============================================================================
//        __
//   \\__/ o\    (C) 2013  Robert Finch, Stratford
//    \  __ /    All rights reserved.
//     \/_//     robfinch<remove>@opencores.org
//       ||
//
// rtf65002.v
//  - 32 bit CPU multiplier/divider
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
`define MUL		4'd8
`define MULS	4'd9
`define DIV		4'd10
`define DIVS	4'd11
`define MOD		4'd12
`define MODS	4'd13

module mult_div(rst, clk, ld, op, a, b, p, q, r, done);
parameter IDLE=3'd0;
parameter MULT=3'd1;
parameter FIX_SIGN=3'd2;
parameter DIV=3'd3;
input rst;
input clk;
input ld;
input [3:0] op;
input [31:0] a;
input [31:0] b;
output reg [63:0] p;
output reg [31:0] q;
output reg [31:0] r;
output done;

reg [31:0] aa, bb;
reg res_sgn;

reg [2:0] state;

assign done = state==IDLE;
wire [31:0] diff = r - bb;
wire [31:0] pa = a[31] ? -a : a;
reg [5:0] cnt;

always @(posedge clk)
if (rst)
state <= IDLE;
else begin
case(state)
IDLE:
	if (ld) begin
		cnt <= 6'd32;
		case(op)
		`MUL:
			begin
				aa <= a;
				bb <= b;
				res_sgn <= 1'b0;
				state <= MULT;
			end
		`MULS:
			begin
				aa <= a[31] ? -a : a;
				bb <= b[31] ? -b : b;
				res_sgn <= a[31] ^ b[31];
				state <= MULT;
			end
		`DIV,`MOD:
			begin
				aa <= a;
				bb <= b;
				q <= a[30:0];
				r <= a[31];
				res_sgn <= 1'b0;
				state <= DIV;
			end
		`DIVS,`MODS:
			begin
				aa <= a[31] ? -a : a;
				bb <= b[31] ? -b : b;
				q <= pa[30:0];
				r <= pa[31];
				res_sgn <= a[31] ^ b[31];
				state <= DIV;
			end
		default:
			state <= IDLE;
		endcase
	end
MULT:
	begin
		state <= res_sgn ? FIX_SIGN : IDLE;
		p <= aa * bb;
	end
DIV:
	begin
		q <= {q[30:0],~diff[31]};
		if (cnt==6'd0) begin
			state <= res_sgn ? FIX_SIGN : IDLE;
			if (diff[31])
				r <= r[30:0];
			else
				r <= diff[30:0];
		end
		else begin
			if (diff[31])
				r <= {r[30:0],q[31]};
			else
				r <= {diff[30:0],q[31]};
		end
		cnt <= cnt - 6'd1;
	end

FIX_SIGN:
	begin
		state <= IDLE;
		if (res_sgn) begin
			p <= -p;
			q <= -q;
			r <= -r;
		end
	end
default:	state <= IDLE;
endcase
end

endmodule

module multdiv_tb();
reg rst;
reg clk;
reg ld;

initial begin
	#0 clk = 1'b0;
	#0 rst = 1'b0;
	#10 rst = 1'b1;
	#10 rst = 1'b0;
	#10 ld = 1'b1;
	#20 ld = 1'b0;
end

always #10 clk = ~clk;

mult_div umd1 (
	.rst(rst),
	.clk(clk),
	.ld(ld),
	.op(`DIV),
	.a(32'h12345678),
	.b(32'd10),
	.p(),
	.q(),
	.r(),
	.done()
);

endmodule
