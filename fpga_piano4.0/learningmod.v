module LearningMode (
    input clk,
    input rst,
    input [2:0] song_select,
    input [3:0] pressed_key,
    input key_pressed,
    output reg [3:0] note_to_play,
    output reg play_note,
    output reg note_buzzed,
    output [31:0] elapsed_time,
    output [6:0] char_segment_out, // Output for 7-segment display
    output [3:0] char_select,      // Select lines for 7-segment display
    output reg [1:0] level
);

    reg  [ 4:0] note_index;       // Index to track the current note in the song
    reg  [25:0] counter;          // Counter to track note duration
    wire [ 3:0] current_note;     // Current note from the song library
    wire [25:0] current_duration; // Duration of the current note
    wire  [3:0] rating_index;      // Index to select rating message
    wire [3:0] temp_select;


    // Instantiate song library module
    songlib songlib_inst (
        .song_number(song_select),
        .note_index(note_index),
        .note(current_note),
        .duration(current_duration)
    );

    stopwatch my_stopwatch(
        .clk(clk),
        .rst(rst),
        .start(note_index >= 1&&note_index<25),
        .stop(note_index >= 25),
        .elapsed_time(elapsed_time)
    );

     display_chars rating_display(
        .clk(clk),
        .rst(rst),
        .index(rating_index),
        .seg(char_segment_out),
        .digit_select(temp_select)
    );

    assign char_select = (note_index >=25)? temp_select: 4'b0000;

    // Determine the rating index based on elapsed time
    assign rating_index = (elapsed_time >= 10 && elapsed_time < 30) ? 4'd3 :  // 'A'
                          (elapsed_time >= 30 && elapsed_time < 60) ? 4'd4 :  // 'B'
                          (elapsed_time >= 60 && elapsed_time < 80) ? 4'd5 :  // 'C'
                          (elapsed_time >= 80) ? 4'd6 :  // 'D'
                          4'd8;  // No display for time < 20
                          

    always @(note_index) begin
     if(note_index>=25) level<= 6-rating_index;
     else level<= 0;
    end
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset logic
            note_index <= 0;
            note_to_play <= 0;
            play_note <= 0;
            counter <= 0;
            note_buzzed <= 0;
        end else begin
      if (key_pressed && (pressed_key == current_note) && (counter >= current_duration)) begin
        // Move to the next note
        note_index <= note_index + 1;
        counter <= 0;
        note_buzzed <= 0;
      end else if(counter < current_duration) begin
        // Update the note to play
        note_to_play <= current_note;
        play_note <= 1;
        if (counter == 0) begin
          note_buzzed <= 1; // Buzz the note at the start of its duration
        end
        counter <= counter + 1;
      end else begin
        // Reset note_buzzed at the end of the duration
        note_buzzed <= 0;
      end
    end
  end
endmodule

