RTS1:
	if (unCachedData) begin
		cyc_o <= 1'b1;
		stb_o <= 1'b1;
		sel_o <= 4'hF;
		adr_o <= {radr,2'b00};
		state <= RTS2;
	end
	else if (dhit) begin
		isp <= isp_inc;
		pc <= rdat;
		state <= IFETCH;
	end
	else
		dmiss <= `TRUE;
RTS2:
	if (ack_i) begin
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		sel_o <= 4'h0;
		adr_o <= 34'h0;
		isp <= isp_inc;
		pc <= dat_i;
		state <= IFETCH;
	end
