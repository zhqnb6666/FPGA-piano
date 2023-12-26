module Debouncer (
    input wire clk,
    input wire reset,
    input wire button_in,
    output reg button_out
);

    // Define the number of clock cycles for the debounce period
    parameter DEBOUNCE_TIME = 50_000;  // Adjust this value as needed

    reg [15:0] counter;  // 16-bit counter should be enough for most clock frequencies
    reg button_in_prev;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 0;
            button_in_prev <= 0;
            button_out <= 0;
        end else begin
            if (button_in != button_in_prev) begin
                counter <= 0;
            end else if (counter < DEBOUNCE_TIME) begin
                counter <= counter + 1;
            end else begin
                button_out <= button_in;
            end
            button_in_prev <= button_in;
        end
    end

endmodule