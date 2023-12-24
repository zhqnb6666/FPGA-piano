module Playmode(
    input clk,
    input rst,
    input [2:0] song_select,   // New input to select the song
    output reg key_on,
    output reg [3:0] key
);

integer i = 0; 
reg [25:0] counter = 0;

// Outputs from the songlib module
wire [3:0] current_note;
wire [25:0] current_duration;

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
        key_on <= 0;
    end else if (counter == current_duration / 2) begin
        key_on <= 0;
        counter <= counter + 1;
    end else if (counter >= current_duration) begin
        counter <= 0;
        i <= (i + 1) % 24;  // Assumes each song has 24 notes
    end else begin
        counter <= counter + 1;
        if (counter == 1) begin
            key <= current_note;
            key_on <= 1;
        end
    end
end

endmodule
