BYTE_JSL1:
	if (ack_i) begin
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		we_o <= 1'b0;
		sel_o <= 4'h0;
		if (dhit) begin
			wrsel <= sel_o;
			wr <= 1'b1;
		end
		state <= BYTE_JSL2;
	end
BYTE_JSL2:
	begin
		radr <= {24'h1,sp[7:2]};
		wadr <= {24'h1,sp[7:2]};
		radr2LSB <= sp[1:0];
		wadr2LSB <= sp[1:0];
		wdat <= {4{pcp4[23:16]}};
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
		dat_o <= {4{pcp4[23:16]}};
		sp <= sp_dec;
		state <= BYTE_JSL3;
	end
BYTE_JSL3:
	if (ack_i) begin
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		we_o <= 1'b0;
		sel_o <= 4'h0;
		if (dhit) begin
			wrsel <= sel_o;
			wr <= 1'b1;
		end
		state <= BYTE_JSL4;
	end
BYTE_JSL4:
	begin
		radr <= {24'h1,sp[7:2]};
		wadr <= {24'h1,sp[7:2]};
		radr2LSB <= sp[1:0];
		wadr2LSB <= sp[1:0];
		wdat <= {4{pcp4[15:8]}};
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
		dat_o <= {4{pcp4[15:8]}};
		sp <= sp_dec;
		state <= BYTE_JSL5;
	end
BYTE_JSL5:
	if (ack_i) begin
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		we_o <= 1'b0;
		sel_o <= 4'h0;
		if (dhit) begin
			wrsel <= sel_o;
			wr <= 1'b1;
		end
		state <= BYTE_JSL6;
	end
BYTE_JSL6:
	begin
		radr <= {24'h1,sp[7:2]};
		wadr <= {24'h1,sp[7:2]};
		radr2LSB <= sp[1:0];
		wadr2LSB <= sp[1:0];
		wdat <= {4{pcp4[7:0]}};
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
		dat_o <= {4{pcp4[7:0]}};
		sp <= sp_dec;
		state <= BYTE_JSL7;
	end
BYTE_JSL7:
	if (ack_i) begin
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		we_o <= 1'b0;
		sel_o <= 4'h0;
		if (dhit) begin
			wrsel <= sel_o;
			wr <= 1'b1;
		end
		pc <= ir[39:8];
		state <= IFETCH;
	end
