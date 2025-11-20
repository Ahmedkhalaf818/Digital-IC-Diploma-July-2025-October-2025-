module SERIALIZER #(parameter DATA_LENGTH=8)(
input [DATA_LENGTH-1:0]P_DATA,
input ser_en,
input CLK,
input RST,
input Data_Valid,
input busy,
output wire ser_done,
output wire ser_data
);
localparam COUNTER_WIDTH = $clog2(DATA_LENGTH);
reg [COUNTER_WIDTH:0]counter;
reg [DATA_LENGTH-1:0] data;

  always @ (posedge CLK or negedge RST)
 begin
  if(!RST)
   begin
    data <= 8'b1111_1111 ; // idle operation
   end
  else if(Data_Valid && !busy)
   begin
    data <= P_DATA ;
   end	
  else if(ser_en)
   begin
    data <= data >> 1 ;        
   end
 end
always @ (posedge CLK or negedge RST)
 begin
  if(!RST)
   begin
    counter <= 'b0;
   end
  else
   begin
    if (ser_en)
	 begin
      counter <= counter + 'b1 ;		 
	 end
	else 
	 begin
      counter <= 'b0 ;		 
	 end	
   end
 end

assign ser_done = (counter == 4'b1000) ? 1'b1 : 1'b0 ;
assign ser_data = data[0] ;

endmodule
