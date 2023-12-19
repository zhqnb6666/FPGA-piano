module PlaySong(
    input clk,
    input rst,
    output reg key_on,
    output reg [3:0] key,
    output [6:0] duration
);

assign duration = 7'd12;

// Define the song notes and durations
reg [3:0] song[0:23]; // Adjusted length for the song
integer i = 0;
reg [25:0] counter = 0; // Duration counter

initial begin
    // "Twinkle, Twinkle, Little Star" notes (simplified)
    // Each pair of notes is the same, representing one syllable
    song[0] = 5'd0;  // C
    song[1] = 5'd0;  // C
    song[2] = 5'd4;  // G
    song[3] = 5'd4;  // G
    song[4] = 5'd5;  // A
    song[5] = 5'd5;  // A
    song[6] = 5'd4;  // G
    song[7] = 5'd3;  // F
    song[8] = 5'd3;  // F
    song[9] = 5'd2;  // E
    song[10] = 5'd2; // E
    song[11] = 5'd1; // D
    song[12] = 5'd1; // D
    song[13] = 5'd0; // C
    song[14] = 5'd4; // G
    song[15] = 5'd4; // G
    song[16] = 5'd3; // F
    song[17] = 5'd3; // F
    song[18] = 5'd2; // E
    song[19] = 5'd2; // E
    song[20] = 5'd1; // D
    song[21] = 5'd1; // D
    song[22] = 5'd0; // C
    song[23] = 5'd0; // C
end

always @(posedge clk or posedge rst) begin
    if (rst) begin
        i <= 0;
        counter <= 0;
        key_on <= 0;
    end
    else if(counter == 26'd25000000) begin // Fixed duration for each note
        key_on <= 0;
        counter <= counter + 1 ;
    end
    else if (counter == 26'd50000000) begin // Fixed duration for each note
        key <= song[i];
        key_on <= 1;
        counter <= 0;
        i <= (i + 1) % 24; // Loop back to the start of the song
    end
    else begin
        counter <= counter + 1;
    end
end

endmodule
 