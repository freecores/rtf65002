RTI1:
	if (unCachedData) begin
		cyc_o <= 1'b1;
		stb_o <= 1'b1;
		sel_o <= 4'hF;
		adr_o <= {radr,2'b00};
		state <= RTI2;
	end
	else if (dhit) begin
		cf <= rdat[0];
		zf <= rdat[1];
		im <= rdat[2];
		df <= rdat[3];
		bf <= rdat[4];
		em1 <= rdat[29];
		vf <= rdat[30];
		nf <= rdat[31];
		isp <= isp_inc;
		radr <= isp_inc;
		state <= RTI3;
	end
	else
		dmiss <= `TRUE;
RTI2:
	if (ack_i) begin
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		sel_o <= 4'h0;
		cf <= dat_i[0];
		zf <= dat_i[1];
		im <= dat_i[2];
		df <= dat_i[3];
		bf <= dat_i[4];
		em1 <= dat_i[29];
		vf <= dat_i[30];
		nf <= dat_i[31];
		isp <= isp_inc;
		radr <= isp_inc;
		state <= RTI3;
	end
RTI3:
	if (unCachedData) begin
		cyc_o <= 1'b1;
		stb_o <= 1'b1;
		sel_o <= 4'hF;
		adr_o <= {radr,2'b00};
		state <= RTI4;
	end
	else if (dhit) begin
		isp <= isp_inc;
		em <= em1;
		pc <= rdat;
		state <= IFETCH;
	end
	else
		dmiss <= `TRUE;
RTI4:
	if (ack_i) begin
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		sel_o <= 4'h0;
		adr_o <= 34'h0;
		isp <= isp_inc;
		em <= em1;
		pc <= dat_i;
		state <= IFETCH;
	end
