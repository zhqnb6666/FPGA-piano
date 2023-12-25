
module Playmode(
    input clk,
    input rst,
    input [2:0] song_select,   // Input to select the song
    input loop,                // Input to control looping
    output  key_on,
    output reg [3:0] key
);

integer i = 0;
reg key_on1 = 1;
reg key_on2 = 1;
reg [25:0] counter = 0;
reg [20:0] play_count = 0; // Counter for the number of times the song has been played

// Outputs from the songlib module
wire [3:0] current_note;
wire [25:0] current_duration;
assign key_on = key_on1 & key_on2;

// Instantiate the songlib module
songlib my_songlib(
    .song_number(song_select),
    .note_index(i),
    .note(current_note),
    .duration(current_duration)
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        i <= 0;
        counter <= 0;
        key_on1 <= 0;
        key_on2 <= 1;
        play_count <= 0;
    end else if (counter == current_duration / 2) begin
        key_on1 <= 0;
        counter <= counter + 1;
    end else if (counter >= current_duration) begin
        counter <= 0;
        i <= (i + 1) % 24; // Assumes each song has 24 notes
        // Check if the song has looped back to the start
        if (i == 0) begin
            play_count <= play_count + 1;
            // Stop playing if loop is 0 and song has played twice
            if (play_count >= 2 && ~loop) begin
                key_on2 <= 0;
                i <= 0; // Reset note index
            end else begin
                key_on2 <= 1;
            end
        end
    end else begin
        counter <= counter + 1;
        if (counter == 1) begin
            key <= current_note;
            key_on1 <= 1;
        end
    end
end

endmodule
