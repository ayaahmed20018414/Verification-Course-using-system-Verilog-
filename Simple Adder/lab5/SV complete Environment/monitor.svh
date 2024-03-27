class monitor;
	//create transaction
	transaction item;
	//create mon2scb mailbox;
	mailbox mon2scb;
	//create mon2cov mailbox
	mailbox mon2cov;
	//create virtual interface 
	virtual adder_intf intf_tb;
	function new(virtual adder_intf intf_tb, mailbox mon2scb, mailbox mon2cov);
		this.intf_tb=intf_tb;
		this.mon2scb=mon2scb;
		this.mon2cov=mon2cov;
	endfunction
	
	//main task of monitor
	task main();
		item=new();
		forever begin
			@(posedge intf_tb.clk);
			item.en_i=intf_tb.en_i;
			item.ina=intf_tb.ina;
			item.inb=intf_tb.inb;
			item.rst=intf_tb.rst;
			@(posedge intf_tb.clk);
			item.out=intf_tb.out;
			item.en_o=intf_tb.en_o;
			@(posedge intf_tb.clk);
			mon2scb.put(item);
			mon2cov.put(item);
			item.print_info("monitor");	
		end

	endtask


endclass
