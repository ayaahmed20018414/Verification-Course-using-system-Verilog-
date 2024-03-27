class driver;
	//create transaction
	transaction item;
	//create gen2drv mailbox;
	mailbox gen2drv;
	//create virtual interface 
	virtual adder_intf.tb intf_tb;
	function new(virtual adder_intf.tb intf_tb, mailbox gen2drv);
		this.intf_tb=intf_tb;
		this.gen2drv=gen2drv;
	endfunction
	
	//main task of driver
	task main();
		forever begin
			gen2drv.get(item);
			@(posedge intf_tb.clk);
			intf_tb.cb.en_i<=item.en_i;
			intf_tb.cb.ina<=item.ina;
			intf_tb.cb.inb<=item.inb;
			intf_tb.rst<=item.rst;
			@(posedge intf_tb.clk);
			item.out=intf_tb.cb.out;
			item.en_o=intf_tb.cb.en_o;
			@(posedge intf_tb.clk);
			item.print_info("driver");
		end
	endtask 

endclass
