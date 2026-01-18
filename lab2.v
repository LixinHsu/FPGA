module lab2 (
    input  [3:0] a,      // 4-bit 輸入 a
    input  [3:0] b,      // 4-bit 輸入 b
    input  [1:0] sel,    // 2-bit 選擇信號
    output reg [3:0] out // 4-bit 輸出結果
);

    // 根據 sel 的值決定輸出邏輯
    always @(*) begin
        case (sel)
            2'b00:   out = a + b;  // 加法
            2'b01:   out = a | b;  // 位元邏輯或 (OR)
            2'b10:   out = a & b;  // 位元邏輯與 (AND)
            2'b11:   out = a ^ b;  // 位元邏輯互斥或 (XOR)
            default: out = 4'b0000;
        endcase
    end

endmodule