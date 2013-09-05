// Indirect and indirect X addressing mode eg. LDA ($12,x) : (zp)
BYTE_IX1:
	if (unCachedData) begin
		cyc_o <= 1'b1;
		stb_o <= 1'b1;
		sel_o <= 4'hf;
		adr_o <= {radr,2'b00};
		state <= BYTE_IX2;
	end
	else if (dhit) begin
		radr <= radr34p1[33:2];
		radr2LSB <= radr34p1[1:0];
		ia[7:0] <= rdat8;
		state <= BYTE_IX3;
	end
	else
		dmiss <= `TRUE;
BYTE_IX2:
	if (ack_i) begin
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		sel_o <= 4'h0;
		adr_o <= 34'h0;
		ia[7:0] <= dati;
		radr <= radr34p1[33:2];
		radr2LSB <= radr34p1[1:0];
		state <= BYTE_IX3;
	end
BYTE_IX3:
	if (unCachedData) begin
		cyc_o <= 1'b1;
		stb_o <= 1'b1;
		sel_o <= 4'hf;
		adr_o <= {radr,2'b00};
		state <= BYTE_IX4;
	end
	else if (dhit) begin
		ia[15:8] <= rdat8;
		ia[31:16] <= 16'h0000;
		state <= BYTE_IX5;
	end
	else
		dmiss <= `TRUE;
BYTE_IX4:
	if (ack_i) begin
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		sel_o <= 4'h0;
		adr_o <= 34'h0;
		ia[15:8] <= dati;
		ia[31:16] <= 16'h0000;
		state <= BYTE_IX5;
	end
BYTE_IX5:
	begin
		radr <= ia[31:2];
		radr2LSB <= ia[1:0];
		state <= LOAD1;
		if (ir[7:0]==`STA_IX || ir[7:0]==`STA_I) begin
			wadr <= ia[31:2];
			wadr2LSB <= ia[1:0];
			wdat <= {4{acc8}};
			state <= STORE1;
		end
	end
