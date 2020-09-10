clc; clear all; close all;

mm=-5;     %max negative range
nn=8;      %max positive range
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M=1;
for m=mm:1:0
    
  M=M*sqrt(1-(1-2^(m-2))^2);
    
end

N=1;
for n=1:1:nn
    
  N=N*sqrt(1-(2^(-2*n)));
    
end

A=M*N     %initial  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


M=0;
for m=mm:1:0
    
  M=M+atanh(1-2^(m-2));
    
end

N=0;
for n=1:1:nn
    
  N=N+atanh(2^(-n));
    
end

max_theta=M+N+atanh(2^(-nn))     %maximum theta




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
angle=6.9;    %input angle

if angle>0 %initialized sigma
    s=1;
else
    s=-1;
end


x=1/A   %5.4905;%4.8909;%  %input x   1/A
y=0                %input y


z=angle

for i=mm:1:0 
    
        X=x+s*(1-2^(i-2))*y;
        Y=y+s*(1-2^(i-2))*x;
        Z=z-s*atanh(1-2^(i-2)); %atanh(1-2^(-2^(-i+1)))

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
    


k=4
for i=1:1:nn
    
        X=x+s*(2^-i)*y;
        Y=y+s*(2^-i)*x;
        Z=z-s*atanh((2^-i));

        if (Z>0)
            S=1;
        else
            S=-1;
        end

        s=S;
        x=X;
        y=Y;
        z=Z;
        
        
        
        if i==k
            X=x+s*(2^-i)*y;
            Y=y+s*(2^-i)*x;
            Z=z-s*atanh((2^-i));
            
            if (Z>0)
                S=1;
            else
                S=-1;
            end

            s=S;
            x=X;
            y=Y;
            z=Z;  
            
            k=3*k+1 %% repetition index -- exclude last one
        end

        
end

       
COSH=x

COSH_angle=cosh(angle)

SINH=y

SINH_angle=sinh(angle)

 
EXP=x+y

EXP_angle=exp(angle)








