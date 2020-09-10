`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:18:12 12/16/2019 
// Design Name: 
// Module Name:    CORDIC_MAIN 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module CORDIC_MAIN(clk,rst,angle,COSH,SINH,EXP);

input clk,rst;
output reg signed [31:0] COSH,SINH,EXP;
input signed  [31:0] angle;

reg signed  [31:0] ScalingFactor;

reg signed  [31:0] x,y,z,s,S; //16.16

reg signed  [63:0] op1,op2,op3,Z; //32.32

reg signed  [95:0] op11,op22,X,Y; //48.48

integer i;


wire signed [31:0] two_power [0:15]; //16.16

assign two_power[00] = 32768;//0.5000
assign two_power[01] = 16384;//0.2500
assign two_power[02] = 8192; //0.1250
assign two_power[03] = 4096; //0.0625
assign two_power[04] = 2051; //0.0313 
assign two_power[05] = 1022; //0.0156
assign two_power[06] = 511;  //0.0078
assign two_power[07] = 255;  //0.0039
assign two_power[08] = 131;  //0.0020
assign two_power[09] = 63;   //9.7656e-04
assign two_power[10] = 31;   //4.8828e-04
assign two_power[11] = 15;   //2.4414e-04
assign two_power[12] = 8;   //1.2207e-04
assign two_power[13] = 4;   //6.1035e-05
assign two_power[14] = 2;   //3.0518e-05
assign two_power[15] = 1;   //1.5259e-05


wire signed [31:0] two_power1 [0:5]; //16.16

assign two_power1[00] = 65025; //0.9922
assign two_power1[01] = 64514; //0.9844 
assign two_power1[02] = 63491; //0.9688
assign two_power1[03] = 61440;  //0.9375
assign two_power1[04] = 57344;  //0.8750
assign two_power1[05] = 49152;  //0.7500

wire signed [31:0] inv_tanh [0:15]; //16.16

assign inv_tanh[00] = 35999;		//	0.5493
assign inv_tanh[01] = 16738;		//	0.2554
assign inv_tanh[02] = 8238;		//	0.1257
assign inv_tanh[03] = 4103;		//	0.0626
assign inv_tanh[04] = 2052;		//	0.0313
assign inv_tanh[05] = 1023;		//	0.0156
assign inv_tanh[06] = 512;		//	0.0078
assign inv_tanh[07] = 256;		//	0.0039
assign inv_tanh[08] = 132;		//	0.002
assign inv_tanh[09] = 64;		//	9.77E-04
assign inv_tanh[10] = 32;		//	4.88E-04
assign inv_tanh[11] = 16;		//	2.44E-04
assign inv_tanh[12] = 8;		//	1.22E-04
assign inv_tanh[13] = 4;		//	6.10E-05
assign inv_tanh[14] = 3;		//	3.05E-05
assign inv_tanh[15] = 2;		//	1.53E-05


wire signed [31:0] inv_tanh1 [0:5]; //16.16

assign inv_tanh1[00]	= 181575;		//	2.7706
assign inv_tanh1[01]	= 158735;		//	2.4221
assign inv_tanh1[02]	= 135765;		//	2.0716
assign inv_tanh1[03]	= 112526;		//	1.717
assign inv_tanh1[04]	= 88736;		//	1.354
assign inv_tanh1[05]	= 63767;		//	0.973







//two_power1=[0.9990 0.9980 0.9961 0.9922 0.9844 0.9688 0.9375 0.8750 0.7500];
//inv_tanh1=[3.8121 3.4652 3.1182 2.7706 2.4221 2.0716 1.7170 1.3540 0.9730];
//
//two_power=[0.5000 0.2500 0.1250 0.0625 0.0313 0.0156 0.0078 0.0039 0.0020 9.7656e-04 4.8828e-04 2.4414e-04 1.2207e-04 6.1035e-05 3.0518e-05 1.5259e-05];
//inv_tanh=[0.5493  0.2554 0.1257 0.0626 0.0313 0.0156 0.0078 0.0039 0.0020 9.7656e-04 4.8828e-04 2.4414e-04 1.2207e-04 6.1035e-05 3.0518e-05 1.5259e-05];


always @(posedge clk ) begin  


if (rst==1)begin //initialization 1

ScalingFactor=130080000;//533720000000; // 1/(5.0000e-04)= 1.9848e+03; fix((8144000)*2^16);  30.2;


x=ScalingFactor;
y=0;               //input y

i=0;
s=65536;

end        //initialization 1

else begin //initialization 2

////////////////////////////////////////// initialized values for recursive clock

x=ScalingFactor;   //input x
y=0;               //input y
z=angle;
i=0;
//////////////////////////////////////////  initialized values for recursive clock


if (angle<0)begin //if 1
   
    s=-65536;
    
end // if 1

else begin

	 s=65536;
end


for (i=1;i<=6;i=i+1) begin //for1

		  op1=s*y;  //32.32
		  op11=op1*two_power1[i-1]; //48.48
        X={{32{x[31]}},x,{32{x[0]}}}+op11;   //48.48
		  
		  op2=s*x; //32.32
		  op22=op2*two_power1[i-1]; //48.48
        Y={{32{y[31]}},y,{32{y[0]}}}+op22;  //48.48
		  
		  op3=s*inv_tanh1[i-1]; //32.32
        Z={{16{z[31]}},z,{16{z[0]}}}-op3; //32.32

        if (Z>0)begin //if 5
            S=65536;
		  end //if 5
        else begin  //if 5.1
            S=-65536; 
        end //if 5.1

        s=S;
        x=X[63:32]; //16.16
        y=Y[63:32]; //16.16
        z=Z[47:16]; //16.16

end //for1
    



for (i=1;i<=8;i=i+1) begin //for2

		  op1=s*y;  //32.32
		  op11=op1*two_power[i-1]; //48.48
        X={{32{x[31]}},x,{32{x[0]}}}+op11;   //48.48
		  
		  op2=s*x; //32.32
		  op22=op2*two_power[i-1]; //48.48
        Y={{32{y[31]}},y,{32{y[0]}}}+op22;  //48.48
		  
		  op3=s*inv_tanh[i-1]; //32.32
        Z={{16{z[31]}},z,{16{z[0]}}}-op3; //32.32

        if (Z>0)begin //if 5
            S=65536;
		  end //if 5
        else begin  //if 5.1
            S=-65536; 
        end //if 5.1

        s=S;
        x=X[63:32]; //16.16
        y=Y[63:32]; //16.16
        z=Z[47:16]; //16.16
		  
		  
		  
		  if (i==4||i==13) begin  //if 6
		  
		  
			  op1=s*y;  //32.32
			  op11=op1*two_power[i-1]; //48.48
			  X={{32{x[31]}},x,{32{x[0]}}}+op11;   //48.48
			  
			  op2=s*x; //32.32
			  op22=op2*two_power[i-1]; //48.48
			  Y={{32{y[31]}},y,{32{y[0]}}}+op22;  //48.48
			  
			  op3=s*inv_tanh[i-1]; //32.32
			  Z={{16{z[31]}},z,{16{z[0]}}}-op3; //32.32

			  if (Z>0)begin //if 5
					S=65536;
			  end //if 5
			  else begin  //if 5.1
					S=-65536; 
			  end //if 5.1

			  s=S;
			  x=X[63:32]; //16.16
			  y=Y[63:32]; //16.16
			  z=Z[47:16]; //16.16
		  
		  
		  end  //if 6
		  
end //for2
 

COSH=x;
SINH=y;

EXP=x+y;



end //initialization 2


end //always

endmodule
