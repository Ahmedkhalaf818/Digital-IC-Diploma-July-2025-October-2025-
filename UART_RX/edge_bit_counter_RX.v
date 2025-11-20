module edge_bit_counter_RX(
input   wire  CLK_EDGE,
input   wire  RST_EDGE,
input   wire  enable_edge,
input wire [5:0] prescale_edge,
output reg [5:0] bit_cnt_edge,
output reg [5:0] edge_cnt_edge 
);
always @(posedge CLK_EDGE or negedge RST_EDGE) begin
		if(!RST_EDGE)  begin
                	bit_cnt_edge <= 0;
            	end
		else begin
            if (enable_edge) begin
                if (edge_cnt_edge == (prescale_edge-1))  begin
                        bit_cnt_edge <= bit_cnt_edge+1;
                end
            end
            else begin
                bit_cnt_edge <= 0;
            end
        end
end 
//edge_cnt_edge logic
always @(posedge CLK_EDGE or negedge RST_EDGE) begin
		if(!RST_EDGE)  begin
                	edge_cnt_edge <= 0;
            	end
		else begin
            if (enable_edge) begin
                if (edge_cnt_edge != (prescale_edge-1)) begin
                    edge_cnt_edge <= edge_cnt_edge+1;
                end
                else begin
                    edge_cnt_edge <= 0;
                end

            end
            else begin
                edge_cnt_edge <= 0;
            end
        end
                  
end 
endmodule
