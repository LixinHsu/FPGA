module lab3 (
    input en,
    input up,
    input clk,    // 假設板子提供的是 50MHz 時脈
    input rst,    // 負邊緣觸發 (negedge)
    output reg [15:0] dout
);

    // --- 1. 分頻器邏輯：將 50MHz 轉為大約 4Hz (每秒跳 4 次) ---
    reg [23:0] clk_divider;
    wire slow_clk;
    
    always @(posedge clk or negedge rst) begin
        if (!rst) clk_divider <= 24'd0;
        else clk_divider <= clk_divider + 1'b1;
    end
    assign slow_clk = clk_divider[23]; // 取高位元作為慢速時脈

    // --- 2. 智慧計數邏輯 ---
    reg [3:0] consecutive_cnt;

    always @(posedge slow_clk or negedge rst) begin
        if (!rst) begin
            dout <= 16'd0;
            consecutive_cnt <= 4'd0;
        end 
        else if (en) begin
            if (up) begin
                // 向上計數邏輯
                if (dout < 16'hffff) begin
                    if (consecutive_cnt >= 4'd15) // 連續 15 次後以 +/- 2 計數
                        dout <= (dout >= 16'hfffe) ? 16'hffff : dout + 16'd2;
                    else
                        dout <= dout + 16'd1;
                    
                    // 增加連續計數次數
                    if (consecutive_cnt < 4'd15) 
                        consecutive_cnt <= consecutive_cnt + 4'd1;
                end else begin
                    dout <= 16'hffff; // 停留在 16'hffff
                end
            end 
            else begin
                // 向下計數邏輯
                if (dout > 16'd0) begin
                    if (consecutive_cnt >= 4'd15) // 連續 15 次後以 +/- 2 計數
                        dout <= (dout <= 16'd1) ? 16'd0 : dout - 16'd2;
                    else
                        dout <= dout - 16'd1;
                    
                    if (consecutive_cnt < 4'd15) 
                        consecutive_cnt <= consecutive_cnt + 4'd1;
                end else begin
                    dout <= 16'd0; // 停留在 16'd0
                end
            end
        end
        else begin
            consecutive_cnt <= 4'd0; // en=0 時停止計數，重置連續紀錄
        end
    end

endmodule