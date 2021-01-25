% clc; clear all; close all;

angle="Enter Angle";

if angle>0
    s=1;
else
    s=-1;
end


x= 1.9848e+03;   %input x
y=0;            %input y

        
two_power1=[0.9922 0.9844 0.9688 0.9375 0.8750 0.7500];   % (1-2^(i-2))         i=-5 >> 0
inv_tanh1=[2.7706 2.4221 2.0716 1.7170 1.3540 0.9730];    %  atanh(1-2^(i-2))   i=-5 >> 0

% 2^(-i)         i=1 >> 16
two_power=[0.5000 0.2500 0.1250 0.0625 0.0313 0.0156 0.0078 0.0039 0.0020 9.7656e-04 4.8828e-04 2.4414e-04 1.2207e-04 6.1035e-05 3.0518e-05 1.5259e-05];
% atanh((2^-i))  i=1 >> 16
inv_tanh=[0.5493  0.2554 0.1257 0.0626 0.0313 0.0156 0.0078 0.0039 0.0020 9.7656e-04 4.8828e-04 2.4414e-04 1.2207e-04 6.1035e-05 3.0518e-05 1.5259e-05];


z=angle;

for i=1:1:6 
    
        X=x+s*two_power1(i)*y;
        Y=y+s*two_power1(i)*x;
        Z=z-s*inv_tanh1(i);

            if (Z>0)
                S=1;
            else
                S=-1;
            end
    
            s=S;
        x=X;
        y=Y;
        z=Z;

end
    
for i=1:1:8
    
        X=x+s*two_power(i)*y;
        Y=y+s*two_power(i)*x;
        Z=z-s*inv_tanh(i);

        if (Z>0)
            S=1;
        else
            S=-1;
        end

        s=S;
        x=X;
        y=Y;
        z=Z;
        
        
        
        if i==4||i==13
            X=x+s*two_power(i)*y;
            Y=y+s*two_power(i)*x;
            Z=z-s*inv_tanh(i);

            if (Z>0)
                S=1;
            else
                S=-1;
            end

            s=S;
            x=X;
            y=Y;
            z=Z;  
        end

end

       
COSH=x

COSH_angle=cosh(angle)

SINH=y

SINH_angle=sinh(angle)


    
% if (angle<0)
%     EXP=x-y
% 
% 
% else
    EXP=x+y


% end

EXP_angle=exp(angle)



