interface count_if(input bit clock);
  //interface signals
  logic [3:0] din;
  logic [3:0] count;
  logic load;
  logic resetn;
  logic up_down;
  
  //driver clocking block
  clocking dr_cb@(posedge clock);
    default input #1 output #1;
    output din;
    output resetn;
    output up_down;
    output load;
  endclocking
  
  //write monitor clocking block
  clocking wr_mon_cb@(posedge clock);
  default input #1 output #1;
  input din;
  input load;
  input up_down;
input resetn;
  endclocking
  //read monitor clocking block
  clocking rd_mon_cb@(posedge clock);
    default input #1 output #1;
    input count;
  endclocking
  
  //driver
  modport DRV(clocking dr_cb);
  //write monitor
  modport WR_MON(clocking wr_mon_cb);
   //read monitor
  modport RD_MON(clocking rd_mon_cb);
endinterface
