interface intf_adder(input clk);
  logic en_i,rst;
  logic [1:0] ina,inb;                
  logic en_o;
  logic [2:0] out;
  clocking cb @(posedge clk);
    default input #0 output #1;
    	inout en_i,ina,inb;
    	input en_o,out;
  endclocking
  modport dut (input en_i,rst,ina,clk,inb,output en_o,out);
  modport tb (clocking cb,output rst,input clk);
  
endinterface
