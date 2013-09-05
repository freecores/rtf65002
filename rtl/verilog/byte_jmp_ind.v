BYTE_JMP_IND1:
	if (unCachedData) begin
		cyc_o <= 1'b1;
		stb_o <= 1'b1;
		sel_o <= 4'hF;
		adr_o <= {radr,2'b00};
		state <= BYTE_JMP_IND2;
	end
	else if (dhit) begin
		pc[7:0] <= rdat8;
		radr <= radr34p1[33:2];
		radr2LSB <= radr34p1[1:0];
		state <= BYTE_JMP_IND3;
	end
	else
		dmiss <= `TRUE;
BYTE_JMP_IND2:
	if (ack_i) begin
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		sel_o <= 4'h0;
		adr_o <= 34'd0;
		radr <= radr34p1[33:2];
		radr2LSB <= radr34p1[1:0];
		pc[7:0] <= dati;
		state <= BYTE_JMP_IND3;
	end
BYTE_JMP_IND3:
	if (unCachedData) begin
		cyc_o <= 1'b1;
		stb_o <= 1'b1;
		sel_o <= 4'hF;
		adr_o <= {radr,2'b00};
		state <= BYTE_JMP_IND4;
	end
	else if (dhit) begin
		pc[15:8] <= rdat8;
		state <= IFETCH;
	end
	else
		dmiss <= `TRUE;
BYTE_JMP_IND4:
	if (ack_i) begin
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		sel_o <= 4'h0;
		adr_o <= 34'd0;
		pc[15:8] <= dati;
		state <= IFETCH;
	end
