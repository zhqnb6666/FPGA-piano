module ledControl(
    input clk,
    input rst,
    input [3:0] current_track,
    input playing,
    output reg [7:0] led_output,
    output reg higher_8_led
);
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      led_output <= 0;
    end else if (playing) begin
      case (current_track)
        4'h0, 4'h8: begin
          led_output <= 8'b00000001;
          higher_8_led <= (current_track >= 8) ? 1 : 0;
        end
        4'h1, 4'h9: begin
          led_output <= 8'b00000010;
          higher_8_led <= (current_track >= 8) ? 1 : 0;
        end
        4'h2, 4'hA: begin
          led_output <= 8'b00000100;
          higher_8_led <= (current_track >= 8) ? 1 : 0;
        end
        4'h3, 4'hB: begin
          led_output <= 8'b00001000;
          higher_8_led <= (current_track >= 8) ? 1 : 0;
        end
        4'h4, 4'hC: begin
          led_output <= 8'b00010000;
          higher_8_led <= (current_track >= 8) ? 1 : 0;
        end
        4'h5, 4'hD: begin
          led_output <= 8'b00100000;
          higher_8_led <= (current_track >= 8) ? 1 : 0;
        end
        4'h6, 4'hE: begin
          led_output <= 8'b01000000;
          higher_8_led <= (current_track >= 8) ? 1 : 0;
        end
        4'h7, 4'hF: begin
          led_output <= 8'b10000000;
          higher_8_led <= (current_track >= 8) ? 1 : 0;
        end
        default: begin
          led_output <= 0;
          higher_8_led <= 0;
        end
      endcase
    end else begin
      led_output <= 0;
    end
  end
endmodule
