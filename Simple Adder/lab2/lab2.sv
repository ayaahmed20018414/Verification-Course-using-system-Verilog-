// Code your testbench here
// or browse Examples
class FIFO;
  local int fifo[$];
  
  function void Enqueue(int value);
    fifo.push_front(value);
  endfunction 
  
  function int dequeue();
    int value;
    value=fifo.pop_back();
    return value;
  endfunction
  function void display();
    $display("%p",fifo);
  endfunction 
endclass 

module tb;
  FIFO obj=new();
initial begin
  for(int i=0;i<20;i++) begin
    obj.Enqueue(i*2);
  end
  #5;
  obj.display();
  #10
  for(int i=0;i<10;i++) begin
    obj.dequeue();
  end
  #5
  obj.display();
end
endmodule