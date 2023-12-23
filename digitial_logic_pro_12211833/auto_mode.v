module auto_mode(
    input clk,
    input rst,
    input [3:0] note_value,
    input [25:0] duration_value,
    input comfirm_button,

    output [4:0] nxt_auto_memory_location,
    output [7:0] led_output,  // 8 big LED from F6 to K2 
    output buzzer_output,     // Buzzer output high active
    output [6:0] segment_output, // Segment output for the 4 segmemt on the left
    output [1:0] digit_select_output, //determine whether the first segment and the second segment from left are used
    output higher_8_led
);

wire auto_key_on;// is buzzer work
wire [3:0] auto_key;// note value 

auto_part_1 auto_part_1_impl(
    .clk(clk),
    .rst(rst),
    .note_value(note_value),
    .duration_value(duration_value),
    .comfirm_button(comfirm_button),

    .key_on(auto_key_on),// is buzzer work
    .key(auto_key),// note value
    .nxt_auto_memory_location(nxt_auto_memory_location)
);

DisplayCounter auto_displayCounterModule(
    .clk(clk),
    .rst(rst),
    .counter_value(auto_key),

    .seg(segment_output),
    .digit_select(digit_select_output)
); 

ledControl auto_ledModule(
    .clk(clk),
    .rst(rst),
    .current_track(auto_key),
    .playing(auto_key_on),

    .led_output(led_output),
    .higher_8_led(higher_8_led)
);

buzzer auto_buzzerModule(
    .clk(clk),
    .rst(rst),
    .key_on(auto_key_on), 
    .key(auto_key),       

    .buzzer(buzzer_output)
);
endmodule