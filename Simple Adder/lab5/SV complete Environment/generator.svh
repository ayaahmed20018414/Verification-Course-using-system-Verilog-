class generator;
	int repeat_cnt_rst;
	int repeat_cnt_main;
	//mailbox creation
	mailbox gen2drv;
	//transaction creation
	transaction item;
	//constructor definition
	function new (mailbox gen2drv);
		this.gen2drv=gen2drv;
	endfunction
	//reset task 
	task reset();
			item=new();
			if(!(item.randomize() with {rst==0;})) begin
				$fatal("randomization for reset signal = 0 can't be done");
			end
			else begin
				gen2drv.put(item);
			end
			item.print_info("generator");	
	endtask
	
	//main task function
	task main();
		item=new();
			if(!(item.randomize() with {rst==1;})) begin
				$fatal("randomization for reset signal = 1 can't be done");
			end
			else begin
				gen2drv.put(item);
			end	

	endtask 

endclass
