// Code your testbench here
// or browse Examples
`include "interface_file.sv"
import Adder_package::*;
module simple_adder_directtb_driver(intf_adder.tb intf_tb);
  bit flag,flag2;
  //create mailbox for inputs 
  mailbox inA_mx=new();
  mailbox inB_mx=new();
  mailbox ineni_mx=new();
  //queues
  logic [0:1] q_inA_t[$];
  logic [0:1] q_inB_t[$];
  logic [0:1] A_val,B_val;
  //create output mailbox 
  mailbox out_mx=new();
  mailbox enableo_mx=new(); 
  driver driver1=new(intf_tb);
  monitor_input monitor_in1=new(intf_tb);
  monitor_output monitor_out=new(intf_tb);
  check_output checker1=new(intf_tb);
  task assign_queue_val();
	forever begin
	@(posedge intf_tb.clk);
	q_inA_t=driver1.q_inA;
	q_inB_t=driver1.q_inB;
	A_val=q_inA_t.pop_front();
	B_val=q_inB_t.pop_front();
	checker1.A_val=A_val;
	checker1.B_val=B_val;
	checker1.flag=flag;
	checker1.flag2=flag2;
	end
  endtask
  task assign_mailboxes_values;
  monitor_in1.inA_mx=inA_mx;	
  monitor_in1.inB_mx=inB_mx;
  monitor_in1.ineni_mx=ineni_mx;
  monitor_out.out_mx=out_mx;
  monitor_out.enableo_mx=enableo_mx;
  checker1.out_mx=out_mx;
  checker1.enableo_mx=enableo_mx;
  endtask
  initial begin
    fork
    	driver1.run(500);
    	monitor_in1.run();
    	monitor_out.run();
    	checker1.run();
    	assign_queue_val();
    	assign_mailboxes_values();
    join
  end
  initial begin
    intf_tb.rst=1'b0;
    intf_tb.cb.en_i<=1'b0;
    repeat(2) @(posedge intf_tb.clk);
    intf_tb.rst=1'b1;
    @(posedge intf_tb.clk);
    flag=1'b1;
    @(posedge intf_tb.clk);
    intf_tb.cb.en_i<=1'b1;
    @(posedge intf_tb.clk);
    flag2=1'b1;
    repeat(400) @(posedge intf_tb.clk);
    intf_tb.rst=1'b0;
    flag=1'b0;
    repeat(50) @(posedge intf_tb.clk);
    intf_tb.cb.en_i<=1'b0;
    flag2=1'b0;
    $dumpfile("adder.vcd");
    $dumpvars(0,simple_adder_directtb_driver);
    repeat(50) @(posedge intf_tb.clk);	
    $finish;
    
  end
endmodule

