`include "env.svh"
module test(adder_intf intf_tb);

env env1;

initial begin
	env1=new(intf_tb);
	repeat (10) begin
		env1.gen.reset();
	end
	repeat (100) begin
		env1.gen.main();
	end
	repeat (10) begin
		env1.gen.reset();
	end
	repeat (50) begin
		env1.gen.main();
	end
	env1.test();
end
endmodule
