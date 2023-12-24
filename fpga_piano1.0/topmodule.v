module TopModule (
    input clk,
    input rst,
    input [7:0] key_input,
    input higher_8,
    input key_on,
    input mode_switch_button,
    input continue_button,
    input back_button,
    output reg [7:0] led_output,
    output reg higher_8_led,
    output reg buzzer_output,
    output reg [6:0] segment_output,
    output reg [1:0] digit_select_output
);

  // State definitions for the FSM
  parameter FREE_MODE = 2'b00, AUTO_MODE = 2'b01, LEARNING_MODE = 2'b10;
  reg [1:0] current_state, next_state;

  // Debounced mode switch
  wire mode_switch;
  Debouncer mode_switch_debouncer (
      .clk(clk),
      .reset(rst),
      .button_in(mode_switch_button),
      .button_out(mode_switch)
  );

  // FSM for controlling modes
  always @(posedge clk or posedge rst) begin
    if (rst) current_state <= FREE_MODE;
    else current_state <= next_state;
  end

  // FSM next state logic
  always @(*) begin
    case (current_state)
      FREE_MODE:     next_state = mode_switch ? AUTO_MODE : FREE_MODE;
      AUTO_MODE:     next_state = mode_switch ? LEARNING_MODE : AUTO_MODE;
      LEARNING_MODE: next_state = mode_switch ? FREE_MODE : LEARNING_MODE;
      default:       next_state = FREE_MODE;
    endcase
  end

  // Module outputs
  wire [7:0] led_output_auto, led_output_free, led_output_learn;
  wire higher_8_led_auto, higher_8_led_free, higher_8_led_learn;
  wire buzzer_output_auto, buzzer_output_free, buzzer_output_learn;
  wire [6:0] segment_output_auto, segment_output_free, segment_output_learn;
  wire [1:0] digit_select_output_auto, digit_select_output_free, digit_select_output_learn;

  // Instantiate the mode-specific top modules
  Autoplay_Top autoplay_top_inst (
      .clk(clk),
      .rst(rst),
      .key_input(key_input),
      .higher_8(higher_8),
      .key_on(key_on),
      .continue_button(continue_button),
      .back_button(back_button),
      .led_output(led_output_auto),
      .higher_8_led(higher_8_led_auto),
      .buzzer_output(buzzer_output_auto),
      .segment_output(segment_output_auto),
      .digit_select_output(digit_select_output_auto)
  );
  Learning_Top learning_top_inst (
      .clk(clk),
      .rst(rst),
      .key_input(key_input),
      .higher_8(higher_8),
      .key_on(key_on),
      .continue_button(continue_button),
      .back_button(back_button),
      .led_output(led_output_learn),
      .higher_8_led(higher_8_led_learn),
      .buzzer_output(buzzer_output_learn),
      .segment_output(segment_output_learn),
      .digit_select_output(digit_select_output_learn)
  );
  Free_Top free_top_inst (
      .clk(clk),
      .rst(rst),
      .key_input(key_input),
      .higher_8(higher_8),
      .key_on(key_on),
      .led_output(led_output_free),
      .higher_8_led(higher_8_led_free),
      .buzzer_output(buzzer_output_free),
      .segment_output(segment_output_free),
      .digit_select_output(digit_select_output_free)
  );





  // Output logic based on the current state
  always @(*) begin
    case (current_state)
      FREE_MODE: begin
        led_output = led_output_free;
        higher_8_led = higher_8_led_free;
        buzzer_output = buzzer_output_free;
        segment_output = segment_output_free;
        digit_select_output = digit_select_output_free;
      end
      AUTO_MODE: begin
        led_output = led_output_auto;
        higher_8_led = higher_8_led_auto;
        buzzer_output = buzzer_output_auto;
        segment_output = segment_output_auto;
        digit_select_output = digit_select_output_auto;
      end
      LEARNING_MODE: begin
        led_output = led_output_learn;
        higher_8_led = higher_8_led_learn;
        buzzer_output = buzzer_output_learn;
        segment_output = segment_output_learn;
        digit_select_output = digit_select_output_learn;
      end
    endcase
  end

endmodule
