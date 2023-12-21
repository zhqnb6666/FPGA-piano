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
    output [6:0] segment_output1, // Segment output for display
    output [6:0] segment_output, // Segment output for display
    output [1:0] digit_select_output, 
    output [2:0] mode_led_output  //
    
);

// Inter-module signals
// wire [3:0] current_track;
wire [3:0] learning_key_out;
wire [3:0] learning_note_out;
wire learning_note_out_on;

wire [3:0] free_key_out;
wire [3:0] free_note_out;

assign free_note_out=key_input[7]*1+key_input[6]*2+key_input[5]*3+key_input[4]*4+key_input[3]*5+key_input[2]*6+key_input[1]*7+key_input[0]*8+higher_8*7;
wire free_note_out_on;

wire [6:0] counter_value;
wire [6:0] time_in;
wire [6:0] time_out;

parameter FREE_MODE = 3'b001; //◊‘”… ‰»Î
parameter AUTO_PLAY_MODE = 3'b010; //≤•∑≈ø‚“Ù¿÷
parameter LEARNING_MODE = 3'b100;//ø‚“Ù¿÷—ßœ∞
parameter WRONG_STATE =3'b000;

wire correct_key_press;
wire [2:0] state;
wire [2:0] next_state;



// assign counter_value = key_out;
assign time_in = counter_value;


fsm fsmmodule(
   .clk(clk),
   .rst(rst),
   .state(state),
   .next_state(next_state),
   .x_in(mode_input),
   .mode_led_1_2_3(mode_led_output)
);


// Instantiate keyControl module

wire [3:0] free_key_out;
wire free_key_out_on;
keyControl free_keyControlModule(
    .clk(clk),
    .rst(rst),
    .key_on(key_on),//bool
    .key(key_input),
    .higher_8(higher_8),
    .key_out(free_key_out),
    .key_out_on(free_key_out_on)//bool
);

// Instantiate led module
wire [7:0] free_led_output;

ledControl free_ledModule(
    .clk(clk),
    .rst(rst),
    .current_track(free_note_out), // Connected from keyControlModule
    .playing(key_on),    // Connected from keyControlModule
    .led_output(free_led_output),
    .higher_8_led(higher_8_led)
);

wire [7:0] learning_led_output;

ledControl learning_ledModule(
    .clk(clk),
    .rst(rst),
    .current_track(learning_note_out), // Connected from keyControlModule
    .playing(key_on),    // Connected from keyControlModule
    .led_output(learning_led_output),
    .higher_8_led(higher_8_led)
);
reg [3:0] songnum;
always@(posedge song_select_switch)
    begin
        songnum<=key_input[7:4];
    end
 
// Instantiate PlaySong module learning
wire correct_key_press;
PlaySong learningModule(
    .clk(clk),
    .rst(rst),
    .num(songnum),
    .correct_key_press(correct_key_press),
    .key_on(learning_note_out_on),
    .key(learning_note_out)
);

/*timer timerModule(
    .clk(clk),
    .rst(rst),
    .time_on(key_on), // Connected from keyControlModule
    .time_in(time_in),
    .time_out(time_out)
);*/

// Instantiate key_examine module
key_examine keyExamineModule(
    .clk(clk),
    .rst(rst),
    .key_in(learning_key_out),
    .correct_key(learning_note_out),
    .correct_key_press(correct_key_press)
);

// Instantiate buzzer module
wire learning_buzzer_output;
buzzer learning_buzzerModule(
    .clk(clk),
    .rst(rst),
    .key_on(learning_note_out_on), // Connected from keyControlModule
    .key(learning_note_out),       // Connected from keyControlModule
    .buzzer(learning_buzzer_output)
);





wire free_buzzer_output;
buzzer free_buzzerModule(
    .clk(clk),
    .rst(rst),
    .key_on(free_note_out_on), // Connected from keyControlModule
    .key(free_note_out),       // Connected from keyControlModule
    .buzzer(free_buzzer_output)
);

// Instantiate DisplayCounter module

wire [6:0] free_segment_output;
wire [1:0] free_digit_select_output;

DisplayCounter free_displayCounterModule(
    .clk(clk),
    .rst(rst),
    .counter_value(free_key_out),
    .seg(free_segment_output),
    .digit_select(free_digit_select_output)
);

wire [6:0] learning_segment_output;
wire [1:0] learning_digit_select_output;
DisplayCounter learning_displayCounterModule(//unfinished
    .clk(clk),
    .rst(rst),
    .counter_value(learning_key_out),
    .seg(learning_segment_output),
    .digit_select(learning_digit_select_output)
);

wire auto_key_on;
wire [3:0] auto_key;
PlaySongController auto_songpageModule(
    .clk(clk),
    .rst(rst),
    .num(key_input[7:4]),
    .key_on(auto_key_on),//switch
    .key(auto_key)      //freqency
);

wire [7:0] auto_led_output;
ledControl auto_ledModule(
    .clk(clk),
    .rst(rst),
    .current_track(auto_key), 
    .playing(auto_key_on),    
    .led_output(auto_led_output),
    .higher_8_led(higher_8_led)
);

wire [6:0] auto_segment_output;
wire [1:0] auto_digit_select_output;
DisplayCounter auto_displayCounterModule(//unfinished
    .clk(clk),
    .rst(rst),
    .counter_value(auto_key),
    .seg(auto_segment_output),
    .digit_select(auto_digit_select_output)
);

wire auto_buzzer_output;
buzzer auto_buzzerModule(
    .clk(clk),
    .rst(rst),
    .key_on(auto_key_on), 
    .key(auto_key),       
    .buzzer(auto_buzzer_output)
);

/*
    input [7:0] key_input,    // Key input for key.v
    input higher_8,           // Higher 8 bits of key_input
    input key_on,             // Key on signal from keyControl.v
    output [7:0] led_output,  // LED output from led.v
    output buzzer_output,     // Buzzer output from buzzer.v
    output [6:0] segment_output, // Segment output for display
    output [1:0] digit_select_output, // Digit select output for display
*/
reg [7:0] led_outputf;  // LED output from led.v
reg buzzer_outputf;     // Buzzer output from buzzer.v
reg [6:0] segment_outputf; // Segment output for display
reg [1:0] digit_select_outputf; // Digit select output for display
assign led_output = led_outputf; // LED output from led.v
assign buzzer_output=buzzer_outputf;     // Buzzer output from buzzer.v
assign segment_output=segment_outputf; // Segment output for display
assign digit_select_output=digit_select_outputf; // Digit select output for display 

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
            end        
    endcase
        
end

endmodule