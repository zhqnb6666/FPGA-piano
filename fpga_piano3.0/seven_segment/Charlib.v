module chars_lib(
    input [3:0] index,  // 4-bit input index to select the word
    output reg [6:0] char0,
    output reg [6:0] char1,
    output reg [6:0] char2,
    output reg [6:0] char3
);

    // Define character patterns for 7-segment display
    reg [6:0] A, B, C, D, E, F, R, U, L, N, T, S, O;

    // Initialize the character patterns
    initial begin
        A = 7'b1110111; // 'A'
        B = 7'b1111100; // 'B'
        C = 7'b0111001; // 'C'
        D = 7'b1011110; // 'D'
        E = 7'b1111001; // 'E'
        F = 7'b1110001; // 'F'
        L = 7'b0111000; // 'L'
        N = 7'b1010100; // 'N'
        R = 7'b1010000; // 'R'
        T = 7'b1111000; // 'T'
        U = 7'b0111110; // 'U'
        S = 7'b1011011; // 'S' (Same as '5')
        O = 7'b0111111; // 'O' (Same as '0')
    end

    // Logic to select the characters based on the input index
    always @(*) begin
        case(index)
            0: {char3, char2, char1, char0} = {F, R, E, E};         // "FREE"
            1: {char3, char2, char1, char0} = {A, U, T, O};         // "AUTO"
            2: {char3, char2, char1, char0} = {L, R, N, 7'b0000000}; // "LRN "
            3: {char3, char2, char1, char0} = {A, 7'b0000000, 7'b0000000, 7'b0000000}; // "A   "
            4: {char3, char2, char1, char0} = {B, 7'b0000000, 7'b0000000, 7'b0000000}; // "B   "
            5: {char3, char2, char1, char0} = {C, 7'b0000000, 7'b0000000, 7'b0000000}; // "C   "
            6: {char3, char2, char1, char0} = {D, 7'b0000000, 7'b0000000, 7'b0000000}; // "D   "
            7: {char3, char2, char1, char0} = {S, E, T, 7'b0000000}; // "SET "
            default: {char3, char2, char1, char0} = {7'b0000000, 7'b0000000, 7'b0000000, 7'b0000000}; // Blank
        endcase
    end

endmodule
