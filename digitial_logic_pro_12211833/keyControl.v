module keyControl (
    input clk,
    input [7:0] key,
    input higher_8,

    output reg [3:0] key_out
);
  always @(posedge clk) begin
      if (~higher_8) begin
        case (key)
        8'h01:   key_out <= 0;
        8'h02:   key_out <= 1;
        8'h04:   key_out <= 2;
        8'h08:   key_out <= 3;
        8'h10:   key_out <= 4;
        8'h20:   key_out <= 5;
        8'h40:   key_out <= 6;
        8'h80:   key_out <= 7;
        default: key_out <= 0;
      endcase
      end else begin
        case (key)
        8'h01:   key_out <= 8;
        8'h02:   key_out <= 9;
        8'h04:   key_out <= 10;
        8'h08:   key_out <= 11;
        8'h10:   key_out <= 12;
        8'h20:   key_out <= 13;
        8'h40:   key_out <= 14;
        8'h80:   key_out <= 15;      
        default: key_out <= 0;
      endcase
      end
  end
endmodule