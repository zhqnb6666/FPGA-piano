module free_mode(
    input clk,
    input rst,
    input [3:0] user_input,// 4 bits for note value(0 to 15) [3:0]
    input higher_8,

    output [7:0] led_output,  // 8 big LED from F6 to K2 
    output buzzer_output,     // Buzzer output high active
    output [6:0] segment_output, // Segment output for the 4 segmemt on the left
    output [1:0] digit_select_output, //determine whether the first segment and the second segment from left are used
    output higher_8_led
);

wire free_key_on;
assign free_key_on=1'b1;
wire [3:0] free_key;
wire useless_higher_8_led;
assign free_key=user_input; 
assign higher_8_led=higher_8;

DisplayCounter free_displayCounterModule(
    .clk(clk),
    .rst(rst),
    .counter_value(free_key),

    .seg(segment_output),
    .digit_select(digit_select_output)
); 

ledControl free_ledModule(
    .clk(clk),
    .rst(rst),
    .current_track(free_key),
    .playing(free_key_on),

    .led_output(led_output),
    .higher_8_led(useless_higher_8_led)
);

buzzer free_buzzerModule(
    .clk(clk),
    .rst(rst),
    .key_on(free_key_on), 
    .key(free_key),       

    .buzzer(buzzer_output)
);
endmodule