module DATA_SYNC #(
    parameter NUM_STAGE = 2, 
    parameter BUS_WIDTH = 8
)(
    input wire clk,
    input wire rst_n,
    input wire [BUS_WIDTH-1:0] unsync_bus,
    input wire bus_enable,
    output reg [BUS_WIDTH-1:0] sync_bus,
    output reg enable_pulse
);


reg [NUM_STAGE-1:0] sync_reg;
reg enable_pulse_gen_reg;
wire enable_pulse_reg;
wire enable_pulse_gen;


always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        sync_reg <= 0;
    end else begin
        sync_reg <= {sync_reg[NUM_STAGE-2:0], bus_enable};
    end
end 

assign enable_pulse_reg = sync_reg[NUM_STAGE-1];

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        enable_pulse_gen_reg <= 0;
    end else begin
        enable_pulse_gen_reg <= enable_pulse_reg;
    end
end


assign enable_pulse_gen = enable_pulse_reg & ~enable_pulse_gen_reg;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        enable_pulse <= 0;
    end else begin
        enable_pulse <= enable_pulse_gen;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        sync_bus <= 0;
    end else begin
        if (enable_pulse_gen) begin
            sync_bus <= unsync_bus;
        end
    end
end 
endmodule
