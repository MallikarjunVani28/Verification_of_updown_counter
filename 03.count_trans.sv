 //transaction classs
    
class count_trans;
  //interface signals
  rand bit[3:0]din;
  rand bit up_down;
  rand bit load;
  rand bit resetn;
  logic [3:0] count;
  
  //constraint
  constraint C1{din inside{[2:10]};}
  constraint C2{load dist{1:=30  , 0:= 70};}
  constraint C3{resetn dist{1:=40 , 0:=60};}
  constraint C4{up_down dist{1:=50 , 0:=50};}
  
  //display method
  virtual function void display(input string s);
    begin
      $display("---------%s---------",s);
      $display("up_down = %0d",up_down);
      $display("load = %0d",load);
      $display("din = %0d",din);
      $display("count = %0d",count);
      $display("resetn = %d",resetn);
    end
  endfunction
endclass
    
