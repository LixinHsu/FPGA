module lab1 (a, b, cout, s);

	input [3:0] a,b;
	output [3:0] s;
	output      cout;
	
	wire [3:0] c;
	
	HA tha0(.a(a[0]), .b(b[0]), .cout(c[0]), .sum(s[0]));
	FA tha1(.a(a[1]), .b(b[1]), .c(c[0]), .cout(c[1]), .sum(s[1]));
	FA tha2(.a(a[2]), .b(b[2]), .c(c[1]), .cout(c[2]), .sum(s[2]));
	FA tha3(.a(a[3]), .b(b[3]), .c(c[2]), .cout(c[3]), .sum(s[3]));
	
	assign cout = c[3];
	
endmodule

module FA(a, b, c, cout, sum);
	input a, b, c;
	output cout, sum;
	
	wire ab;
	
	assign ab = (a^b);
	assign sum = (ab)^c;
	assign cout = ((ab)&c) | (a&b);
	
endmodule

module HA(a, b, cout, sum);

	input a, b;
	output cout, sum;
	
	assign sum = a^b;
	assign cout = a&b;
	
endmodule