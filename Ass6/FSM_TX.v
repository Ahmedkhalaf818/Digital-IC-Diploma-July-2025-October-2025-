module FSM_TX (
input wire DATA_VALID_FSM,
input wire RST_FSM,
input wire CLK_FSM,
input wire SER_DONE_FSM,
input wire PAR_EN_FSM,
output reg SER_EN_FSM,
output reg BUSY_FSM,
output reg [1:0] MUX_SEL_FSM
);
reg BUSY_FSM_c;
localparam IDLE=3'b000;
localparam START_BIT=3'b001;
localparam TRANS=3'b011;
localparam PARIY_BIT=3'b010;
localparam STOP_BIT=3'b110;
reg [2:0] cs,ns;
// cs state 
always @(posedge CLK_FSM or negedge RST_FSM) begin
		if(!RST_FSM)  begin
                	cs <= IDLE;
            	end
		else
                    cs <= ns;
end 
// ns state
always @(*) begin
	case (cs)
	IDLE: begin
		if (DATA_VALID_FSM) begin
			ns = START_BIT;
			BUSY_FSM_c = 1'b1;
			SER_EN_FSM = 1'b0;
			MUX_SEL_FSM = 2'b00;
		end 
		else begin
			ns = IDLE;
			BUSY_FSM_c = 1'b0;
			SER_EN_FSM = 1'b0;
			MUX_SEL_FSM = 2'b01;
		end 
		end
	
	START_BIT: begin
			ns = TRANS;
			BUSY_FSM_c = 1'b1;
			SER_EN_FSM = 1'b1;
			MUX_SEL_FSM = 2'b10;
		end
	TRANS: begin
		if (SER_DONE_FSM) begin
			if (PAR_EN_FSM) begin
				ns = PARIY_BIT;
				BUSY_FSM_c = 1'b1;
				SER_EN_FSM = 1'b0;
				MUX_SEL_FSM = 2'b11;
			end
			else begin
				ns = STOP_BIT;
				BUSY_FSM_c = 1'b1;
				SER_EN_FSM = 1'b0;
				MUX_SEL_FSM = 2'b01;
			end
			
		end 
		else begin
			ns = TRANS;
			BUSY_FSM_c = 1'b1;
			SER_EN_FSM = 1'b1;
			MUX_SEL_FSM = 2'b10;
		end 
		end
	PARIY_BIT: begin 
			ns = STOP_BIT; 
			BUSY_FSM_c = 1'b1;
			SER_EN_FSM = 1'b0;
			MUX_SEL_FSM = 2'b01;
	
	end
	
	STOP_BIT:begin
				if (DATA_VALID_FSM) begin
					ns=START_BIT;
					BUSY_FSM_c = 1'b1;
					SER_EN_FSM = 1'b0;
					MUX_SEL_FSM = 2'b00;
				end
				else begin
					ns=IDLE;
					BUSY_FSM_c = 1'b0;
					SER_EN_FSM = 1'b0;
					MUX_SEL_FSM = 2'b01;
				end
			 end
	default: begin 
			ns=IDLE; 
			BUSY_FSM_c = 1'b0;
			SER_EN_FSM = 1'b0;
			MUX_SEL_FSM = 2'b01;
	end
	endcase
end
always @(posedge CLK_FSM or negedge RST_FSM) begin
		if(!RST_FSM)  begin
                	BUSY_FSM <= 1'b0;
            	end
		else
                    BUSY_FSM <= BUSY_FSM_c;
end 
endmodule
