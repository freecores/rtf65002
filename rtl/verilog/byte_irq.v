// IRQ processing states
// The high order PC[31:16] is set to zero, forcing the IRQ routine to be in bank zero.
//
BYTE_IRQ1:
	if (ack_i) begin
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		we_o <= 1'b0;
		sel_o <= 4'h0;
		sp <= sp_dec;
		if (dhit) begin
			wrsel <= sel_o;
			wr <= 1'b1;
		end
		state <= BYTE_IRQ2;
	end
BYTE_IRQ2:
	begin
		radr <= {24'h1,sp[7:2]};
		radr2LSB <= sp[1:0];
		wadr <= {24'h1,sp[7:2]};
		wadr2LSB <= sp[1:0];
		wdat <= {4{pc[23:16]}};
		cyc_o <= 1'b1;
		stb_o <= 1'b1;
		we_o <= 1'b1;
		case(sp[1:0])
		2'd0:	sel_o <= 4'b0001;
		2'd1:	sel_o <= 4'b0010;
		2'd2:	sel_o <= 4'b0100;
		2'd3:	sel_o <= 4'b1000;
		endcase
		adr_o <= {24'h1,sp[7:2],2'b00};
		dat_o <= {4{pc[23:16]}};
		state <= BYTE_IRQ3;
	end
BYTE_IRQ3:
	if (ack_i) begin
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		we_o <= 1'b0;
		sel_o <= 4'h0;
		sp <= sp_dec;
		if (dhit) begin
			wrsel <= sel_o;
			wr <= 1'b1;
		end
		state <= BYTE_IRQ4;
	end
BYTE_IRQ4:
	begin
		radr <= {24'h1,sp[7:2]};
		radr2LSB <= sp[1:0];
		wadr <= {24'h1,sp[7:2]};
		wadr2LSB <= sp[1:0];
		wdat <= {4{pc[15:8]}};
		cyc_o <= 1'b1;
		stb_o <= 1'b1;
		we_o <= 1'b1;
		case(sp[1:0])
		2'd0:	sel_o <= 4'b0001;
		2'd1:	sel_o <= 4'b0010;
		2'd2:	sel_o <= 4'b0100;
		2'd3:	sel_o <= 4'b1000;
		endcase
		adr_o <= {24'h1,sp[7:2],2'b00};
		dat_o <= {4{pc[15:8]}};
		state <= BYTE_IRQ5;
	end
BYTE_IRQ5:
	if (ack_i) begin
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		we_o <= 1'b0;
		sel_o <= 4'h0;
		sp <= sp_dec;
		if (dhit) begin
			wrsel <= sel_o;
			wr <= 1'b1;
		end
		state <= BYTE_IRQ6;
	end
BYTE_IRQ6:
	begin
		radr <= {24'h1,sp[7:2]};
		radr2LSB <= sp[1:0];
		wadr <= {24'h1,sp[7:2]};
		wadr2LSB <= sp[1:0];
		wdat <= {4{pc[7:0]}};
		cyc_o <= 1'b1;
		stb_o <= 1'b1;
		we_o <= 1'b1;
		case(sp[1:0])
		2'd0:	sel_o <= 4'b0001;
		2'd1:	sel_o <= 4'b0010;
		2'd2:	sel_o <= 4'b0100;
		2'd3:	sel_o <= 4'b1000;
		endcase
		adr_o <= {24'h1,sp[7:2],2'b00};
		dat_o <= {4{pc[7:0]}};
		state <= BYTE_IRQ7;
	end
BYTE_IRQ7:
	if (ack_i) begin
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		we_o <= 1'b0;
		sel_o <= 4'h0;
		sp <= sp_dec;
		if (dhit) begin
			wrsel <= sel_o;
			wr <= 1'b1;
		end
		state <= BYTE_IRQ8;
	end
BYTE_IRQ8:
	begin
		radr <= {24'h1,sp[7:2]};
		radr2LSB <= sp[1:0];
		wadr <= {24'h1,sp[7:2]};
		wadr2LSB <= sp[1:0];
		wdat <= {4{sr8[7:0]}};
		cyc_o <= 1'b1;
		stb_o <= 1'b1;
		we_o <= 1'b1;
		case(sp[1:0])
		2'd0:	sel_o <= 4'b0001;
		2'd1:	sel_o <= 4'b0010;
		2'd2:	sel_o <= 4'b0100;
		2'd3:	sel_o <= 4'b1000;
		endcase
		adr_o <= {24'h1,sp[7:2],2'b00};
		dat_o <= {4{sr8[7:0]}};
		state <= BYTE_IRQ9;
	end
BYTE_IRQ9:
	if (ack_i) begin
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		we_o <= 1'b0;
		sel_o <= 4'h0;
		sp <= sp_dec;
		if (dhit) begin
			wrsel <= sel_o;
			wr <= 1'b1;
		end
		pc[31:16] <= 16'h0000;
		radr <= vect[31:2];
		radr2LSB <= vect[1:0];
		state <= BYTE_JMP_IND1;
	end
	