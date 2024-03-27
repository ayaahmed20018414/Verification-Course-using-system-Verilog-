interface adder_intf (input bit clk);
	//declare interface signals 
        logic en_i;
        logic rst;
        logic [1:0] ina;
        logic [1:0] inb;                 
        logic en_o;
        logic [2:0] out;
	//clocking block definition 
	clocking cb @(posedge clk);
	default input #0 output #1;
	  input en_o,out;
	  output en_i,ina,inb;
	endclocking 
	//modports for design and testbench definition 
	modport dut(input en_i,ina,inb,rst,clk, output out, en_o);
	modport tb(clocking cb ,input clk,output rst);

endinterface 
