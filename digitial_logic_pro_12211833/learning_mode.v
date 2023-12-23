module learning_mode(
    input clk,
    input rst,
    input [3:0] note_value,
    input [25:0] duration_value,
    input [3:0] user_input,// 4 bits for note value(0 to 15) [3:0]
    input comfirm_button,

    output [4:0] nxt_learning_memory_location,
    output [7:0] led_output,  // 8 big LED from F6 to K2 
    output buzzer_output,     // Buzzer output high active
    output [6:0] segment_output, // Segment output for the 4 segmemt on the left
    output [1:0] digit_select_output, //determine whether the first segment and the second segment from left are used
    output higher_8_led
);

wire [4:0] learning_score;
wire learning_key_on;// is buzzer work
wire [3:0] learning_key;// note value 

learning_part_1 learning_part_1_impl(
    .clk(clk),
    .rst(rst),
    .note_value(note_value),
    .duration_value(duration_value),
    .user_input(user_input),// 4 bits for note value(0 to 15) [3:0]
    .comfirm_button(comfirm_button),

    .score(learning_score),
    .key_on(learning_key_on),// is buzzer work
    .key(learning_key),// note value
    .nxt_learning_memory_location(nxt_learning_memory_location)
);

DisplayCounter learning_displayCounterModule(
    .clk(clk),
    .rst(rst),
    .counter_value(learning_score),

    .seg(segment_output),
    .digit_select(digit_select_output)
); 

ledControl learning_ledModule(
    .clk(clk),
    .rst(rst),
    .current_track(learning_key),
    .playing(learning_key_on),

    .led_output(led_output),
    .higher_8_led(higher_8_led)
);

buzzer learning_buzzerModule(
    .clk(clk),
    .rst(rst),
    .key_on(learning_key_on), 
    .key(learning_key),       

    .buzzer(buzzer_output)
);
endmodule