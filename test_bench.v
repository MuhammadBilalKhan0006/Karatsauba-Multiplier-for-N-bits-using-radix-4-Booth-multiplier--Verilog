module kara_tb();
parameter LOGQ       = 64; // bit-size of prime

    // Inputs
    reg [LOGQ-1:0] a;
    reg [LOGQ-1:0] b;
    reg clock;
    reg rst;
    // Outputs
    wire [2*LOGQ -1:0] p;
    // Variables

    // Instantiate the Unit Under Test (UUT)
      
     non_standard_dsp  uut (
        .out_c(p), 
        .in_a(a), 
        .in_b(b), 
        .clk(clock),
        .rst(rst)
    );
    
    
    
    // non_standard_dsp uut (
     //   .out_c(p), 
      //  .in_a(a), 
     //   .in_b(b), 
      //  .clk(clock),
      //  .rst(rst)
   // );
    

    initial clock = 0;
    always #5 clock = ~clock;

    initial
    begin
    #2
   rst = 1;
    #2
    rst = 0;
    #50
    a=3;
    b=3;
    #50
    a=2;
    b=2;
    #20
    a=6;
    b=6;
    #20
    a=7;
    b=7;
    #20
    a=8;
    b=8;
    #100
    a=10;
    b=500;
    #100
    a=4096;
    b=256;
    #100
    a=4096;
    b=4096;
    #100
    a=44250;
    b=40404;
    #100
    a = 64'b111111111111111111111111111111111111;
    b = 64'b11111111111111111111111111111111001111;
    #100
    a= 442504425;
    b= 1234567;
    #100
    a=64'd4339882981085161426 ;
    b=64'd3123572105583683402 ;
    #100
    a= 64'd1311768467463790320;
    b= 64'd18364758544493064720;
    #100
    a= 64'd232123456789012;
    b= 64'd23434456789012;
    #100
    a=64'd987653434234;
    b= 64'd12312312312312312;
    #100
    a=64'd4339882981085161426 ;
    b=64'd3123572105583683402 ;
    end      
endmodule
