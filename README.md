# Hyperbolic_Exponential-CORDIC
Iterative discrete mathematical method to achieve an accurate hyperbolic and exponential output. This code was used in the paper titled ["Analysis and FPGA of semi-fractal shapes based on complex Gaussian map"](https://doi.org/10.1016/j.chaos.2020.110493) 

# Mathematical Concept(MATLAB)

The Hyperbolic/Exponential system is realized by using the CORDIC system achieving an iterative mathematical approximation given by [[1]](https://doi.org/10.1016/j.chaos.2020.110493) :

<img src="https://user-images.githubusercontent.com/44608585/105712967-3a355580-5f23-11eb-990c-2801856c35f0.png" width="200">

where A is the input angle, B is the cosine of the angle, C is the sine of the input angle. The index ζ is the iteration index and the variable ζ is either 1 or -1 depending on the value of  from the previous iteration where:

<img src="https://user-images.githubusercontent.com/44608585/105713342-b3cd4380-5f23-11eb-8788-6f1a3c931683.png" width="120">


The mathematical statement is realized in the architecture shown in Fig. 1, where the initial value for B amount to a scaling factor estimated to be B=0.6072 , the value of C and ζ are initialized at C=0 and ζ=1. As shown in Fig. 1 the index μ is bounded by a limit (μ≤a) defined as a comparator, where (a) is estimated optimally as (a=13) [[1]](https://doi.org/10.1016/j.chaos.2020.110493). 

<img src="https://user-images.githubusercontent.com/44608585/105723646-af0e8c80-5f2f-11eb-9a10-868e32c566e4.png" width="500">
Table.1 (Source: https://doi.org/10.1016/j.chaos.2020.110493)

## How to use
To use this function simply clone the function file 'Mathematical Concept(MATLAB).m', and run the matlab script. See the comments within this file for more details on how to experiment with the different variables in this function. 


    input: 	'rad' is the oinput angle in radian.

    out: 	'COS' cosine of the input angle.
         	'SIN' sine of the input angle.



# FPGA Hardware Architecture(VERILOG)

To optimize the architecture, the values of <img src="https://user-images.githubusercontent.com/44608585/105716962-348e3e80-5f28-11eb-9324-511173801623.png" width="80"> and <img src="https://user-images.githubusercontent.com/44608585/105719993-9308ec00-5f2b-11eb-9070-2a1c28cc0cc0.png" width="30"> are stated in LUTs as shown in Fig. 1, selected by the state of the μ index . Eventually, the final value of B and C should give the cosine and the sine of the given angle, respectively, after a number of iterations (μ = a). The values set for the designed architecture variables and their initial conditions are depicted in Table.1 . A comprehensive repository is realized with a software for the trigonometric CORDIC mathematical expression and hardware architecture [[1]](https://doi.org/10.1016/j.chaos.2020.110493).

<img src="https://ars.els-cdn.com/content/image/1-s2.0-S0960077920308857-gr6.jpg" width="400">
Fig.1 (Source: https://doi.org/10.1016/j.chaos.2020.110493)

## How to use
To use this function simply clone the file 'CORDIC_MAIN.v', and run the verilog script. Use the file 'CORDIC_TB.v' as a test bench to test an input angle and the output of the trignometric process. See the comments within this file for more details on how to experiment with the different variables in this function. 


    input: 	'rad' is the input angle in radian multiplied by 2^16  (32-bits = 16.16 = 16-bits for integer . 16-bits for fractional).

    out: 	'COS' cosine of the input angle (32-bits).
         	'SIN' sine of the input angle (32-bits).

