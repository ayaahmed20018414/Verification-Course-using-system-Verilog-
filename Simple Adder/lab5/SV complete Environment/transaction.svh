class transaction;
	//declare transaction signals 
        rand logic en_i;
        rand logic rst;
        randc logic [1:0] ina;
        randc logic [1:0] inb;                 
        logic en_o;
        logic [2:0] out;

	//constrains definition
	constraint input_enable_val {en_i dist {1:=90 , 0:=10};}


	//print transaction information function
	function void print_info(string name);
		$display("====================================================");
		$display("======================transaction information at %0s==========================",name);
		$display("======================transaction inputs at time %0t==============================",$time);
		$display("en_i=%0d, rst=%0d, ina=%0d, inb=%0d",en_i,rst,ina,inb);
		$display("======================transaction outputs at time %0t==============================",$time);
		$display("en_o=%0d, out=%0d",en_o,out);	
	endfunction


endclass
