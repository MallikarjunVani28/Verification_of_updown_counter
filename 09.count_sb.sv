//scoreboard class
class count_sb;
  count_trans rm_data;
  count_trans sb_data;
  count_trans cov_data;
  
  event DONE;
  static int ref_data,rm_data1,data_verified;
  
  covergroup counter_coverage;
    option.per_instance = 1;
    RESET : coverpoint cov_data.resetn{
      bins ZERO = {0};
      bins ONE = {1};
    }
    DATA : coverpoint cov_data.din {
      bins LOW1 = {[0:7]};
      bins LOW2 = {[8:15]};
    }
    
    LOAD : coverpoint cov_data.load{
      bins ZERO = {0};
      bins ONE = {1};
    }
    
    UP_DOWN : coverpoint cov_data.load{
      bins ZERO = {0};
      bins ONE = {1};
    }
    
  endgroup : counter_coverage
  
  mailbox #(count_trans) ref2sb;
  mailbox #(count_trans) rdm2sb;
  
  function new( mailbox #(count_trans) ref2sb,
               mailbox #(count_trans) rdm2sb);
    this.ref2sb = ref2sb;
    this.rdm2sb = rdm2sb;
    counter_coverage = new ;
  endfunction
  
  virtual task start();
    fork
      forever begin
        ref2sb.get(rm_data);
        rm_data.display("from ref module");
        ref_data++;
        rdm2sb.get(sb_data);
        sb_data.display("from read monitor");
        rm_data1++;
        check(sb_data);
      end
    join_none
  endtask
  
  virtual task check(count_trans rdata);
    begin
      if(rm_data.count == rdata.count)
        $display("count matches");
      else
        $display("count not matching");
    end
    
    cov_data = new rm_data;
    counter_coverage.sample();
    data_verified++;
    if(data_verified >= number_of_transactions)
      begin
        ->DONE;
      end
  endtask
  
  virtual function void report();
    $display("scored board report");
    $display("data_generated from ref model %d",ref_data);
    $display("data generated from read monitor %d",rm_data1);
    $display("data verified %d",data_verified);
    $display("functional coverage = %.2f",$get_coverage);
  endfunction
endclass
