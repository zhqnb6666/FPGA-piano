module TopModule(
    input clk,  // Main clock
    input rst,  // Reset signal
    input [7:0] key_input,    // Key input for key.v
    input higher_8,           // Higher 8 bits of key_input
    input key_on,             // Key on signal from keyControl.v
    input [2:0] mode_input,    //
    input song_select_switch,
    // Other global inputs like switches, buttons, etc.
    output [7:0] led_output,  // LED output from led.v
    output higher_8_led,      // Higher 8 bits of LED output
    output buzzer_output,     // Buzzer output from buzzer.v
    output [6:0] segment_output, // Segment output for display
    output [1:0] digit_select_output, 
    output [2:0] mode_led_output  //
    
);

// Inter-module signals
// wire [3:0] current_track;
parameter FREE_MODE = 3'b001; 
parameter AUTO_PLAY_MODE = 3'b010; 
parameter LEARNING_MODE = 3'b100;
parameter WRONG_STATE =3'b000;

wire [2:0] state;
reg [3:0] songnum;
reg [7:0] led_outputf;  // LED output from led.v
reg buzzer_outputf;     // Buzzer output from buzzer.v
reg [6:0] segment_outputf; // Segment output for display
reg [1:0] digit_select_outputf; // Digit select output for display

wire [3:0] learning_key_out;
wire [3:0] learning_note_out;//note from songpage
wire [3:0] learning_key_input;
wire learning_note_out_on;
wire learning_correct_key_press;
wire [7:0] learning_led_output;//from songpage
wire learning_buzzer_output;//from user input
wire [6:0] learning_segment_output;//score
wire [1:0] learning_digit_select_output;
reg [1:0] learning_score;

wire auto_key_on;
wire [3:0] auto_key;
wire [7:0] auto_led_output;
wire [6:0] auto_segment_output;
wire [1:0] auto_digit_select_output;
wire auto_buzzer_output;

wire [3:0] free_key_out;
wire [3:0] free_key_input;
wire free_key_input_on;
wire [3:0] free_key_out;
wire free_key_out_on;
wire [7:0] free_led_output;
wire free_buzzer_output;
wire [6:0] free_segment_output;
wire [1:0] free_digit_select_output;


assign learning_key_input=key_input[7]*1+key_input[6]*2+key_input[5]*3+key_input[4]*4+key_input[3]*5+key_input[2]*6+key_input[1]*7+key_input[0]*8+higher_8*7;
assign free_key_input=key_input[7]*1+key_input[6]*2+key_input[5]*3+key_input[4]*4+key_input[3]*5+key_input[2]*6+key_input[1]*7+key_input[0]*8+higher_8*7;
assign led_output = led_outputf; // LED output from led.v
assign buzzer_output=buzzer_outputf;     // Buzzer output from buzzer.v
assign segment_output=segment_outputf; // Segment output for display
assign digit_select_output=digit_select_outputf; // Digit select output for display 

always@(posedge rst)
begin
    learning_score<=0;
end

always@(posedge learning_correct_key_press)
begin
    learning_score<=learning_score+1;
end

always@(posedge song_select_switch)
    begin
        songnum<=key_input[7:4];
    end

fsm fsmmodule(
   .clk(clk),
   .rst(rst),
   .x_in(mode_input),

   .state(state),
   .mode_led_1_2_3(mode_led_output)
);
/*learning
led_outputf<=learning_led_output;
buzzer_outputf<=learning_buzzer_output;
segment_outputf<=learning_segment_output;
digit_select_outputf<=learning_digit_select_output; */

PlaySong learningModule(
    .clk(clk),
    .rst(rst),
    .num(songnum),
    .learning_correct_key_press(learning_correct_key_press),

    .key_on(learning_note_out_on),
    .key(learning_note_out)
);

key_examine learning_keyExamineModule(
    .clk(clk),
    .rst(rst),
    .key_in(learning_key_input),
    .correct_key(learning_note_out),

    .learning_correct_key_press(learning_correct_key_press)
);


ledControl learning_ledModule(
    .clk(clk),
    .rst(rst),
    .current_track(learning_note_out), // Connected from keyControlModule
    .playing(key_on),    // Connected from keyControlModule

    .led_output(learning_led_output),
    .higher_8_led(higher_8_led)
);


DisplayCounter learning_displayCounterModule(
    .clk(clk),
    .rst(rst),
    .counter_value(learning_score),

    .seg(learning_segment_output),
    .digit_select(learning_digit_select_output)
);

buzzer learning_buzzerModule(
    .clk(clk),
    .rst(rst),
    .key_on(learning_note_out_on), // Connected from keyControlModule
    .key(learning_note_out),       // Connected from keyControlModule

    .buzzer(learning_buzzer_output)
);

/*auto
led_outputf<=auto_led_output;
buzzer_outputf<=auto_buzzer_output;
segment_outputf<=auto_segment_output;
digit_select_outputf<=auto_digit_select_output
*/

PlaySongController auto_songpageModule(
    .clk(clk),
    .rst(rst),
    .num(key_input[7:4]),

    .key_on(auto_key_on),//switch
    .key(auto_key)      //freqency
);

ledControl auto_ledModule(
    .clk(clk),
    .rst(rst),
    .current_track(auto_key), 
    .playing(auto_key_on),

    .led_output(auto_led_output),
    .higher_8_led(higher_8_led)
);

DisplayCounter auto_displayCounterModule(
    .clk(clk),
    .rst(rst),
    .counter_value(auto_key),

    .seg(auto_segment_output),
    .digit_select(auto_digit_select_output)
);

buzzer auto_buzzerModule(
    .clk(clk),
    .rst(rst),
    .key_on(auto_key_on), 
    .key(auto_key),

    .buzzer(auto_buzzer_output)
);



/* free
led_outputf<=key_input;
buzzer_outputf<=free_buzzer_output;
segment_outputf<=free_segment_output;
digit_select_outputf<=free_digit_select_output;
*/
keyControl free_keyControlModule(
    .clk(clk),
    .rst(rst),
    .key_on(key_on),//bool
    .key(key_input),
    .higher_8(higher_8),

    .key_out(free_key_out),//[3:0]
    .key_out_on(free_key_out_on)//bool
);

ledControl free_ledModule(
    .clk(clk),
    .rst(rst),
    .current_track(free_key_input), // Connected from keyControlModule
    .playing(key_on),    // Connected from keyControlModule

    .led_output(free_led_output),
    .higher_8_led(higher_8_led)
);

buzzer free_buzzerModule(
    .clk(clk),
    .rst(rst),
    .key_on(free_key_input_on), // Connected from keyControlModule
    .key(free_key_input),       // Connected from keyControlModule

    .buzzer(free_buzzer_output)
);

DisplayCounter free_displayCounterModule(
    .clk(clk),
    .rst(rst),
    .counter_value(free_key_out),
    
    .seg(free_segment_output),
    .digit_select(free_digit_select_output)
);

always@(state)
begin
    case(state)
        LEARNING_MODE: begin
                led_outputf<=learning_led_output;
                buzzer_outputf<=learning_buzzer_output;
                segment_outputf<=learning_segment_output;
                digit_select_outputf<=learning_digit_select_output;                
            end
        AUTO_PLAY_MODE:begin
                led_outputf<=auto_led_output;
                buzzer_outputf<=auto_buzzer_output;
                segment_outputf<=auto_segment_output;
                digit_select_outputf<=auto_digit_select_output;    
            end
        FREE_MODE:begin
                led_outputf<=key_input;
                buzzer_outputf<=free_buzzer_output;
                segment_outputf<=free_segment_output;
                digit_select_outputf<=free_digit_select_output;
           end
        default:
            begin
                led_outputf<=8'b0;
                buzzer_outputf<=0;
                segment_outputf<=0;
                digit_select_outputf<=0;
            end        
    endcase       
end
endmodule
