# Hyperbolic_Exponential-CORDIC
Iterative discrete mathematical method to achieve an accurate hyperbolic and exponential output. This code was used in the paper titled ["Analysis and FPGA of semi-fractal shapes based on complex Gaussian map"](https://doi.org/10.1016/j.chaos.2020.110493) 

# Mathematical Concept(MATLAB)

The Hyperbolic/Exponential system is realized by using the CORDIC system achieving an iterative mathematical approximation given by [[1]](https://doi.org/10.1016/j.chaos.2020.110493) :

<img src="https://user-images.githubusercontent.com/44608585/105756767-b6489100-5f55-11eb-9595-8ab7e9d0b96f.png" width="220">

where the index λ is the iteration index for the previous set of equations, which increment from an out-most negative value λ = −b  at each iteration for λ < 0 till λ = 0 . After the stated set of equations are iterated for the index λ till λ = 0 , another set comes with an incremental iteration given by:

<img src="https://user-images.githubusercontent.com/44608585/105757706-fd835180-5f56-11eb-8b05-5a1085414752.png" width="200">

where K is the input angle, L is the coshine of the angle, M is the shine of the input angle. The index μ is the iteration index incremented at μ > 0 till μ = a and the variable ζ is either 1 or -1 depending on the value of K from the previous iteration, where the ζ condition is applied to both sets of equations in both ranges as:

<img src="https://user-images.githubusercontent.com/44608585/105759062-a8483f80-5f58-11eb-89c2-f7e9f964fee6.png" width="120">

The previous mathematical statement is realized in the architecture shown in Fig. 7 , where the value of M and ζ are initialized at M = 0 and ζ = 1 . The initial value for L is stated to be L =  1/Λ where:

<img src="https://user-images.githubusercontent.com/44608585/105760691-d75fb080-5f5a-11eb-919c-0a080517034b.png" width="300">

Consequently ranges of μ and λ given as ( a ) and ( b) respectively instate the value of the initial condition L 0 =  1 , giving a proper range for the maximum angle  max to be applied without losing needed accuracy as:

<img src="https://user-images.githubusercontent.com/44608585/105760967-27d70e00-5f5b-11eb-8b02-f6f03e77b184.png" width="400">

where lowering the maximum angle  max limit will decrease the iteration period of the CORDIC system and in turn decrease the complexity of the whole system.









<img src="https://user-images.githubusercontent.com/44608585/105723646-af0e8c80-5f2f-11eb-9a10-868e32c566e4.png" width="500">
Table.1 (Source: https://doi.org/10.1016/j.chaos.2020.110493)

## How to use
To use this function simply clone the function file 'Mathematical Concept(MATLAB).m', and run the matlab script. See the comments within this file for more details on how to experiment with the different variables in this function. 


    input: 	'rad' is the oinput angle in radian.

    out: 	'COS' cosine of the input angle.
         	'SIN' sine of the input angle.



# FPGA Hardware Architecture(VERILOG)

As depicted in Fig. 1 to optimize the architecture, the values of tanh− 1 (1 −2 λn −2 ) and 1 −2 n −2 are stated in LUTs accessed by the index λ, which constitutes the ﬁrst iteration period. Then the values of tan −1 (2 −μn ) and 2 − n stated in the LUTs shown in Fig. 1 are selected by the state of the index μ, which represent the second iteration period. As shown in Fig. 1 both the index λ and μ are bounded by a limit λ ≤ b and μ ≤ a deﬁned as comparators, where ( b) and ( a ) are calculated as ( b = 6 ) and ( a = 8 ). After a number of iterations ( λ = b) then ( μ = a ) amounting to a total of (a + b) iterations, the ﬁnal value of L n +1 and M n +1 should give the coshine and the shine of the given angle respectively. Eventually, The exponential value needed is calculated by adding the values of the coshine L n +1 and the shine M n +1 outputs. The values set for the designed CORDIC architecture variables and their initial conditions are shown in Table 1 .  [[1]](https://doi.org/10.1016/j.chaos.2020.110493).

<img src="https://ars.els-cdn.com/content/image/1-s2.0-S0960077920308857-gr7.jpg" width="400">
Fig.1 (Source: https://doi.org/10.1016/j.chaos.2020.110493)

## How to use
To use this function simply clone the file 'CORDIC_MAIN.v', and run the verilog script. Use the file 'CORDIC_TB.v' as a test bench to test an input angle and the output of the trignometric process. See the comments within this file for more details on how to experiment with the different variables in this function. 


    input: 	'rad' is the input angle in radian multiplied by 2^16  (32-bits = 16.16 = 16-bits for integer . 16-bits for fractional).

    out: 	'COS' cosine of the input angle (32-bits).
         	'SIN' sine of the input angle (32-bits).

