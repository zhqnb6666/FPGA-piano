module LearningMode (
    input clk,
    input rst,
    input [2:0] song_select,
    input [3:0] pressed_key,
    input key_pressed,
    output reg [3:0] note_to_play,
    output reg play_note,
    output reg note_buzzed
);

  reg  [ 4:0] note_index;  // Index to track the current note in the song
  reg  [25:0] counter;  // Counter to track note duration
  wire [ 3:0] current_note;  // Current note from the song library
  wire [25:0] current_duration;  // Duration of the current note

  // Instantiate song library module
  songlib songlib_inst (
      .song_number(song_select),
      .note_index(note_index),
      .note(current_note),
      .duration(current_duration)
  );

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

