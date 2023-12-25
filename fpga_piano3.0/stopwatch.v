module stopwatch(
    input clk,         // Main clock signal
    input rst,         // Reset signal
    input stop,  // Start/Stop control signal
    input start,  // Start/Stop control signal
    output reg [31:0] elapsed_time // Elapsed time in seconds
);

reg [26:0] counter;       // Counter for the clock cycles
reg running;              // Indicates if the stopwatch is running


always @(posedge clk ) begin
    if (rst) begin
        counter <= 0;
        elapsed_time <= 0;
        running <= 0;
    end
    else if(start) begin
        running <= 1;
    end
    else if (stop) begin
        running <= 0; 
    end
    if (running) begin
        counter <= counter + 1;
        if (counter >= 100_000_000) begin // When one second has passed
            elapsed_time <= elapsed_time + 1; // Increment elapsed time
            counter <= 0; // Reset counter
        end
    end
end

endmodule
