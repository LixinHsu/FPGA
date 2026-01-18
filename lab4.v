module lab4(Dout, Din, clk, reset);

// 修改為 13 個係數
parameter b0=7, b1=17, b2=32, b3=46, b4=52, b5=61, b6=73, b7=61, b8=52, b9=46, b10=32, b11=17, b12=7;

output	[17:0]	Dout;
input 	[7:0] 	Din;
input 		clk, reset;

//--------------------------------------
//Dataflow or Behavioral
//Combination logic 

// 修改暫存器宣告 (r0 ~ r11)
reg [7:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11;

always @(posedge clk) begin
    if (!reset) begin
        r0 <= 0; r1 <= 0; r2 <= 0; r3 <= 0; r4 <= 0; r5 <= 0; 
        r6 <= 0; r7 <= 0; r8 <= 0; r9 <= 0; r10 <= 0; r11 <= 0;
    end else begin
        r0  <= Din;
        r1  <= r0;
        r2  <= r1;
        r3  <= r2;
        r4  <= r3;
        r5  <= r4;
        r6  <= r5;
        r7  <= r6;
        r8  <= r7;
        r9  <= r8;
        r10 <= r9;
        r11 <= r10;
    end
end

// 組合邏輯運算
// 確保輸出位元寬度足夠 (18-bit 應該仍足夠，若怕溢位可改為 20-bit)
assign Dout = (Din * b0) + (r0 * b1) + (r1 * b2) + (r2 * b3) + 
              (r3 * b4) + (r4 * b5) + (r5 * b6) + (r6 * b7) + 
              (r7 * b8) + (r8 * b9) + (r9 * b10) + (r10 * b11) + (r11 * b12);

endmodule

