module data_sampling_RX(
input   wire        CLK_SAM,
input   wire        RST_SAM,
input   wire        RX_IN,
input   wire        data_samp_en,
input   wire [5:0]  edge_cnt,
input   wire [5:0]  prescale,
output  reg         sample_bit_samp
);
reg [1:0]RX_IN_reg;
always @(posedge CLK_SAM or negedge RST_SAM) begin
		if(!RST_SAM)  begin
                	sample_bit_samp <= 1'b1; // IDLE STATE
                    RX_IN_reg <= 0;
            	end
		else begin
            if (data_samp_en) begin
                    if ((edge_cnt == ((prescale / 2) - 1)) || (edge_cnt == ((prescale / 2))) || (edge_cnt == ((prescale / 2) + 1))) begin
                        if (RX_IN == 1) begin
                            RX_IN_reg <= RX_IN_reg +1;
                        end
                    end
                    else if (edge_cnt == (prescale - 2)) begin
                        if (RX_IN_reg > 1) begin
                            sample_bit_samp <= 1'b1;
                        end
                        else begin
                            sample_bit_samp <= 1'b0;
                        end 
                        RX_IN_reg <=0;
                    end
            end 
            else begin
                sample_bit_samp <= 1'b1;
                RX_IN_reg <= 0;
            end
        end
                    
end 
endmodule
