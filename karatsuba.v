`timescale 1ns / 1ps
module karatsaub 
#(
    parameter LOGQ       = 64,
    parameter IS_Q_FIXED = 0,
    parameter Q          = 64'd18446744069414584321,
    parameter DELAY_ADD  = 2,  // 1 or 2
    parameter DELAY_SUB  = 2,  // 1 or 2
    parameter DELAY_MUL  = 2, 
    parameter DELAY_RED  = 3,
    parameter DELAY_BRAM = 1, // 1 or 2
    parameter DELAY_BROM = 1, // 1 or 2
    parameter DELAY_FIFO = 1  // 1 or 2 */
)(
    input                 clk,
    input                 rst,
    input  [LOGQ/2-1:0]     in_a,
    input  [LOGQ/2-1:0]     in_b,
    output reg [(LOGQ)-1:0] out_c
);
reg [(LOGQ)-1:0] z1,inter4;
 reg [LOGQ/4:0] x1, x0, y1, y0;

   always @(posedge clk or posedge rst) begin
        if (rst) begin 
            x0 <= 0;
            x1 <= 0;
            y0 <= 0;
            y1 <= 0;
        end else begin
            x0 <= in_a[(LOGQ/4)-1:0];
            x1 <= in_a[(LOGQ/2)-1:(LOGQ/4)];
            y0 <= in_b[(LOGQ/4)-1:0];
            y1 <= in_b[(LOGQ/2)-1:(LOGQ/4)];
        end
    end 
  
    
    // Logic for combining outputs
    wire [LOGQ/2 : 0] z0_wire,z2_wire,z3_wire;
   
    MBA #(.LOGQ(LOGQ)) inst1 (.clk(clk),.rst(rst),.in_a(x0),.in_b(y0),.out_c(z0_wire));
    MBA #(.LOGQ(LOGQ)) inst2 (.clk(clk),.rst(rst),.in_a(x1),.in_b(y1),.out_c(z2_wire));
    MBA #(.LOGQ(LOGQ)) inst3 (.clk(clk),.rst(rst),.in_a(x0+x1),.in_b(y0+y1),.out_c(z3_wire));
     // 1st
    /*always @ (posedge clk or posedge rst) begin 
    if(rst) begin
    z0 <= 0;
    end else begin
    z0 <= z0_wire;
    end
    end
    // 2nd
    always @( posedge clk or posedge rst) begin
    if(rst) begin
    z2  <=  0;
    end
        else begin
    z2 <= z2_wire;
    end
   end */ 
   //3rd
  /* always @ (posedge clk or posedge rst) begin
   if (rst) begin
   sum_1 <= 0 ;
   end
        else begin
    sum_1 <= x0+x1;
    
   end
 end
 // 4th
 always @ (posedge clk or posedge rst) begin
   if (rst) begin
   sum_2 <= 0 ;
   end
        else begin
    sum_2 <= y0+y1;
    
   end
 end*/
 // 5th
 /*  always @( posedge clk or posedge rst) begin
    if(rst) begin
    mul_after_sum  <=  0;
    end
        else begin
    mul_after_sum <=z3_wire ;
    end
   end */
   //6th
  /* always @( posedge clk or posedge rst) begin
    if(rst) begin
    inter4  <=  0;
    end
        else begin
    inter4 <=-(z2_wire +  z0_wire) ;
    end
   end 
   //7th
 always @( posedge clk or posedge rst) begin
    if(rst) begin
    z1  <=  0;
    end
        else begin
    z1 <=z3_wire + inter4;
    end
   end */
   //8th
 always @( posedge clk or posedge rst) begin
    if(rst) begin
    inter4  <=  0;
    z1 <= 0 ;
    end
        else begin
        //sum_1 = x0+x1;
       // sum_2 = y0+y1;
        inter4 <= -(z2_wire +  z0_wire) ;
         z1 <= z3_wire + inter4;
   
    end
   end 
    always @( posedge clk or posedge rst) begin
    if(rst) begin
    
     out_c <= 0 ;
    
    end
    else begin
     out_c <= (z2_wire << LOGQ/2) + (z1 << (LOGQ/4)) + z0_wire;
    end
  end
   
      
   /* always @ ( posedge clk) begin
    if (rst ) begin
    out_c <= 0 ;
    end 
        else begin
        inter1 = x0 + x1;
        inter2 = y1 + y0;
        z0   = x0 * y0;
         z2 = x1 * y1;
         inter3 = inter1 * inter2;
          inter4 = -(z2+z0);
          z1 = inter3+inter4;
          out_c = (z2 << LOGQ) + (z1 << (LOGQ/2)) + z0;
   end
   end*/
 endmodule
