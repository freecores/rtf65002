// Indirect Y addressing mode eg. LDA ($12),y
BYTE_IY1:
	if (unCachedData) begin
		cyc_o <= 1'b1;
		stb_o <= 1'b1;
		sel_o <= 4'hf;
		adr_o <= {radr,2'b00};
		state <= BYTE_IY2;
	end
	else if (dhit) begin
		ia[7:0] <= rdat8;
		radr <= radr34p1[33:2];
		radr2LSB <= radr34p1[1:0];
		state <= BYTE_IY3;
	end
	else
		dmiss <= `TRUE;
BYTE_IY2:
	if (ack_i) begin
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		sel_o <= 4'h0;
		adr_o <= 34'h0;
		ia[7:0] <= dati;
		radr <= radr34p1[33:2];
		radr2LSB <= radr34p1[1:0];
		state <= BYTE_IY3;
	end
BYTE_IY3:
	if (unCachedData) begin
		cyc_o <= 1'b1;
		stb_o <= 1'b1;
		sel_o <= 4'hf;
		adr_o <= {radr,2'b00};
		state <= BYTE_IY4;
	end
	else if (dhit) begin
		ia[15:8] <= rdat8;
		ia[31:16] <= 16'h0000;
		radr <= radr34p1[33:2];
		radr2LSB <= radr34p1[1:0];
		state <= BYTE_IY5;
	end
	else
		dmiss <= `TRUE;	
BYTE_IY4:
	if (ack_i) begin
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		sel_o <= 4'h0;
		adr_o <= 34'h0;
		ia[15:8] <= dati;
		ia[31:16] <= 16'h0000;
		radr <= radr34p1[33:2];
		radr2LSB <= radr34p1[1:0];
		state <= BYTE_IY5;
	end
BYTE_IY5:
	begin
		radr <= iapy8[31:2];
		radr2LSB <= iapy8[1:0];
		$display("IY addr: %h", iapy8);
		if (ir==`STA_IY) begin
			wadr <= iapy8[31:2];
			wadr2LSB <= iapy8[1:0];
			wdat <= {4{acc8}};
			state <= STORE1;
		end
		else
			state <= LOAD1;
	end
	