module DE2_115 (
	input CLOCK_50,
	input CLOCK2_50,
	input CLOCK3_50,
	input ENETCLK_25,
	input SMA_CLKIN,
	output SMA_CLKOUT,
	output [8:0] LEDG,
	output [17:0] LEDR,
	input [3:0] KEY,
	input [17:0] SW,
	output [6:0] HEX0,
	output [6:0] HEX1,
	output [6:0] HEX2,
	output [6:0] HEX3,
	output [6:0] HEX4,
	output [6:0] HEX5,
	output [6:0] HEX6,
	output [6:0] HEX7,
	output LCD_BLON,
	inout [7:0] LCD_DATA,
	output LCD_EN,
	output LCD_ON,
	output LCD_RS,
	output LCD_RW,
	output UART_CTS,
	input UART_RTS,
	input UART_RXD,
	output UART_TXD,
	inout PS2_CLK,
	inout PS2_DAT,
	inout PS2_CLK2,
	inout PS2_DAT2,
	output SD_CLK,
	inout SD_CMD,
	inout [3:0] SD_DAT,
	input SD_WP_N,
	output [7:0] VGA_B,
	output VGA_BLANK_N,
	output VGA_CLK,
	output [7:0] VGA_G,
	output VGA_HS,
	output [7:0] VGA_R,
	output VGA_SYNC_N,
	output VGA_VS,
	input AUD_ADCDAT,
	inout AUD_ADCLRCK,
	inout AUD_BCLK,
	output AUD_DACDAT,
	inout AUD_DACLRCK,
	output AUD_XCK,
	output EEP_I2C_SCLK,
	inout EEP_I2C_SDAT,
	output I2C_SCLK,
	inout I2C_SDAT,
	output ENET0_GTX_CLK,
	input ENET0_INT_N,
	output ENET0_MDC,
	input ENET0_MDIO,
	output ENET0_RST_N,
	input ENET0_RX_CLK,
	input ENET0_RX_COL,
	input ENET0_RX_CRS,
	input [3:0] ENET0_RX_DATA,
	input ENET0_RX_DV,
	input ENET0_RX_ER,
	input ENET0_TX_CLK,
	output [3:0] ENET0_TX_DATA,
	output ENET0_TX_EN,
	output ENET0_TX_ER,
	input ENET0_LINK100,
	output ENET1_GTX_CLK,
	input ENET1_INT_N,
	output ENET1_MDC,
	input ENET1_MDIO,
	output ENET1_RST_N,
	input ENET1_RX_CLK,
	input ENET1_RX_COL,
	input ENET1_RX_CRS,
	input [3:0] ENET1_RX_DATA,
	input ENET1_RX_DV,
	input ENET1_RX_ER,
	input ENET1_TX_CLK,
	output [3:0] ENET1_TX_DATA,
	output ENET1_TX_EN,
	output ENET1_TX_ER,
	input ENET1_LINK100,
	input TD_CLK27,
	input [7:0] TD_DATA,
	input TD_HS,
	output TD_RESET_N,
	input TD_VS,
	inout [15:0] OTG_DATA,
	output [1:0] OTG_ADDR,
	output OTG_CS_N,
	output OTG_WR_N,
	output OTG_RD_N,
	input OTG_INT,
	output OTG_RST_N,
	input IRDA_RXD,
	output [12:0] DRAM_ADDR,
	output [1:0] DRAM_BA,
	output DRAM_CAS_N,
	output DRAM_CKE,
	output DRAM_CLK,
	output DRAM_CS_N,
	inout [31:0] DRAM_DQ,
	output [3:0] DRAM_DQM,
	output DRAM_RAS_N,
	output DRAM_WE_N,
	output [19:0] SRAM_ADDR,
	output SRAM_CE_N,
	inout [15:0] SRAM_DQ,
	output SRAM_LB_N,
	output SRAM_OE_N,
	output SRAM_UB_N,
	output SRAM_WE_N,
	output [22:0] FL_ADDR,
	output FL_CE_N,
	inout [7:0] FL_DQ,
	output FL_OE_N,
	output FL_RST_N,
	input FL_RY,
	output FL_WE_N,
	output FL_WP_N,
	inout [35:0] GPIO,
	input HSMC_CLKIN_P1,
	input HSMC_CLKIN_P2,
	input HSMC_CLKIN0,
	output HSMC_CLKOUT_P1,
	output HSMC_CLKOUT_P2,
	output HSMC_CLKOUT0,
	inout [3:0] HSMC_D,
	input [16:0] HSMC_RX_D_P,
	output [16:0] HSMC_TX_D_P,
	inout [6:0] EX_IO


);

logic key0down, key1down, key2down, key3down;
logic CLK_25_2M;
assign VGA_CLK = CLOCK_50;
logic [3:0] test;


logic		    [11:0]		D5M_D;
logic		          		D5M_FVAL;
logic		          		D5M_LVAL;
logic		          		D5M_PIXLCLK;
wire		          		D5M_RESET_N;
wire		          		D5M_SCLK;
wire		          		D5M_SDAT;
logic		          		D5M_STROBE;
output		          		D5M_TRIGGER;
output		          		D5M_XCLKIN;


assign D5M_D = {GPIO[1], GPIO[3:13]};
assign D5M_FVAL = GPIO[22];
assign D5M_LVAL = GPIO[21];
assign D5M_PIXLCLK = GPIO[0];
assign D5M_RESET_N = GPIO[17]
assign GPIO[24] = D5M_SCLK;
assign GPIO[23] = D5M_SDAT;
assign D5M_STROBE = GPIO[20];
assign GPIO[22] = D5M_TRIGGER;
assign GPIO[16] = D5M_XCLKIN;

/*
assign D5M_D[10] = GPIO[3]
assign D5M_D[9] = GPIO[4]
assign D5M_D[8] = GPIO[5]
assign D5M_D[7] = GPIO[6]
assign D5M_D[6] = GPIO[7]
assign D5M_D[5] = GPIO[8]
assign D5M_D[4] = GPIO[9]
assign D5M_D[3] = GPIO[10]
assign D5M_D[2] = GPIO[11]
assign D5M_D[1] = GPIO[12]
assign D5M_D[0] = GPIO[13]
*/


VGAtest vga_qsys( // generate with qsys, please follow lab2 tutorials
	.clk_clk(CLOCK_50),
	.reset_reset_n(key3down),
	.altpll_25_175m_clk(CLK_25_2M)
);

// you can decide key down settings on your own, below is just an example
Debounce deb0(
	.i_in(KEY[0]), 
	.i_rst_n(KEY[3]),
	.i_clk(CLK_25_2M),
	.o_neg(key0down) 
);

Debounce deb1(
	.i_in(KEY[1]), 
	.i_rst_n(KEY[3]),
	.i_clk(CLK_25_2M),
	.o_neg(key1down) 
);

Debounce deb2(
	.i_in(KEY[2]), 
	.i_rst_n(KEY[3]),
	.i_clk(CLK_25_2M),
	.o_neg(key2down) 
);

logic sdram_we, sdram_rd;
logic [15:0] sdram_wr_data1, sdram_wr_data2, sdram_rd_data1, sdram_rd_data2;


wire dly_rst_n0, dly_rst_n1, dly_rst_n2, dly_rst_n3, dly_rst_n4;
Reset_Delay reset_delay(
	.i_clk(CLOCK_50),
	.i_rst_n(KEY[3]),
	.o_rst_n0(dly_rst_n0), // sdram ctrl
	.o_rst_n1(dly_rst_n1),
	.o_rst_n2(dly_rst_n2),
	.o_rst_n3(dly_rst_n3),
	.o_rst_n4(dly_rst_n4)
);
assign sdram_we = 1'b1;
assign sdram_rd = 1'b1;

Sdram_Control	sdram_ctrl(	//	HOST Side						
						    .RESET_N(key3down),
							.CLK(sdram_ctrl_clk),

							//	FIFO Write Side 1
							//.WR1_DATA(sdram_wr_data1),
							.WR1_DATA(16'hDEAD),
							.WR1(sdram_we),
							.WR1_ADDR(0),
						    .WR1_MAX_ADDR(23'h0FFFFF), //
						    .WR1_LENGTH(8'h100),
							.WR1_LOAD(!dly_rst_n0),
							.WR1_CLK(CLOCK_50), //TODO: why clock2_50

							//	FIFO Write Side 2
							.WR2_DATA(sdram_wr_data2),
							.WR2(0),
							.WR2_ADDR(23'h100000),
						    .WR2_MAX_ADDR(23'h100000+640*480/2),
							.WR2_LENGTH(8'h50),
							.WR2_LOAD(!dly_rst_n0),
							.WR2_CLK(CLOCK_50),

							//	FIFO Read Side 1
						    .RD1_DATA(sdram_rd_data1),
				        	.RD1(sdram_rd),
				        	.RD1_ADDR(0),
						    .RD1_MAX_ADDR(23'h0FFFFF),
							.RD1_LENGTH(8'h50),
							.RD1_LOAD(!dly_rst_n0),
							.RD1_CLK(CLOCK_50),
							
							//	FIFO Read Side 2
						    .RD2_DATA(Read_DATA2),
							.RD2(0),
							.RD2_ADDR(23'h100000),
						    .RD2_MAX_ADDR(23'h100000+640*480/2),
							.RD2_LENGTH(8'h50),
				        	.RD2_LOAD(!dly_rst_n0),
							.RD2_CLK(CLOCK_50),
							
							//	SDRAM Side
						    .SA(DRAM_ADDR),
							.BA(DRAM_BA),
							.CS_N(DRAM_CS_N),
							.CKE(DRAM_CKE),
							.RAS_N(DRAM_RAS_N),
							.CAS_N(DRAM_CAS_N),
							.WE_N(DRAM_WE_N),
							.DQ(DRAM_DQ),
							.DQM(DRAM_DQM)
);
/*
testVGA top0(
	.i_clk(CLK_25_2M),
	.i_rst_n(KEY[3]),
	
	.i_key_0(key0down),
	.i_key_1(key1down),
	.i_key_2(key2down),

	.i_VGA_CLK(CLOCK_50),
	.o_VGA_R(VGA_R),
	.o_VGA_G(VGA_G),
	.o_VGA_B(VGA_B),
	.o_VGA_BLANK_N(VGA_BLANK_N),
	.o_VGA_SYNC_N(VGA_SYNC_N),

	.o_VGA_HS(VGA_HS),
	.o_VGA_VS(VGA_VS),
	.test(test),
);
*/
/*
SevenHexDecoder seven_dec0(
	.i_hex(test),
	.o_seven_ten(HEX3),
	.o_seven_one(HEX2)
);

SevenHexDecoder seven_dec1(
	.i_hex(sdram_rd_data1[4:0]),
	.o_seven_ten(HEX1),
 	.o_seven_one(HEX0)
);
*/
SEG7_LUT seven_dec0(
	.iDIG(sdram_rd_data1[3:0]), 
	.oSEG(HEX0)
);
SEG7_LUT seven_dec1(
	.iDIG(sdram_rd_data1[7:4]), 
	.oSEG(HEX1)
);
SEG7_LUT seven_dec2(
	.iDIG(sdram_rd_data1[11:8]), 
	.oSEG(HEX2)
);
SEG7_LUT seven_dec3(
	.iDIG(sdram_rd_data1[15:12]), 
	.oSEG(HEX3)
);

// comment those are use for display
//assign HEX0 = 7'b111_1111;
//assign HEX1 = 7'b111_1111;
// assign HEX2 = '1;
// assign HEX3 = '1;
assign HEX4 = 7'b111_1111;
assign HEX5 = 7'b111_1111;
assign HEX6 = 7'b111_1111;
assign HEX7 = 7'b111_1111;

endmodule
