module clock_divider (
    input wire  i_ref_clk,
    input wire  i_rst_n,
    input wire  i_clk_en,
    input wire  [7:0] i_div_ratio,
    output wire   o_div_clk   
);

    wire  clk_div_en;
    wire  odd;
    wire [7:0 ] half_toggle;
    wire [7:0] half_toggle_p1; 
    reg  [7:0] counter;
    reg  o_div_clk_reg;
    reg flag;

    assign half_toggle = ((i_div_ratio >> 1 )-1);
    assign half_toggle_p1 = (half_toggle + 1);
    assign odd = i_div_ratio[0];
    assign clk_div_en = ( (i_clk_en) && (i_div_ratio != 'b0) && (i_div_ratio != 'b1));
    
    always @(posedge i_ref_clk or negedge i_rst_n) begin
        if (!i_rst_n) begin
            o_div_clk_reg <= 1'b0;
            counter <= 'b0;
            flag <= 1'b0;
        end 
        else if (clk_div_en)begin
               if (!odd && counter >= half_toggle) begin
                     o_div_clk_reg <= ~o_div_clk_reg;
                    counter <= 'd0;
                end
                else if (odd && (((counter >= half_toggle) && flag ) || ((counter >= half_toggle_p1) && !flag))) begin
                     o_div_clk_reg <= ~o_div_clk_reg;
                    counter <= 'd0;
                    flag <= ~flag;
                 end
                 else begin
                    counter <= counter + 1'b1;
                end
         end
        else begin
            o_div_clk_reg <= 1'b0;
            counter <= 'b0;
            flag <= 1'b0;
        end

    end

    assign o_div_clk = (clk_div_en == 'b1) ? o_div_clk_reg: i_ref_clk;
endmodule