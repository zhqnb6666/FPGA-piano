
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
    input comfirm_button,     //U2

    output song_select_led_output,  // small LED 3(K6) stands for song_select_switch
    output rst_led_output,  // small LED 4(J5) stands for rst
    output [2:0] mode_led_output,  // small LED from 2(L1) to 0(K3)

    output reg higher_8_led,      // transform to Higher 8 bits of key_input on small LED 7 K1
    output reg [7:0] led_output,  // 8 big LED from F6 to K2 
    output reg buzzer_output,     // Buzzer output high active
    output reg [6:0] segment_output, // Segment output for the 4 segmemt on the left
    output reg [1:0] digit_select_output //determine whether the first segment and the second segment from left are used
);

parameter LEARNING_MODE = 3'b100;
parameter AUTO_PLAY_MODE = 3'b010; 
parameter FREE_MODE = 3'b001;

wire [3:0] top_0_to_15_note_value;

wire memory_isread;
reg [1:0] memory_songnum;


wire learning_higher_8_led;
wire [7:0] learning_led_output;  // 8 big LED from F6 to K2 
wire learning_buzzer_output;     // Buzzer output high active
wire [6:0] learning_segment_output; // Segment output for the 4 segmemt on the left
wire [1:0] learning_digit_select_output; //determine whether the first segment and the second segment from left are used
wire [4:0]  learning_memory_location;
wire [3:0] learning_memory_read_data_note_value_output;
wire [25:0] learning_memory_data_duration_value_output;
wire learning_isvalid;


reg [3:0] learning_last_memory_read_data_note_value_output;
reg [25:0] learning_last_memory_data_duration_value_output;
reg learning_last_isvalid;
reg [4:0] learning_last_memory_location;

wire auto_higher_8_led;
wire [7:0] auto_led_output;  // 8 big LED from F6 to K2 
wire auto_buzzer_output;     // Buzzer output high active
wire [6:0] auto_segment_output; // Segment output for the 4 segmemt on the left
wire [1:0] auto_digit_select_output; //determine whether the first segment and the second segment from left are used
wire [4:0] auto_memory_location;
wire [3:0] auto_memory_read_data_note_value_output;
wire [25:0] auto_memory_data_duration_value_output;
wire auto_isvalid;

reg [3:0] auto_last_memory_read_data_note_value_output;
reg [25:0] auto_last_memory_data_duration_value_output;
reg auto_last_isvalid;
reg [4:0] auto_last_memory_location;

wire free_higher_8_led;
wire [7:0] free_led_output;  // 8 big LED from F6 to K2 
wire free_buzzer_output;     // Buzzer output high active
wire [6:0] free_segment_output; // Segment output for the 4 segmemt on the left
wire [1:0] free_digit_select_output; //determine whether the first segment and the second segment from left are used

assign song_select_led_output=song_select_switch;
assign rst_led_output=rst;
assign mode_led_output=mode_input;

assign memory_isread=(mode_input[2]|mode_input[1]);

always @(posedge clk,posedge rst) begin
    if(rst) begin
        higher_8_led<=0;
        led_output<=0;
        buzzer_output<=0;
        segment_output<=0;
        digit_select_output<=0;
        memory_songnum<=0;
        auto_last_isvalid<=0;
        auto_last_memory_read_data_note_value_output<=0;
        auto_last_memory_data_duration_value_output<=0;
        auto_last_memory_location<=0;
        learning_last_isvalid<=0;
        learning_last_memory_data_duration_value_output<=0;
        learning_last_memory_read_data_note_value_output<=0;
        learning_last_memory_location<=0;
    end else begin
        if(comfirm_button) begin
        auto_last_isvalid<=0;
        auto_last_memory_read_data_note_value_output<=0;
        auto_last_memory_data_duration_value_output<=0;
        auto_last_memory_location<=0;
        learning_last_isvalid<=0;
        learning_last_memory_data_duration_value_output<=0;
        learning_last_memory_read_data_note_value_output<=0;
        learning_last_memory_location<=0;
        end else begin
        auto_last_isvalid<=auto_isvalid;
        auto_last_memory_read_data_note_value_output<=auto_memory_read_data_note_value_output;
        auto_last_memory_data_duration_value_output<=auto_memory_data_duration_value_output;
        auto_last_memory_location<=auto_memory_location;
        learning_last_isvalid<=learning_isvalid;
        learning_last_memory_data_duration_value_output<=learning_memory_data_duration_value_output;
        learning_last_memory_read_data_note_value_output<=learning_memory_read_data_note_value_output;
        learning_last_memory_location<=learning_memory_location;
        end

        if(song_select_switch)
        begin
            memory_songnum[1]<=(key_input[7]&song_select_switch);
            memory_songnum[0]<=(key_input[6]&song_select_switch);
        end else begin
            memory_songnum<=memory_songnum;
        end

        if(mode_input==LEARNING_MODE) begin
        higher_8_led<=learning_higher_8_led;
        led_output<=learning_led_output;
        buzzer_output<=learning_buzzer_output;
        segment_output<=learning_segment_output;
        digit_select_output<=learning_digit_select_output;
        end else if(mode_input==AUTO_PLAY_MODE) begin
        higher_8_led<=auto_higher_8_led;
        led_output<=auto_led_output;
        buzzer_output<=auto_buzzer_output;
        segment_output<=auto_segment_output;
        digit_select_output<=auto_digit_select_output;
        end else if(mode_input==FREE_MODE) begin
        higher_8_led<=free_higher_8_led;
        led_output<=free_led_output;
        buzzer_output<=free_buzzer_output;
        segment_output<=free_segment_output;
        digit_select_output<=free_digit_select_output;
        end else begin
        higher_8_led<=0;
        led_output<=0;
        buzzer_output<=0;
        segment_output<=0;
        digit_select_output<=0;
        end 
    end   
end

keyControl keyControl_impl(
    .clk(clk),
    .key(key_input),
    .higher_8(higher_8),
    .key_out(top_0_to_15_note_value)
);


learning_mode learning_mode_impl(
    .clk(clk),
    .rst(rst),
    .note_value(learning_last_memory_read_data_note_value_output),
    .duration_value(learning_last_memory_data_duration_value_output),
    .user_input(top_0_to_15_note_value),// 4 bits for note value(0 to 15) [3:0]
    .comfirm_button(comfirm_button),
    .isvalid(learning_last_isvalid),
    

    .nxt_learning_memory_location(learning_memory_location),
    .led_output(learning_led_output),
    .buzzer_output(learning_buzzer_output),
    .segment_output(learning_segment_output),
    .digit_select_output(learning_digit_select_output),
    .higher_8_led(learning_higher_8_led)
);

auto_mode auto_mode_impl(
    .clk(clk),
    .rst(rst),
    .note_value(auto_last_memory_read_data_note_value_output),
    .duration_value(auto_last_memory_data_duration_value_output),
    .comfirm_button(comfirm_button),
    .isvalid(auto_last_isvalid),

    .nxt_auto_memory_location(auto_memory_location),
    .led_output(auto_led_output),
    .buzzer_output(auto_buzzer_output),
    .segment_output(auto_segment_output),
    .digit_select_output(auto_digit_select_output),
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

memory_cell learning_memory_cell_impl(
    .clk(clk),
    .rst(rst),
    .isread(memory_isread),
    .songnum(memory_songnum),//memory depth num
    .location(learning_last_memory_location),// 5 bit 
    

    .read_data_note_value_output(learning_memory_read_data_note_value_output),//4 bits for note value(0 to 15) [3:0]
    .read_data_duration_value_output(learning_memory_data_duration_value_output),//26 bits for duration value(0 to 100000000) [25:0]
    .isvalid(learning_isvalid)
);

memory_cell auto_memory_cell_impl(
    .clk(clk),
    .rst(rst),
    .isread(memory_isread),
    .songnum(memory_songnum),//memory depth num
    .location(auto_last_memory_location),// 5 bit 

    .read_data_note_value_output(auto_memory_read_data_note_value_output),//4 bits for note value(0 to 15) [3:0]
    .read_data_duration_value_output(auto_memory_data_duration_value_output),//26 bits for duration value(0 to 100000000) [25:0]
    .isvalid(auto_isvalid)
);

endmodule