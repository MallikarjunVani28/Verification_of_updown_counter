int number_of_transactions;

module counter(
    input clock,
    input resetn,
    input load,
    input up_down,
    input [3:0] din,
    output reg [3:0] count
);
  always @(posedge clock) begin
    if (!resetn)
      count <= 4'b0000;
    else if (load)
      count <= din;
    else if (!up_down) begin
      if (count > 12)
        count <= 4'd0;
      else
        count <= count + 1'b1;
    end
    else begin
      if (count > 10 || count < 2)
        count <= 4'd0;
      else
        count <= count - 1'b1;
    end
  end
endmodule
