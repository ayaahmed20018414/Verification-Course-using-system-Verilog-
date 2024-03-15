  //class driver 
  class driver;
  virtual intf_adder.tb intf_tb;
  logic [0:1] q_inA[$];
  logic [0:1] q_inB[$];
  function new(virtual intf_adder.tb intf_tb);
	this.intf_tb=intf_tb; 
  endfunction 
   task run(int count);
    for(int i=0;i<count;i++) begin
      @(posedge intf_tb.clk);
      intf_tb.cb.ina<=$random;
      intf_tb.cb.inb<=$random;
      //queues 
      q_inA.push_front(intf_tb.cb.ina);
      q_inB.push_front(intf_tb.cb.inb);
    end
  endtask   
  endclass
