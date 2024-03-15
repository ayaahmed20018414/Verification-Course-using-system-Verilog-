  //monitor output task
  class monitor_output;
  mailbox out_mx;
  mailbox enableo_mx;
  virtual intf_adder.tb intf_tb;
  function new(virtual intf_adder.tb intf_tb);
	this.intf_tb=intf_tb;
  endfunction  
  task run();
    @(posedge intf_tb.clk);
    forever begin
      @(posedge intf_tb.clk);
      out_mx.put(intf_tb.cb.out);
      enableo_mx.put(intf_tb.cb.en_o);
      $display("output will be %0d at time %t",intf_tb.cb.out,$time);
      $display("output enable  will be %0d at time %t",intf_tb.cb.en_o,$time);
    end
  endtask
  endclass
