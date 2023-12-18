module DisplayCounter (
    input clk,
    input rst,
    input [6:0] counter_value,
    output reg [6:0] seg,
    output reg [2:0] digit_select
);
  reg [3:0] digit_0, digit_1, digit_2;
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      digit_0 <= 4'b0000;
      digit_1 <= 4'b0000;
      digit_2 <= 4'b0000;
    end else begin
      digit_0 <= counter_value % 10;
      digit_1 <= (counter_value / 10) % 10;
      digit_2 <= (counter_value / 100) % 10;
    end
  end
  wire [6:0] seg_0_wire, seg_1_wire, seg_2_wire;
  reg [6:0] seg_0, seg_1, seg_2;

  DigitToSegment digit0 (
      digit_0,
      seg_0_wire
  );
  DigitToSegment digit1 (
      digit_1,
      seg_1_wire
  );
  DigitToSegment digit2 (
      digit_2,
      seg_2_wire
  );

  always @(posedge clk) begin
    seg_0 <= seg_0_wire;
    seg_1 <= seg_1_wire;
    seg_2 <= seg_2_wire;
  end
  reg [16:0] counter;
  reg [ 1:0] counter_select;
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      counter <= 0;
      counter_select <= 0;
    end else if (counter == 10_000) begin
      counter <= 0;
      counter_select <= counter_select + 1;
      if (counter_select == 2) begin
        counter_select <= 0;
      end
    end else begin
      counter <= counter + 1;
    end
  end

  always @(counter_select) begin
    case (counter_select)
      4'b000:  begin
        seg <= seg_0;
        digit_select <= 3'b001;
        end
        4'b001:  begin
        seg <= seg_1;
        digit_select <= 3'b010;
        end
        4'b010:  begin
        seg <= seg_2;
        digit_select <= 3'b100;
        end
        default: begin
        seg <= 7'b0000000;
        digit_select <= 3'b000;
        end
    endcase
  end
endmodule
