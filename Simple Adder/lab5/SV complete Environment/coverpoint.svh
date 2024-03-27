class coverpoints;
	mailbox mon2cov;
	transaction item;
	virtual adder_intf intf_tb;
	
	function new(virtual adder_intf intf_tb,mailbox mon2cov);
		cov=new();
		this.intf_tb=intf_tb;
		this.mon2cov=mon2cov;
	endfunction

	covergroup cov;
	coverpoint item.ina;	
	coverpoint item.inb;
	cross item.ina,item.inb;
	endgroup

	task sample_task();
	forever begin
		mon2cov.get(item);
		@(posedge intf_tb.clk) cov.sample();
	end
	endtask
	
endclass
