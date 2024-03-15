// Code your design here
module new_adder(intf_adder.dut intf_add);
  
  reg [1:0] temp_a,temp_b; 
  reg dummy_cycle;
  
  initial begin
    temp_a = 2'b00;
    temp_b=2'b00;
    dummy_cycle= 1'b0;
    intf_add.out = 3'b000;
    intf_add.en_o <=0;
  end
  
  always@(posedge intf_add.clk or negedge intf_add.rst) begin
    if(intf_add.rst == 1'b0) begin
          intf_add.out <= 3'b000;
    	  intf_add.en_o <=0;
    end
    else begin
      if ( intf_add.en_i ==1'b1) begin
        temp_a <= intf_add.ina;
        temp_b <= intf_add.inb;
        dummy_cycle <=1'b1;
      end
      
      if(dummy_cycle ==1'b1) begin
        intf_add.en_o <= 1;
        intf_add.out <= temp_a+temp_b;
      end
      
    end
  end
  
  endmodule

module top();
bit clk;
always #5 clk=~clk;
intf_adder intf1(clk);
new_adder U0 (intf1.dut);
simple_adder_directtb_driver U1(intf1.tb);

endmodule
