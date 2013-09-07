// Cache controller
// Also takes care of loading the instruction buffer for non-cached access
//
case(cstate)
IDLE:
	begin
		if (!cyc_o) begin
			// A write to a cacheable address does not cause a cache load
			if (dmiss) begin
				isDataCacheLoad <= `TRUE;
				if (isRMW)
					lock_o <= 1'b1;
				cti_o <= 3'b001;
				bl_o <= 6'd3;
				cyc_o <= 1'b1;
				stb_o <= 1'b1;
				sel_o <= 4'hF;
				adr_o <= {radr[31:2],4'h0};
				cstate <= LOAD_DCACHE;
			end
			else if (!unCachedInsn && imiss && !hit0) begin
				isInsnCacheLoad <= `TRUE;
				bte_o <= 2'b00;
				cti_o <= 3'd001;
				bl_o <= 6'd3;
				cyc_o <= 1'b1;
				stb_o <= 1'b1;
				sel_o <= 4'hF;
				adr_o <= {pc[31:4],4'h0};
				cstate <= LOAD_ICACHE;
			end
			else if (!unCachedInsn && imiss && !hit1) begin
				isInsnCacheLoad <= `TRUE;
				bte_o <= 2'b00;
				cti_o <= 3'd001;
				bl_o <= 6'd3;
				cyc_o <= 1'b1;
				stb_o <= 1'b1;
				sel_o <= 4'hF;
				adr_o <= {pcp8[31:4],4'h0};
				cstate <= LOAD_ICACHE;
			end
			else if (unCachedInsn && imiss) begin
				bte_o <= 2'b00;
				cti_o <= 3'b001;
				bl_o <= 6'd2;
				cyc_o <= 1'b1;
				stb_o <= 1'b1;
				sel_o <= 4'hf;
				adr_o <= {pc[31:2],2'b00};
				cstate <= LOAD_IBUF1;
			end
		end
	end
LOAD_DCACHE:
	if (ack_i) begin
		if (adr_o[3:2]==2'b11) begin
			dmiss <= `FALSE;
			isDataCacheLoad <= `FALSE;
			cti_o <= 3'b000;
			bl_o <= 6'd0;
			cyc_o <= 1'b0;
			stb_o <= 1'b0;
			sel_o <= 4'h0;
			adr_o <= 34'h0;
			cstate <= IDLE;
		end
		adr_o <= adr_o + 34'd4;
	end
LOAD_ICACHE:
	if (ack_i) begin
		if (adr_o[3:2]==2'b11) begin
			imiss <= `FALSE;
			isInsnCacheLoad <= `FALSE;
			cti_o <= 3'b000;
			bl_o <= 6'd0;
			cyc_o <= 1'b0;
			stb_o <= 1'b0;
			sel_o <= 4'h0;
			adr_o <= 34'd0;
			cstate <= IDLE;
		end
		adr_o <= adr_o + 34'd4;
	end
LOAD_IBUF1:
	if (ack_i) begin
		case(pc[1:0])
		2'd0:	ibuf <= dat_i;
		2'd1:	ibuf <= dat_i[31:8];
		2'd2:	ibuf <= dat_i[31:16];
		2'd3:	ibuf <= dat_i[31:24];
		endcase
		cstate <= LOAD_IBUF2;
		adr_o <= adr_o + 34'd4;
	end
LOAD_IBUF2:
	if (ack_i) begin
		case(pc[1:0])
		2'd0:	ibuf[55:32] <= dat_i[23:0];
		2'd1:	ibuf[55:24] <= dat_i[31:0];
		2'd2:	ibuf[47:16] <= dat_i[23:0];
		2'd3:	ibuf[39:8] <= dat_i;
		endcase
		cstate <= LOAD_IBUF3;
		adr_o <= adr_o + 34'd4;
	end
LOAD_IBUF3:
	if (ack_i) begin
		case(pc[1:0])
		2'd0:	;
		2'd1:	;
		2'd2:	ibuf[55:48] <= dat_i[7:0];
		2'd3:	ibuf[55:40] <= dat_i[15:0];
		endcase
		cti_o <= 3'd0;
		bl_o <= 6'd0;
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		sel_o <= 4'h0;
		adr_o <= 34'd0;
		cstate <= IDLE;
		imiss <= `FALSE;
		bufadr <= pc;	// clears the miss
	end
endcase