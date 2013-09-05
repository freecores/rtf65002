// Works for both eight bit and 32 bit modes
//
PLA1:
	if (unCachedData) begin
		cyc_o <= 1'b1;
		stb_o <= 1'b1;
		sel_o <= 4'hF;
		adr_o <= {radr,2'b00};
		state <= PLA2;
	end
	else if (dhit) begin
		res8 <= rdat8;
		res <= rdat;
		state <= IFETCH;
	end
	else
		dmiss <= `TRUE;
PLA2:
	if (ack_i) begin
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		sel_o <= 4'h0;
		adr_o <= 34'h0;
		res8 <= dati;
		res <= dat_i;
		state <= IFETCH;
	end
