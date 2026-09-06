   
    //reference model
class count_model;
  count_trans w_data,a;
  static logic[3:0] ref_count = 0;
  
  mailbox #(count_trans) wrmon2rm;
  mailbox #(count_trans) rm2sb;
  
  function new( mailbox #(count_trans) wrmon2rm,
               mailbox #(count_trans) rm2sb);
    this.wrmon2rm = wrmon2rm;
    this.rm2sb= rm2sb;
  endfunction
  
  virtual function void count_mod(count_trans model_counter);
    begin
      if(model_counter.load)
        ref_count = model_counter.din;
      if(model_counter.load == 0)
        begin
          if(model_counter.up_down == 0)
            begin
              if(ref_count >12)
                ref_count = 4'd0;
              else
                ref_count = ref_count + 1'b1;
            end
          else if(model_counter.up_down == 1)
            begin
              if(ref_count>10 || ref_count <2)
                ref_count = 4'd0;
              else
                ref_count = ref_count - 1'b1;
            end
        end
    end
  endfunction
  
  virtual task start();
    fork 
      begin
        forever
          begin
            wrmon2rm.get(w_data);
            count_mod(w_data);
            w_data.count = ref_count;
            a = new w_data;
            rm2sb.put(a);
          end
      end
    join_none
  endtask
endclass
