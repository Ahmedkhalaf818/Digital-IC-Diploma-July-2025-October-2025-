module Up_Dn_Counter(
input wire [4:0] IN,
input wire CLK,
input wire Load,
input wire  Up,
input wire  Down,
output reg [4:0] Counter,
output wire  High,
output wire  Low
);
always @(posedge CLK) 
begin
	if (Load)
		begin
			Counter <= IN;
		end
	else if (Down && ( !Low )  ) 
		begin
			Counter <= Counter - 5'b00001;
		end
	else if (Up && ( !High ) && (! Down)) 
		begin
			Counter <= Counter + 5'b00001;
		end
end
assign High = ( Counter == 5'd31 );
assign Low  = ( Counter == 5'd0 );
endmodule
