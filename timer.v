module timer(
    input clk,          // 时钟信号
    input rst,          // 重置信号
    input time_on,      // 计时器启动信号
    input [6:0] time_in, // 输入时间
    output reg [6:0] time_out // 输出时间
);

reg [31:0] counter;  // 定义一个足够大的计数器以存储1秒的时钟周期数

always @(posedge clk or posedge rst) begin
    if (rst) begin
        // 重置状态
        counter <= 0;
        time_out <= time_in;
    end else if (time_on && counter < 32'd100000000) begin
        // 计时中，增加计数器
        counter <= counter + 1;
    end else if (time_on && counter >= 32'd100000000) begin
        // 每秒减少 time_out
        counter <= 0; // 重置计数器
        if (time_out > 0) begin
            time_out <= time_out - 1;
        end
    end else begin
        // 如果 time_on 为0，保持输出时间不变
        counter <= 0; // 重置计数器
        time_out <= time_in;
    end
end

endmodule
