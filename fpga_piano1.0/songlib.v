module songlib(
    input [1:0] song_number,  // Input to select which song
    input [4:0] note_index,   // Input to select the note index
    output reg [3:0] note,    // Output for the note
    output reg [25:0] duration // Output for the duration
);

// Arrays for "Ode to Joy"
reg [3:0] song1_notes[0:25];
reg [25:0] song1_durations[0:25];

// Arrays for "Happy Birthday"
reg [3:0] song2_notes[0:25];
reg [25:0] song2_durations[0:25];

// Arrays for "Mary Had a Little Lamb"
reg [3:0] song3_notes[0:25];
reg [25:0] song3_durations[0:25];

initial begin
    // Initialize "Ode to Joy"
    song1_notes[0] <= 5'd2;  song1_durations[0] <= 50000000;  // E
    song1_notes[1] <= 5'd2;  song1_durations[1] <= 50000000;  // E
    song1_notes[2] <= 5'd3;  song1_durations[2] <= 50000000;  // F
    song1_notes[3] <= 5'd4;  song1_durations[3] <= 50000000;  // G
    song1_notes[4] <= 5'd4;  song1_durations[4] <= 50000000;  // G
    song1_notes[5] <= 5'd3;  song1_durations[5] <= 50000000;  // F
    song1_notes[6] <= 5'd2;  song1_durations[6] <= 50000000;  // E
    song1_notes[7] <= 5'd1;  song1_durations[7] <= 50000000;  // D
    song1_notes[8] <= 5'd0;  song1_durations[8] <= 50000000;  // C
    song1_notes[9] <= 5'd0;  song1_durations[9] <= 50000000;  // C
    song1_notes[10] <= 5'd1; song1_durations[10] <= 50000000; // D
    song1_notes[11] <= 5'd2; song1_durations[11] <= 50000000; // E
    song1_notes[12] <= 5'd2; song1_durations[12] <= 75000000; // E (longer duration)
    song1_notes[13] <= 5'd1; song1_durations[13] <= 50000000; // D
    song1_notes[14] <= 5'd1; song1_durations[14] <= 50000000; // D
    song1_notes[15] <= 5'd2; song1_durations[15] <= 50000000; // E
    song1_notes[16] <= 5'd4; song1_durations[16] <= 50000000; // G
    song1_notes[17] <= 5'd3; song1_durations[17] <= 50000000; // F
    song1_notes[18] <= 5'd2; song1_durations[18] <= 50000000; // E
    song1_notes[19] <= 5'd1; song1_durations[19] <= 50000000; // D
    song1_notes[20] <= 5'd0; song1_durations[20] <= 50000000; // C
    song1_notes[21] <= 5'd0; song1_durations[21] <= 50000000; // C
    song1_notes[22] <= 5'd1; song1_durations[22] <= 50000000; // D
    song1_notes[23] <= 5'd2; song1_durations[23] <= 50000000; // E
    song1_notes[24] <= 5'd1; song1_durations[24] <= 75000000; // D (longer duration)
    song1_notes[25] <= 5'd0; song1_durations[25] <= 75000000; // C (longer duration)

    // "Happy Birthday" melody
    // Notes are represented with indices; higher octave notes are 7 indices higher
    song2_notes[0] <= 5'd0;  song2_durations[0] <= 50000000;  // C
    song2_notes[1] <= 5'd0;  song2_durations[1] <= 50000000;  // C
    song2_notes[2] <= 5'd2;  song2_durations[2] <= 50000000;  // E
    song2_notes[3] <= 5'd0;  song2_durations[3] <= 50000000;  // C
    song2_notes[4] <= 5'd5;  song2_durations[4] <= 50000000;  // A (higher octave)
    song2_notes[5] <= 5'd4;  song2_durations[5] <= 100000000; // G
    song2_notes[6] <= 5'd0;  song2_durations[6] <= 50000000;  // C
    song2_notes[7] <= 5'd0;  song2_durations[7] <= 50000000;  // C
    song2_notes[8] <= 5'd2;  song2_durations[8] <= 50000000;  // E
    song2_notes[9] <= 5'd0;  song2_durations[9] <= 50000000;  // C
    song2_notes[10] <= 5'd7; song2_durations[10] <= 50000000; // C5 (higher octave)
    song2_notes[11] <= 5'd5; song2_durations[11] <= 100000000; // A (higher octave)
    song2_notes[12] <= 5'd0; song2_durations[12] <= 50000000;  // C
    song2_notes[13] <= 5'd0; song2_durations[13] <= 50000000;  // C
    song2_notes[14] <= 5'd14;song2_durations[14] <= 50000000; // C6 (higher octave)
    song2_notes[15] <= 5'd10;song2_durations[15] <= 50000000; // F5 (higher octave)
    song2_notes[16] <= 5'd5; song2_durations[16] <= 50000000;  // A (higher octave)
    song2_notes[17] <= 5'd4; song2_durations[17] <= 50000000;  // G
    song2_notes[18] <= 5'd7; song2_durations[18] <= 50000000;  // C5 (higher octave)
    song2_notes[19] <= 5'd9; song2_durations[19] <= 50000000;  // E5 (higher octave)
    song2_notes[20] <= 5'd10;song2_durations[20] <= 50000000; // F5 (higher octave)
    song2_notes[21] <= 5'd5; song2_durations[21] <= 50000000;  // A (higher octave)
    song2_notes[22] <= 5'd7; song2_durations[22] <= 50000000;  // C5 (higher octave)
    song2_notes[23] <= 5'd4; song2_durations[23] <= 100000000; // G
    song2_notes[24] <= 5'd4; song1_durations[24] <= 100000000; // 
    song2_notes[25] <= 5'd4; song1_durations[25] <= 100000000; // 


        // "Mary Had a Little Lamb" with varied durations
    song3_notes[0] <= 5'd2;  song3_durations[0] <= 25000000;  // E, short
    song3_notes[1] <= 5'd1;  song3_durations[1] <= 75000000;  // D, long
    song3_notes[2] <= 5'd0;  song3_durations[2] <= 25000000;  // C, short
    song3_notes[3] <= 5'd1;  song3_durations[3] <= 25000000;  // D, short
    song3_notes[4] <= 5'd2;  song3_durations[4] <= 25000000;  // E, short
    song3_notes[5] <= 5'd2;  song3_durations[5] <= 25000000;  // E, short
    song3_notes[6] <= 5'd2;  song3_durations[6] <= 75000000;  // E, long
    song3_notes[7] <= 5'd1;  song3_durations[7] <= 25000000;  // D, short
    song3_notes[8] <= 5'd1;  song3_durations[8] <= 25000000;  // D, short
    song3_notes[9] <= 5'd1;  song3_durations[9] <= 75000000;  // D, long
    song3_notes[10] <= 5'd2; song3_durations[10] <= 25000000; // G, short
    song3_notes[11] <= 5'd4; song3_durations[11] <= 75000000; // G, long
    song3_notes[12] <= 5'd2; song3_durations[12] <= 25000000; // E, short
    song3_notes[13] <= 5'd1; song3_durations[13] <= 75000000; // D, long
    song3_notes[14] <= 5'd0; song3_durations[14] <= 25000000; // C, short
    song3_notes[15] <= 5'd1; song3_durations[15] <= 25000000; // D, short
    song3_notes[16] <= 5'd2; song3_durations[16] <= 25000000; // E, short
    song3_notes[17] <= 5'd2; song3_durations[17] <= 25000000; // E, short
    song3_notes[18] <= 5'd2; song3_durations[18] <= 75000000; // E, long
    song3_notes[19] <= 5'd1; song3_durations[19] <= 25000000; // D, short
    song3_notes[20] <= 5'd2; song3_durations[20] <= 25000000; // E, short
    song3_notes[21] <= 5'd1; song3_durations[21] <= 75000000; // D, long
    song3_notes[22] <= 5'd0; song3_durations[22] <= 25000000; // C, short
    song3_notes[23] <= 5'd0; song3_durations[23] <= 25000000; // 
    song3_notes[24] <= 5'd0; song3_durations[24] <= 25000000; // 
    song3_notes[25] <= 5'd0; song3_durations[25] <= 25000000; // 
end

// Logic to output the note and duration
always @(*) begin
    case(song_number)
        2'b00: begin
            note = song1_notes[note_index];
            duration = song1_durations[note_index];
        end
        2'b01: begin
            note = song2_notes[note_index];
            duration = song2_durations[note_index];
        end
        2'b10: begin
            note = song3_notes[note_index];
            duration = song3_durations[note_index];
        end
        default: begin
            note = 4'd0;
            duration = 26'd0;
        end
    endcase
end

endmodule
