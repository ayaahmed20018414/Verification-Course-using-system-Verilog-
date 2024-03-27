// Code your design here
module new_adder(adder_intf.dut intf);
  
  reg [1:0] temp_a,temp_b; 
  reg dummy_cycle;
  
  initial begin
    temp_a = 2'b00;
    temp_b=2'b00;
    dummy_cycle= 1'b0;
    intf.out = 3'b000;
    intf.en_o <=0;
  end
  
  always@(posedge intf.clk or negedge intf.rst) begin
    if(intf.rst == 1'b0) begin
          intf.out <= 3'b000;
    	  intf.en_o <=0;
    end
    else begin
      if (intf.en_i ==1'b1) begin
        
        temp_a <=intf.ina;
        temp_b <=intf.inb;
        dummy_cycle <=1'b1;
      end
      
      if(dummy_cycle ==1'b1) begin
        intf.en_o <= 1;
        intf.out <= temp_a+temp_b;
      end
      
    end
  end
  
  endmodule
