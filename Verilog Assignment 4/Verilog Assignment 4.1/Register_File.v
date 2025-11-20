module Register_File #(parameter reg_WIDTH = 16) (
    input wire CLK,
    input wire RST,
    input wire WrEn,
    input wire RdEn,
    input wire [reg_WIDTH-1 : 0] WrData,
    input wire [2 : 0]Address,
    output reg [reg_WIDTH-1 : 0] RdData
);
// reg datawidth => name => depth
reg [reg_WIDTH-1 : 0] regfile [7 : 0];

    always @ (posedge CLK or negedge RST) 
	  begin
        if (!RST)
            begin
                regfile[0] <= 'd0;
                regfile[1] <= 'd0;
                regfile[2] <= 'd0;
                regfile[3] <= 'd0;
                regfile[4] <= 'd0;
                regfile[5] <= 'd0;
                regfile[6] <= 'd0;
                regfile[7] <= 'd0;
                RdData <= 'd0;
            end
        else
            begin
                if (WrEn && (!RdEn))
                    regfile[Address] <= WrData;
                else if (RdEn && (!WrEn))
                    RdData <= regfile[Address];
            end

      end
endmodule