module FSM_RX(
input   wire        CLK_FSM,
input   wire        RST_FSM,

input   wire        RX_IN,
input   wire  [5:0] bit_cnt_FSM,
input   wire  [5:0] edge_cnt_FSM,
input   wire        PAR_EN_FSM,
input   wire        par_err_FSM,
input   wire        strt_glitch_FSM,
input   wire        stp_err_FSM,
input   wire [5:0]  prescale_FSM,
//output
output   reg        par_chk_en_FSM,
output   reg        strt_chk_en_FSM,
output   reg        stp_chk_en_FSM, 

output   reg        enable_FSM,
output   reg        data_samp_en_FSM,

output   reg        data_valid_FSM,
output   reg        deser_en_FSM
);
reg data_valid_FSM_com;
reg par_err_reg;
localparam IDLE      = 3'b000;
localparam START_BIT = 3'b001;
localparam deser     = 3'b011;
localparam PARIY_BIT = 3'b010;
localparam STOP_BIT  = 3'b110;

reg [2:0] ns,cs;

always @(posedge CLK_FSM or negedge RST_FSM) begin
		if(!RST_FSM)  begin
                	cs <= IDLE;
            	end
		else
                    cs <= ns;
end 

always @(*) begin
	case (cs) 
        IDLE:begin 
            if (RX_IN == 0) begin
                ns = START_BIT;  
            end
            else begin
                ns = IDLE;
            end
        end
        START_BIT:begin
            if(strt_glitch_FSM  &&(edge_cnt_FSM == (prescale_FSM-1))) begin
                ns = IDLE;
            end
            else if ((edge_cnt_FSM == (prescale_FSM-1))) begin
                 ns = deser;
            end
            else begin
                    ns = START_BIT;
            end
         end
        deser:begin 
            if(strt_glitch_FSM  &&(edge_cnt_FSM == (prescale_FSM-1))) begin
                ns = IDLE;
            end
            else if ((bit_cnt_FSM == 8) && (edge_cnt_FSM == (prescale_FSM-1))) begin
                if (PAR_EN_FSM) begin
                    ns = PARIY_BIT;
                    end
                else begin
                     ns = STOP_BIT;
                    end
            end
            else begin
                ns = deser;
            end

            end

        PARIY_BIT:begin 
                if(edge_cnt_FSM==(prescale_FSM-1))begin
                    ns = STOP_BIT; 
                 end
                else begin
                    ns = PARIY_BIT;
                end
        end
        STOP_BIT:begin 
            if ((edge_cnt_FSM==(prescale_FSM-1) )&& (RX_IN == 0)) begin
                ns =START_BIT;
            end
            else if(edge_cnt_FSM==(prescale_FSM-1)) begin
                    ns =IDLE;
            end
            else begin
                ns =STOP_BIT;
            end

        end
        default : begin ns =IDLE; end
    endcase
end 
always @(*) begin
 par_chk_en_FSM = 1'b0;
 strt_chk_en_FSM = 1'b0;
 stp_chk_en_FSM = 1'b0;
 enable_FSM = 1'b0;
 data_samp_en_FSM = 1'b0;
 deser_en_FSM = 1'b0;
	case (cs) 
        IDLE:begin
            if (RX_IN == 0) begin
                enable_FSM = 1'b1;   
            end
            else begin
                enable_FSM = 1'b0;
            end
        end
        START_BIT:begin
            enable_FSM = 1'b1;
            data_samp_en_FSM =1'b1;
            if ((edge_cnt_FSM == (prescale_FSM-1))) begin
                strt_chk_en_FSM = 1'b1;
            end
            else begin
                strt_chk_en_FSM = 1'b0;
            end
         end
        deser:begin 
            enable_FSM = 1'b1;
            data_samp_en_FSM =1'b1;
                    if ((edge_cnt_FSM == (prescale_FSM-1))) begin
                        deser_en_FSM = 1'b1;   
                     end
                     else begin
                        deser_en_FSM = 1'b0;
                     end

            end

        PARIY_BIT:begin 
            enable_FSM = 1'b1;
            data_samp_en_FSM =1'b1;
                if(edge_cnt_FSM==(prescale_FSM-1))begin 
                    par_chk_en_FSM =1'b1;
                 end
                else begin
                    par_chk_en_FSM =1'b0;
                end
        end
        STOP_BIT:begin 
            data_samp_en_FSM =1'b1;
            if (stp_err_FSM  && (edge_cnt_FSM == (prescale_FSM-1))) begin
                    par_err_reg = par_err_FSM;
            end
            if(edge_cnt_FSM == (prescale_FSM-1)) begin
                    stp_chk_en_FSM =1'b1;
                    enable_FSM = 1'b0;
            end
            else begin
                   enable_FSM = 1'b1;
                   stp_chk_en_FSM =1'b0;
            end

        end
        default : begin 
             par_chk_en_FSM = 1'b0;
             strt_chk_en_FSM = 1'b0;
             stp_chk_en_FSM = 1'b0;
             enable_FSM = 1'b0;
             data_samp_en_FSM = 1'b0;
             deser_en_FSM = 1'b0;
         end
    endcase
end 

always @(posedge CLK_FSM or negedge RST_FSM) begin
		if(!RST_FSM)  begin
                	par_err_reg <= 1'b0;
                    data_valid_FSM <= 0;
            	end
		else
    case (cs) 
        PARIY_BIT:begin 
            if (par_err_FSM  && (edge_cnt_FSM == (prescale_FSM-1))) begin
                    par_err_reg <= par_err_FSM;
            end
        end
        STOP_BIT : begin 
            par_err_reg <= par_err_reg;
                if ((stp_err_FSM  || par_err_reg) && (edge_cnt_FSM == (prescale_FSM-1))) begin
                    data_valid_FSM <= 0;
                 end
                 else if ((stp_err_FSM == 0)  && (edge_cnt_FSM == (prescale_FSM-1))) begin
                    data_valid_FSM <= 1;
                 end
        end
        default : begin 
        par_err_reg <= 0;
        data_valid_FSM <= 0;
         end
    endcase
end
endmodule