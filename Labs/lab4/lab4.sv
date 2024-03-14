class single_tone;
  local function new();
  endfunction 
  static single_tone obj;
  static function single_tone create(); 
  if(obj==null) begin
    obj= new();
  end
    else begin
      $error("only one object is allowed to be declared");
    end
   return obj;
  endfunction   
  
endclass 

module tb();
  single_tone obj1,obj2;
  initial begin
  obj1= single_tone::create();
  obj2= single_tone::create();
  end

endmodule   
  

