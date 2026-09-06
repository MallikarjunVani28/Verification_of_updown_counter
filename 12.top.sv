 module top();

//import count_pkg::*;

reg clock;

count_if DUV_IF(clock);

test t_h;
test_extnd t1_h;

counter DUV (
    .clock   (clock),
    .din     (DUV_IF.din),
    .load    (DUV_IF.load),
    .up_down (DUV_IF.up_down),
    .resetn  (DUV_IF.resetn),
    .count   (DUV_IF.count)
);

initial begin
    clock = 1'b0;
    forever
        #10 clock = ~clock;
end

initial begin

    if($test$plusargs("TEST1"))
    begin
        t_h = new(DUV_IF, DUV_IF, DUV_IF);
        number_of_transactions = 50;
        t_h.build();
        t_h.run();
        $finish;
     end

    if($test$plusargs("TEST2"))
    begin
        t1_h = new(DUV_IF, DUV_IF, DUV_IF);
        number_of_transactions = 10;

        t1_h.build();
        t1_h.run();

        $finish;
    end
end
endmodule
    
