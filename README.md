# Hyperbolic_Exponential-CORDIC
Iterative discrete mathematical method to achieve an accurate hyperbolic and exponential output. This code was used in the paper titled ["Analysis and FPGA of semi-fractal shapes based on complex Gaussian map"](https://doi.org/10.1016/j.chaos.2020.110493) 

# Mathematical Concept(MATLAB)

The Hyperbolic/Exponential system is realized by using the CORDIC system achieving an iterative mathematical approximation given by [[1]](https://doi.org/10.1016/j.chaos.2020.110493) :

<img src="https://user-images.githubusercontent.com/44608585/105756767-b6489100-5f55-11eb-9595-8ab7e9d0b96f.png" width="200">

where the index λ is the iteration index for the previous set of equations, which increment from an out-most negative value λ = −b  at each iteration for λ < 0 till λ = 0 . After the stated set of equations are iterated for the index λ till λ = 0 , another set comes with an incremental iteration given by:

<img src="https://user-images.githubusercontent.com/44608585/105757706-fd835180-5f56-11eb-8b05-5a1085414752.png" width="200">








where K is the input angle, L is the coshine of the angle, M is the shine of the input angle. The index μ is the iteration index incremented at μ > 0 till μ = a and the variable ζ is either 1 or -1 depending on the value of K from the previous iteration, where the ζ condition is applied to both sets of equations in both ranges as:











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

