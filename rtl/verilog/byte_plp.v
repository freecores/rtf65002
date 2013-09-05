BYTE_PLP1:
	if (unCachedData) begin
		cyc_o <= 1'b1;
		stb_o <= 1'b1;
		sel_o <= 4'hF;
		adr_o <= {radr,2'b00};
		state <= BYTE_PLP2;
	end
	else if (dhit) begin
		cf <= rdat8[0];
		zf <= rdat8[1];
		im <= rdat8[2];
		df <= rdat8[3];
		bf <= rdat8[4];
		vf <= rdat8[6];
		nf <= rdat8[7];
		state <= IFETCH;
	end
	else
		dmiss <= `TRUE;
BYTE_PLP2:
	if (ack_i) begin
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		sel_o <= 4'h0;
		cf <= dati[0];
		zf <= dati[1];
		im <= dati[2];
		df <= dati[3];
		bf <= dati[4];
		vf <= dati[6];
		nf <= dati[7];
		state <= IFETCH;
	end
