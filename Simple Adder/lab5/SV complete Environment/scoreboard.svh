class scoreboard;
	mailbox mon2scb;
	transaction item;
	function new(mailbox mon2scb);
		this.mon2scb=mon2scb;
	endfunction


	//scoreboard main task
	task main();
	logic [2:0] Actual_output, Expected_output;
 	forever begin
		mon2scb.get(item);
		Expected_output=item.ina + item.inb;
		Actual_output=item.out;
		if(item.rst && Actual_output != Expected_output && item.en_o !=1'b1 ) begin
			$error("Actual value not equal Expected value and output must be %0d",Expected_output);	
		end
		else if(item.rst && Actual_output == Expected_output && item.en_o !=1'b1 ) begin
			$error("Actual value not equal Expected value and enable output must be 1");	
		end
		else if(!item.rst && Actual_output != 0 && item.en_o !=0 ) begin
			$error("Actual value not equal Expected value and output must be 0");	
		end
		else if(item.rst && Actual_output ==0 && item.en_o !=1'b1 ) begin
			$error("Actual value not equal Expected value and enable output must be 0");	
		end
		else begin
			$display("Actual value is equal Expected value");	
		end
		item.print_info("scoreboard");		
		
	end
	endtask
endclass
