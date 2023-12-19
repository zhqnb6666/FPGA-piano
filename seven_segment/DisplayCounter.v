module DisplayCounter (
    input clk,
    input rst,
    input [6:0] counter_value,
    output reg [6:0] seg,
    output reg [1:0] digit_select
);
  reg [3:0] digit_0, digit_1;
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      digit_0 <= 4'b0000;
      digit_1 <= 4'b0000;
    end else begin
      digit_0 <= counter_value % 10;
      digit_1 <= (counter_value / 10) % 10;
    end
  end
  wire [6:0] seg_0_wire, seg_1_wire;
  reg [6:0] seg_0, seg_1;

  DigitToSegment digit0 (
      digit_0,
      seg_0_wire
  );
  DigitToSegment digit1 (
      digit_1,
      seg_1_wire
  );

  always @(posedge clk) begin
    seg_0 <= seg_0_wire;
    seg_1 <= seg_1_wire;
  end
  reg [16:0] counter;
  reg counter_select;
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      counter <= 0;
      counter_select <= 0;
    end else if (counter == 10_000) begin
      counter <= 0;
      counter_select <= counter_select + 1;
    end else begin
      counter <= counter + 1;
    end
  end

  always @(counter_select) begin
    case (counter_select)
       1'b0:  begin
        seg <= seg_0;
        digit_select <= 2'b01;
        end
        1'b1:  begin
        seg <= seg_1;
        digit_select <= 2'b10;
        end
        default: begin
        seg <= 7'b0000000;
        digit_select <= 2'b00;
        end
    endcase
  end
endmodule
