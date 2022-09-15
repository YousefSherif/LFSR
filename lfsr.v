module lfsr #(parameter NO_OF_BITS = 4) (
  input  wire                  i_clk   ,
  input  wire                  i_rst_n ,
  input  wire [NO_OF_BITS-1:0] i_sead  ,
  output reg                   o_valid ,
  output reg                   o_out  );

reg [NO_OF_BITS-1:0] r_lfsr ;
reg [3:0] r_shift_xor_count ;
reg [2:0] r_shift_count     ;

wire feedback       ;
wire shift_xor_done ;
wire shift_done     ;

assign feedback       = ^r_lfsr[2:0]                           ;
assign shift_done     = (r_shift_count == 3'b100)      ? 1 : 0 ;
assign shift_xor_done = (r_shift_xor_count == 4'b1000) ? 1 : 0 ;

always@(posedge i_clk or negedge i_rst_n) begin
  if(!i_rst_n) begin
    r_lfsr  <= i_sead ;
    o_valid <= 1'b0   ;
    o_out   <= 1'b0   ;
  end
  else if(!shift_xor_done) begin
    r_lfsr  <= {feedback, r_lfsr[3:1]} ;
    o_valid <= 1'b0                    ;
    o_out   <= 1'b0                    ;
  end
  else if(shift_xor_done && !shift_done) begin
    {r_lfsr, o_out} <= {1'b0, r_lfsr} ;
    o_valid <= 1'b1                   ;
  end
  else begin
    o_valid <= 1'b0 ;
  end
end

always@(posedge i_clk or negedge i_rst_n) begin
  if(!i_rst_n) begin
    r_shift_xor_count  <= 4'b0 ;
  end
  else if(!shift_xor_done) begin
    r_shift_xor_count  <= r_shift_xor_count + 1'b1 ;
  end
end

always@(posedge i_clk or negedge i_rst_n) begin
  if(!i_rst_n) begin
    r_shift_count  <= 3'b0 ;
  end
  else if(shift_xor_done && !shift_done) begin
    r_shift_count  <= r_shift_count + 1'b1 ;
  end
end

endmodule
