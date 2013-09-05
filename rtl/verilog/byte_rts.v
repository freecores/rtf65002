// Eight bit mode RTS/RTL states
//
BYTE_RTS1:
	if (unCachedData) begin
		cyc_o <= 1'b1;
		stb_o <= 1'b1;
		sel_o <= 4'hF;
		adr_o <= {radr,2'b00};
		state <= BYTE_RTS2;
	end
	else if (dhit) begin
		radr <= {26'h1,sp_inc[7:2]};
		radr2LSB <= sp_inc[1:0];
		sp <= sp_inc;
		pc[7:0] <= rdat8;
		state <= BYTE_RTS3;
	end
	else
		dmiss <= `TRUE;
BYTE_RTS2:
	if (ack_i) begin
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		sel_o <= 4'h0;
		adr_o <= 34'h0;
		radr <= {26'h1,sp_inc[7:2]};
		radr2LSB <= sp_inc[1:0];
		sp <= sp_inc;
		pc[7:0] <= dati;
		state <= BYTE_RTS3;
	end
BYTE_RTS3:
	if (unCachedData) begin
		cyc_o <= 1'b1;
		stb_o <= 1'b1;
		sel_o <= 4'hF;
		adr_o <= {radr,2'b00};
		state <= BYTE_RTS4;
	end
	else if (dhit) begin
		if (ir[7:0]==`RTL) begin
			radr <= {26'h1,sp_inc[7:2]};
			radr2LSB <= sp_inc[1:0];
			sp <= sp_inc;
		end
		pc[15:8] <= rdat8;
		state <= BYTE_RTS5;
	end
	else
		dmiss <= `TRUE;
BYTE_RTS4:
	if (ack_i) begin
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		sel_o <= 4'h0;
		adr_o <= 34'h0;
		pc[15:8] <= dati;
		if (ir[7:0]==`RTL) begin
			radr <= {26'h1,sp_inc[7:2]};
			radr2LSB <= sp_inc[1:0];
			sp <= sp_inc;
		end
		state <= BYTE_RTS5;
	end
BYTE_RTS5:
	if (ir[7:0]!=`RTL) begin
		pc <= pc + 32'd1;
		state <= IFETCH;
	end
	else begin
		if (unCachedData) begin
			cyc_o <= 1'b1;
			stb_o <= 1'b1;
			sel_o <= 4'hF;
			adr_o <= {radr,2'b00};
			state <= BYTE_RTS6;
		end
		else if (dhit) begin
			radr <= {26'h1,sp_inc[7:2]};
			radr2LSB <= sp_inc[1:0];
			sp <= sp_inc;
			pc[23:16] <= rdat8;
			state <= BYTE_RTS7;
		end
		else
			dmiss <= `TRUE;
	end
BYTE_RTS6:
	if (ack_i) begin
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		sel_o <= 4'h0;
		adr_o <= 34'h0;
		pc[23:16] <= dati;
		radr <= {26'h1,sp_inc[7:2]};
		radr2LSB <= sp_inc[1:0];
		sp <= sp_inc;
		state <= BYTE_RTS7;
	end
BYTE_RTS7:
	if (unCachedData) begin
		cyc_o <= 1'b1;
		stb_o <= 1'b1;
		sel_o <= 4'hF;
		adr_o <= {radr,2'b00};
		state <= BYTE_RTS8;
	end
	else if (dhit) begin
		pc[31:24] <= rdat8;
		state <= BYTE_RTS9;
	end
	else
		dmiss <= `TRUE;
BYTE_RTS8:
	if (ack_i) begin
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		sel_o <= 4'h0;
		adr_o <= 34'h0;
		pc[31:24] <= dati;
		state <= BYTE_RTS9;
	end
BYTE_RTS9:
	begin
		pc <= pc + 32'd1;
		state <= IFETCH;
	end
