module Learning_Top(
    input clk,  // Main clock
    input rst,  // Reset signal
    input [7:0] key_input,    // Key input
    input higher_8,           // Higher 8 bits of key_input
    input key_on,             // Key on signal from keyControl.v
    input continue_button,    // Continue button input
    input back_button,        // Back button input
    output [7:0] led_output,  // LED output
    output higher_8_led,      // Higher 8 bits of LED output
    output buzzer_output,     // Buzzer output
    output [6:0] segment_output, // Segment output for display
    output [1:0] digit_select_output, // Digit select output for display
    output [6:0] chars_segment_output, // Segment output for display
    output [3:0] chars_digit_select_output // Digit select output for display
);

    // Signals for inter-module connections
    wire [3:0] note;
    wire note_on;
    wire key_out_on;
    wire [3:0] key_out;
    wire continue_debounced;
    wire back_debounced;
    wire note_buzzed; // Indicates if a note has been buzzed
    reg [2:0] song_select = 0; // 3-bit register for song selection
    reg play_song = 0; // Signal to indicate whether to play the selected song
    reg [2:0] segment_to_show_index;
    reg [6:0] segment_to_show[0:7]; // 7-segment values for each digit
    reg [3:0] level;//level of the game

// Logic to update song_select and play_song
    always @(posedge clk or posedge rst) begin
        segment_to_show[0] <= key_out;
        segment_to_show[1] <= note;
        if (rst) begin
            song_select <= 0;
            play_song <= 0;
            segment_to_show_index <= 0;
        end else begin
            if (back_debounced) begin
                // Reset play_song when back is pressed
                play_song <= 0;
                segment_to_show_index <= 0;
            end else if (continue_debounced) begin
                // Start playing the selected song
                play_song <= 1;
                segment_to_show_index <= 1;
            end else if (!play_song) begin
                // Update song selection based on key_input when not playing
                song_select <= key_out; // Assuming lower 3 bits of key_input for song selection
            end
        end
    end



    // Learning Mode Logic
    LearningMode learningMode_inst(
        .clk(clk),
        .rst(~play_song), // Reset the Playmode module when not playing
        .song_select(song_select),
        .pressed_key(key_out),
        .key_pressed(key_out_on),
        .note_to_play(note),
        .play_note(note_on),
        .note_buzzed(note_buzzed)
    );

    
    // Instantiate the ledControl module
    ledControl ledControl_inst(
        .clk(clk),
        .rst(rst),
        .current_track(note),
        .playing(note_on),
        .led_output(led_output),
        .higher_8_led(higher_8_led)
    );

    // Instantiate the buzzer module
    buzzer buzzer_inst(
        .clk(clk),
        .rst(rst),
        .key_on(note_buzzed),
        .key(note),
        .buzzer(buzzer_output)
    );

    // DisplayCounter module for displaying song selection or other information
    DisplayCounter displayCounter_inst(
        .clk(clk),
        .rst(rst),
        .counter_value(segment_to_show[segment_to_show_index]),
        .seg(segment_output),
        .digit_select(digit_select_output)
    );
    // Instantiate Debouncer for continue and back buttons
    Debouncer continue_debouncer(
        .clk(clk),
        .reset(rst),
        .button_in(continue_button),
        .button_out(continue_debounced)
    );

    Debouncer back_debouncer(
        .clk(clk),
        .reset(rst),
        .button_in(back_button),
        .button_out(back_debounced)
    );

    // Instantiate keyControl module
    keyControl keyControlModule(
        .clk(clk),
        .rst(rst),
        .key_on(key_on),
        .key(key_input),
        .higher_8(higher_8),
        .key_out(key_out),
        .key_out_on(key_out_on)
    );
endmodule
