
`timescale 1ns/100ps

module tb_Game;
	localparam CLK = 10;
	localparam HCLK = CLK/2;

	logic clk, rst_n, start;
    logic [10:0] left [1:0];
    logic [10:0] right [1:0];
    logic [10:0] up [1:0];
    logic [10:0] down [1:0];

	initial clk = 0;
	always #HCLK clk = ~clk;
    GameLogic DUT(
        .i_clk(clk),
        .i_rst_n(rst_n),
        .predict_valid(1),
        .start(1),
        .enter_game(1),
        .ThisFrameEnd(1),
        .left(left),
        .right(right),
        .up(up),
        .down(down),
        .x(),
        .y(),
        .i_rgb(),
        .o_rgb()
        // [10:0] left  [1:0],
        // [10:0] right [1:0],
        // [10:0] up    [1:0],
        // [10:0] down  [1:0],
        // [10:0] x,
        // [10:0] y,
        // [7:0] i_rgb [2:0],
        // [7:0] o_rgb [2:0]
    );

	initial begin
		$fsdbDumpfile("Game.fsdb");
		$fsdbDumpvars(0, "+all");
		
		rst_n = 1;
		#(2*CLK)
		rst_n = 0;
		#(2*CLK)
        left[0] = 11'd100;
        left[1] = 11'd100;
        right[0] = 11'd100;
        right[1] = 11'd100;
        up[0] = 11'd100;
        up[1] = 11'd100;
        down[0] = 11'd100;
        down[1] = 11'd100;

		rst_n = 1;
        #(10*CLK)
        start = 1;
        #(1*CLK)
        start = 0;
		#(900000*CLK)
		$finish;
		
	end

endmodule
