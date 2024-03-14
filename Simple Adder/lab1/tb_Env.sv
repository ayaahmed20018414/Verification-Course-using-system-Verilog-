// Code your testbench here
// or browse Examples
module simple_adder_directtb_driver();
  //declare inputs as logic
  logic [1:0] i_A,i_B;
  logic clk,reset,enable_i;
  //declare outputs as logic
  logic enable_o;
  logic [2:0] OUT;
  logic [1:0] q_inA[$];
  logic [1:0] q_inB[$];
  logic [2:0] out_q[$];
  //instantiate DUT and connect
  new_adder U0(.clk(clk),
            .en_i(enable_i),
            .rst(reset),
            .ina(i_A),
            .inb(i_B),                 
            .en_o(enable_o),
            .out(OUT));
  
  //create mailbox for inputs
  mailbox inA_mx=new();
  mailbox inB_mx=new();
  mailbox ineni_mx=new();
  
  //create output mailbox 
  mailbox out_mx=new();
  mailbox enableo_mx=new(); 
  
  //task driver 
  task drive(int count);
    enable_i=1'b1;
    for(int i=0;i<count;i++) begin
      @(posedge clk);
      i_A<=$random;
      i_B<=$random;
    end
  endtask
  //monitor input task
  task monitor_input();
    forever begin
      @(posedge clk);
      inA_mx.put(i_A);
      inB_mx.put(i_B);
      ineni_mx.put(enable_i);
      if(reset) begin
        q_inA.push_front(i_A);
        q_inB.push_front(i_B);
      end
      $display("input A will be %0d at time %t",i_A,$time);
      $display("input B will be %0d at time %t",i_B,$time);
      $display("input Enable will be %0d at time %t",enable_i,$time);
    end
    
    
  endtask
  
  //monitor output task
  task monitor_output();
    wait(reset);
    @(posedge clk);
    forever begin
      @(posedge clk);
      out_mx.put(OUT);
      enableo_mx.put(enable_o);
      out_q.push_front(OUT);
      $display("output will be %0d at time %t",OUT,$time);
      $display("output enable  will be %0d at time %t",enable_o,$time);
    end
  endtask
// checker task 
  task check_output();
    bit [1:0] A_temp,B_temp;
    bit [2:0] out_val;
    bit enable_o;
    wait(reset);
    @(posedge clk);
    forever begin
      A_temp<=q_inA.pop_back();
      B_temp<=q_inB.pop_back();
      @(posedge clk);
      out_val=out_q.pop_back();
      if(out_val==A_temp+B_temp) begin
        $display("test case passed for A=%0d and B=%0d and output is %0d at time %t",A_temp,B_temp,out_val,$time);
      end
      else begin
        $error("test case failed for A=%0d and B=%0d and output is %0d at time %t",A_temp,B_temp,out_val,$time);
      end
    end
    
  endtask
  
  initial begin
    fork 
      begin
        drive(80);
      end
      begin
        monitor_input();
      end
      begin
        monitor_output();
      end
      begin
        check_output();
      end
    join
  end
  always #5 clk=~clk;
  initial begin
    clk=1'b0;
    reset=1'b0;
    #25;
    reset=1'b1;
    $dumpfile("adder.vcd");
    $dumpvars(0,simple_adder_directtb_driver);
    repeat(100) @(posedge clk);
    $finish;
    
  end
endmodule
