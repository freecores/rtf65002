PLP1:
	if (unCachedData) begin
		cyc_o <= 1'b1;
		stb_o <= 1'b1;
		sel_o <= 4'hF;
		adr_o <= {radr,2'b00};
		state <= PLP2;
	end
	else if (dhit) begin
		cf <= rdat[0];
		zf <= rdat[1];
		im <= rdat[2];
		df <= rdat[3];
		bf <= rdat[4];
		em <= rdat[29];
		vf <= rdat[30];
		nf <= rdat[31];
		isp <= isp_inc;
		radr <= isp_inc;
		state <= IFETCH;
	end
	else
		dmiss <= `TRUE;
PLP2:
	if (ack_i) begin
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		sel_o <= 4'h0;
		cf <= dat_i[0];
		zf <= dat_i[1];
		im <= dat_i[2];
		df <= dat_i[3];
		bf <= dat_i[4];
		em <= dat_i[29];
		vf <= dat_i[30];
		nf <= dat_i[31];
		isp <= isp_inc;
		radr <= isp_inc;
		state <= IFETCH;
	end
