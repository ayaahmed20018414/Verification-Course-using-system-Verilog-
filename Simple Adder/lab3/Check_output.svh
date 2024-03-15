// checker task 
  class check_output;
  mailbox out_mx,enableo_mx;
  bit flag,flag2;
  bit [0:1] A_val,B_val; 
  virtual intf_adder.tb intf_tb;
  function new(virtual intf_adder.tb intf_tb);
	this.intf_tb=intf_tb;  
  endfunction 
  task run();
    bit [2:0] out_val;
    bit enable_val;
    @(posedge intf_tb.clk);
    forever begin
      @(posedge intf_tb.clk);
      out_mx.get(out_val);
      enableo_mx.get(enable_val);
      if(!intf_tb.rst && out_val=='b0 && enable_val==1'b0)begin
        $display("test case passed for A=%0d, B=%0d, output is %0d and enable output is %0d at time %t",A_val,B_val,out_val,enable_val,$time);
	end
      else if(intf_tb.rst && out_val=='b0 && enable_val==1'b0 && !flag)begin
        $display("test case passed for A=%0d, B=%0d, output is %0d and enable output is %0d at time %t",A_val,B_val,out_val,enable_val,$time);
	end
      else if(intf_tb.rst && out_val=='b0 && flag==1'b1 && enable_val==1'b0 && !intf_tb.cb.en_i) begin
        $display("test case passed for A=%0d, B=%0d, output is %0d and enable output is %0d at time %t",A_val,B_val,out_val,enable_val,$time);
	end
      else if(intf_tb.rst && out_val=='b0 && flag==1'b1 && enable_val==1'b0 && intf_tb.cb.en_i && !flag2) begin
        $display("test case passed for A=%0d, B=%0d, output is %0d and enable output is %0d at time %t",A_val,B_val,out_val,enable_val,$time);
	end
      else if(intf_tb.rst && out_val==A_val+B_val && flag==1'b1 && enable_val==1'b1 && intf_tb.cb.en_i && flag2) begin
        $display("test case passed for A=%0d, B=%0d, output is %0d and enable output is %0d at time %t",A_val,B_val,out_val,enable_val,$time);
	end
	else begin
        $error("test failed passed for A=%0d, B=%0d, output is %0d and enable output is %0d at time %t",A_val,B_val,out_val,enable_val,$time);
	end
    end
    
  endtask
  endclass
