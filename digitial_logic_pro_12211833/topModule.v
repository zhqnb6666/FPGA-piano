/*
we order switch and led from left to right [7:0] for big and small switch separately
*/
module TopModule(
    input clk,  
    input rst,  // Reset all , small switch 4(V5) 
    input [7:0] key_input,    // 8 big switch from P5 to R1
    input higher_8,           // transform to Higher 8 bits of key_input on small switch 7 U3
    input [2:0] mode_input,   // small switch from 2(R3) to 0(T5) stands for mode_input[2]:LEARNING_MODE, mode_input[1]:AUTO_PLAY_MODE, mode_input[0]:FREE_MODE
    input song_select_switch, // small switch 3(V4) if(song_select_switch) then the key_input[7:6] indicates for location of song in the memory cell

    output song_select_led_output,  // small LED 3(K6) stands for song_select_switch
    output rst_led_output,  // small LED 4(J5) stands for rst
    output [2:0] mode_led_output,  // small LED from 2(L1) to 0(K3)

    output reg higher_8_led,      // transform to Higher 8 bits of key_input on small LED 7 K1
    output [7:0] reg led_output,  // 8 big LED from F6 to K2 
    output reg buzzer_output,     // Buzzer output high active
    output [6:0] reg segment_output, // Segment output for the 4 segmemt on the left
    output [1:0] reg digit_select_output //determine whether the first segment and the second segment from left are used
);

wire [3:0] top_0_to_15_note_value;

wire memory_isread;
wire [4:0] memory_location;
wire [1:0] memory_songnum;
wire [3:0] memory_read_data_note_value_output;
wire [25:0] memory_data_duration_value_output;

wire learning_higher_8_led;
wire [4:0]  learning_memory_location;
wire [7:0] learning_led_output,  // 8 big LED from F6 to K2 
wire learning_buzzer_output,     // Buzzer output high active
wire [6:0] learning_segment_output, // Segment output for the 4 segmemt on the left
wire [1:0] learning_digit_select_output, //determine whether the first segment and the second segment from left are used

wire auto_higher_8_led;
wire [4:0] auto_memory_location;
wire [7:0] auto_led_output,  // 8 big LED from F6 to K2 
wire auto_buzzer_output,     // Buzzer output high active
wire [6:0] auto_segment_output, // Segment output for the 4 segmemt on the left
wire [1:0] auto_digit_select_output, //determine whether the first segment and the second segment from left are used

wire free_higher_8_led;
wire [7:0] free_led_output,  // 8 big LED from F6 to K2 
wire free_buzzer_output,     // Buzzer output high active
wire [6:0] free_segment_output, // Segment output for the 4 segmemt on the left
wire [1:0] free_digit_select_output, //determine whether the first segment and the second segment from left are used

assign song_select_led_output=song_select_switch;
assign rst_led_output=rst;
assign mode_led_output=mode_input;
assign top_0_to_15_note_value=higher_8*1'd8+key_input[6]*1'd1+key_input[5]*1'd2+key_input[4]*1'd3+key_input[3]*1'd4+key_input[2]*1'd5+key_input[1]*1'd6+key_input[0]*1'd7;

assign memory_isread=key_input[2]|key_input[1];
assign memory_write_data_input=top_0_to_15_note_value;
assign memory_location={(learning_memory_location[4]&mode_input[2])|(auto_memory_location[4]&mode_input[1]),(learning_memory_location[3]&mode_input[2])|(auto_memory_location[3]&mode_input[1]),(learning_memory_location[2]&mode_input[2])|(auto_memory_location[2]&mode_input[1]),(learning_memory_location[1]&mode_input[2])|(auto_memory_location[1]&mode_input[1]),(learning_memory_location[0]&mode_input[2])|(auto_memory_location[0]&mode_input[1])};
assign memory_songnum={key_input[7]&song_select_switch,key_input[6]&song_select_switch};

always @(posedge clk,posedge rst) begin
    if(rst) begin
        higher_8_led<=0;
        led_output<=0;
        buzzer_output<=0;
        segment_output<=0;
        digit_select_output<=0;
    end else if((mode_input[2])&&(~mode_input[1])&&(~mode_input[0])) begin
        higher_8_led<=learning_higher_8_led;
        led_output<=learning_led_output;
        buzzer_output<=learning_buzzer_output;
        segment_output<=learning_segment_output;
        digit_select_output<=learning_digit_select_output;
    end else if((~mode_input[2])&&(mode_input[1])&&(~mode_input[0])) begin
        higher_8_led<=auto_higher_8_led;
        led_output<=auto_led_output;
        buzzer_output<=auto_buzzer_output;
        segment_output<=auto_segment_output;
        digit_select_output<=auto_digit_select_output;
    end else if((~mode_input[2])&&(~mode_input[1])&&(mode_input[0])) begin
        higher_8_led<=free_higher_8_led;
        led_output<=free_led_output;
        buzzer_output<=free_buzzer_output;
        segment_output<=free_segment_output;
        digit_select_output<=free_digit_select_output;
    end else begin
        higher_8_led<=higher_8_led;
        led_output<=led_output;
        buzzer_output<=buzzer_output;
        segment_output<=segment_output;
        digit_select_output<=digit_select_output;
    end    
end

memory_cell memory_cell_impl(
    .clk(clk),
    .rst(rst),
    .isread(memory_isread),
    .songnum(memory_songnum),//memory depth num
    .location(memory_location),// 5 bit 

    .read_data_note_value_output(memory_read_data_note_value_output)//4 bits for note value(0 to 15) [3:0]
    .read_data_duration_value_output(memory_data_duration_value_output)//26 bits for duration value(0 to 100000000) [25:0]
);

learning_mode learning_mode_impl(
    .clk(clk),
    .rst(rst),
    .note_value(memory_read_data_note_value_output),
    .duration_value(memory_data_duration_value_output),
    .user_input(top_0_to_15_note_value),// 4 bits for note value(0 to 15) [3:0]

    .nxt_learning_memory_location(learning_memory_location),
    .led_output(learning_led_output),
    .buzzer_output(learning_buzzer_output),
    .segment_output(learning_segment_output),
    .digit_select_output(learning_digit_select_output)
    .higher_8_led(learning_higher_8_led)
);

auto_mode auto_mode_impl(
    .clk(clk),
    .rst(rst),
    .note_value(memory_read_data_note_value_output),
    .duration_value(memory_data_duration_value_output),

    .nxt_auto_memory_location(auto_memory_location),
    .led_output(auto_led_output),
    .buzzer_output(auto_buzzer_output),
    .segment_output(auto_segment_output),
    .digit_select_output(auto_digit_select_output)
    .higher_8_led(auto_higher_8_led)
);

free_mode free_mode_impl(
    .clk(clk),
    .rst(rst),
    .user_input(top_0_to_15_note_value),// 4 bits for note value(0 to 15) [3:0]
    .higher_8(higher_8),

    .led_output(free_led_output),
    .buzzer_output(free_buzzer_output),
    .segment_output(free_segment_output),
    .digit_select_output(free_digit_select_output),
    .higher_8_led(free_higher_8_led)
);

endmodule