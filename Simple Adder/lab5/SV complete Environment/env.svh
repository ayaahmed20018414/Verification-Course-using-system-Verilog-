import adder_pkg::*;
class env;
	//virtual interface 
	virtual adder_intf.tb intf_tb;
	//create mailboxes 
	mailbox gen2drv;
	mailbox mon2scb;
	mailbox mon2cov;
	//create instances from components
	generator gen;
	driver drv;
	monitor mon;
	scoreboard scb;
	coverpoints cov1;
	//create transaction
	transaction item;

	function new(virtual adder_intf intf_tb);
		this.intf_tb=intf_tb;

		gen2drv=new();
		mon2scb=new();
		mon2cov=new();
		drv=new(intf_tb,gen2drv);
		gen=new(gen2drv);
		mon=new(intf_tb,mon2scb,mon2cov);
		scb=new(mon2scb);
		cov1=new(intf_tb,mon2cov);
			
	endfunction
	
	task test;
	fork	
		drv.main();
		mon.main();
		scb.main();
		cov1.sample_task();
	join
	
	endtask


endclass
