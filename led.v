module ledControl(
    input clk,
    input rst,
    input [3:0] current_track,
    input playing,
    output reg [7:0] led_output
);
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      led_output <= 0;
    end else if (playing) begin
      case (current_track)
        4'h0: led_output <= 8'b00000001;
        4'h1: led_output <= 8'b00000010;
        4'h2: led_output <= 8'b00000100;
        4'h3: led_output <= 8'b00001000;
        4'h4: led_output <= 8'b00010000;
        4'h5: led_output <= 8'b00100000;
        4'h6: led_output <= 8'b01000000;
        4'h7: led_output <= 8'b10000000;
        default: led_output <= 0;
      endcase
    end else begin
      led_output <= 0;
    end
  end
endmodule
