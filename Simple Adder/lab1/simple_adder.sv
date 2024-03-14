// Code your design here
module new_adder(input wire clk,
                input wire en_i,
                input wire rst,
                 input wire [1:0] ina,
                 input wire [1:0] inb,                 
                output reg en_o,
                 output reg [2:0] out);
  
  reg [1:0] temp_a,temp_b; 
  reg dummy_cycle;
  
  initial begin
    temp_a = 2'b00;
    temp_b=2'b00;
    dummy_cycle= 1'b0;
    out = 3'b000;
    en_o <=0;
  end
  
  always@(posedge clk or negedge rst) begin
    if(rst == 1'b0) begin
          out <= 3'b000;
    	  en_o <=0;
    end
    else begin
      if (en_i ==1'b1) begin
        
        temp_a <=ina;
        temp_b <=inb;
        dummy_cycle <=1'b1;
      end
      
      if(dummy_cycle ==1'b1) begin
        en_o <= 1;
        out <= temp_a+temp_b;
      end
      
    end
  end
  
  endmodule