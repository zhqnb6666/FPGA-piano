module buzzer (
    input  clk,
    input  rst,
    input key_on,
    input [4:0] key,
    output reg buzzer
);
reg [31:0] counter;
reg [31:0] freq [16:0]; 

initial begin
    freq[0] = 100000000 / 261 / 2; // C4
    freq[1] = 100000000 / 293 / 2; // D4
    freq[2] = 100000000 / 329 / 2; // E4
    freq[3] = 100000000 / 349 / 2; // F4
    freq[4] = 100000000 / 392 / 2; // G4
    freq[5] = 100000000 / 440 / 2; // A4
    freq[6] = 100000000 / 493 / 2; // B4
    freq[7] = 100000000 / 523 / 2; // C5
    freq[8] = 100000000 / 587 / 2; // D5
    freq[9] = 100000000 / 659 / 2; // E5
    freq[10] = 100000000 / 698 / 2; // F5
    freq[11] = 100000000 / 784 / 2; // G5
    freq[12] = 100000000 / 880 / 2; // A5
    freq[13] = 100000000 / 987 / 2; // B5
    freq[14] = 100000000 / 1046 / 2; // C6
    freq[15] = 100000000 / 1174 / 2; // D6
end

always @(posedge clk or posedge rst) begin
    if (rst) begin
        counter <= 0;
        buzzer <= 0;
    end else if (counter >= freq[key]) begin
        counter <= 0;
        buzzer <= ~buzzer;
    end else if(key_on)begin
        counter <= counter + 1;
    end else begin
        counter <= 0;
        buzzer <= 0;
    end
    end

endmodule