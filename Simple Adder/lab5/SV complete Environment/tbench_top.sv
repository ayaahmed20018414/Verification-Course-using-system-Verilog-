`include "test.sv"
`include "interface.sv"
module tbench_top();
	//clock definition 
	bit clk;
	//clock generation
	always #5 clk=~clk;
	//interface creation
	adder_intf intf(clk);	
	//design instantiation 
	new_adder U0 (intf.dut);
	
	//test instantiation
	test U1 (intf.tb);

initial begin
	repeat (400) @(posedge intf.clk);
	$display("cycles of testbench finished @%0t",$time);
	$finish();
end
endmodule
