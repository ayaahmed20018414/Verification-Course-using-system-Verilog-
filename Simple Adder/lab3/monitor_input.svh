  //monitor input task
  class monitor_input;
  mailbox inA_mx,inB_mx,ineni_mx;
  virtual intf_adder.tb intf_tb;
  function new(virtual intf_adder.tb intf_tb);
	this.intf_tb=intf_tb;
  endfunction 
  task run();
    forever begin
      @(posedge intf_tb.clk);
      inA_mx.put(intf_tb.cb.ina);
      inB_mx.put(intf_tb.cb.inb);
      ineni_mx.put(intf_tb.cb.en_i);
      $display("input A will be %0d at time %t",intf_tb.cb.ina,$time);
      $display("input B will be %0d at time %t",intf_tb.cb.inb,$time);
      $display("input Enable will be %0d at time %t",intf_tb.cb.en_i,$time);
    end   
  endtask
  endclass
