module display_chars(
    input clk,
    input rst,
    input [3:0] index,  // 4-bit input index to select the word
    output reg [6:0] seg,  // 7-segment output
    output reg [3:0] digit_select  // 4-bit digit select output
);

    // Outputs from chars_lib
    wire [6:0] char0, char1, char2, char3;

    // Instantiate chars_lib
    chars_lib my_chars_lib(
        .index(index),
        .char0(char0),
        .char1(char1),
        .char2(char2),
        .char3(char3)
    );

    reg [16:0] counter;
  reg [1:0]counter_select;
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
        2'b0:  begin
        seg <= char0;
        digit_select <= 4'b0001;
        end
        2'b1:  begin
        seg <= char1;
        digit_select <= 4'b0010;
        end
        2'b10:  begin
        seg <= char2;
        digit_select <= 4'b0100;
        end
        2'b11:  begin
        seg <= char3;
        digit_select <= 4'b1000;
        end
        default: begin
        seg <= 7'b0000000;
        digit_select <= 4'b0000;
        end
    endcase
  end

endmodule
