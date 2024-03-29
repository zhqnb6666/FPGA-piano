module PlaySong_3(
    input clk,
    input rst,
    output reg key_on,
    output reg [3:0] key
);

reg [3:0] song[0:23]; 
reg [25:0] durations[0:23]; 
integer i = 0; 
reg [25:0] counter = 0; 

parameter [3:0] song[0:23] = {
        4'd0, 4'd0, 4'd2, 4'd0, 4'd5, 4'd4,
        4'd0, 4'd0, 4'd2, 4'd0, 4'd7, 4'd5,
        4'd0, 4'd0, 4'd14, 4'd10, 4'd5, 4'd4, 4'd7,
        4'd9, 4'd10, 4'd5, 4'd7, 4'd4
    };

parameter [25:0] durations[0:23] = {
        50000000, 50000000, 50000000, 50000000, 50000000, 100000000,
        50000000, 50000000, 50000000, 50000000, 50000000, 100000000,
        50000000, 50000000, 50000000, 50000000, 50000000, 50000000, 50000000,
        50000000, 50000000, 50000000, 50000000, 100000000
    };
    
/*initial begin
    // "Happy Birthday" melody
    // Notes are represented with indices; higher octave notes are 7 indices higher
    song[0] = 5'd0;  durations[0] = 50000000;  // C
    song[1] = 5'd0;  durations[1] = 50000000;  // C
    song[2] = 5'd2;  durations[2] = 50000000;  // E
    song[3] = 5'd0;  durations[3] = 50000000;  // C
    song[4] = 5'd5;  durations[4] = 50000000;  // A (higher octave)
    song[5] = 5'd4;  durations[5] = 100000000; // G
    // Next phrase
    song[6] = 5'd0;  durations[6] = 50000000;  // C
    song[7] = 5'd0;  durations[7] = 50000000;  // C
    song[8] = 5'd2;  durations[8] = 50000000;  // E
    song[9] = 5'd0;  durations[9] = 50000000;  // C
    song[10] = 5'd7; durations[10] = 50000000; // C5 (higher octave)
    song[11] = 5'd5; durations[11] = 100000000; // A (higher octave)
    // Next phrase
    song[12] = 5'd0; durations[12] = 50000000;  // C
    song[13] = 5'd0; durations[13] = 50000000;  // C
    song[14] = 5'd14; durations[14] = 50000000; // C6 (higher octave)
    song[15] = 5'd10; durations[15] = 50000000; // F5 (higher octave)
    song[16] = 5'd5; durations[16] = 50000000;  // A (higher octave)
    song[17] = 5'd4; durations[17] = 50000000;  // G
    song[18] = 5'd7; durations[18] = 50000000;  // C5 (higher octave)
    // Last phrase
    song[19] = 5'd9; durations[19] = 50000000;  // E5 (higher octave)
    song[20] = 5'd10; durations[20] = 50000000; // F5 (higher octave)
    song[21] = 5'd5; durations[21] = 50000000;  // A (higher octave)
    song[22] = 5'd7; durations[22] = 50000000;  // C5 (higher octave)
    song[23] = 5'd4; durations[23] = 100000000; // G
end*/




always @(posedge clk or posedge rst) begin
    if (rst) begin
        i <= 0;
        counter <= 0;
        key_on <= 0;
    end else if(counter == durations[i]/2) begin
        key_on <= 0; 
        counter <= counter + 1;
    end else if (counter >= durations[i]) begin
        counter <= 0;
        i <= (i + 1) % 24; 
    end else begin
        counter <= counter + 1;
        if (counter == 1) begin
            key <= song[i];
            key_on <= 1; 
        end
    end
end

endmodule
