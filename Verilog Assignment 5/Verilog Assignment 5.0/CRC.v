module CRC #(parameter SEED ='hD8)(
    input  wire  CLK,
    input  wire  RST,
    input  wire  ACTIVE,
    input  wire  DATA,
    output reg   CRC,
    output reg   Valid
);

reg [7 : 0] LFSR;
reg [4:0] bit_count;
reg [4:0] crc_count;     
wire Feedback ;

assign Feedback = LFSR[0] ^ DATA;

always @ (posedge CLK or negedge RST) begin
   if (! RST) 
    begin
           LFSR <=  SEED;
           bit_count <= 0;
           crc_count <= 0;
           Valid <= 1'b0;
           CRC <= 1'b0;
    end 
    else if (ACTIVE)
        begin
                LFSR [7] <= Feedback;
                LFSR [6] <= Feedback ^ LFSR [7];
                LFSR [5] <= LFSR [6];
                LFSR [4] <= LFSR [5];
                LFSR [3] <= LFSR [4];
                LFSR [2] <= Feedback ^ LFSR [3];
                LFSR [1] <= LFSR [2];
                LFSR [0] <= LFSR [1];
        end
    else 
        begin
             if (crc_count < 8) begin
                Valid <= 1'b1;
                {LFSR[6:0],CRC} <= LFSR;
                crc_count <= crc_count + 1'b1;
             end
             else
                Valid <= 1'b0;

        end 
end
endmodule