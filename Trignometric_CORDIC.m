clc; clear all; close all;

rad="Enter Radian Angle" ;

%%%first Code 
angle=rad*57.2958;  %input angle

ScalingFactor=0.6072;
x=1*ScalingFactor;   %input x
y=0;                 %input y

s=1;   %initialized sigma
k=0;



two_power=[1 0.5000 0.2500 0.1250 0.0625 0.0313 0.0156 0.0078 0.0039 0.0020 9.7656e-04 4.8828e-04 2.4414e-04];
inv_tan=[45 26.5651 14.0362 7.1250 3.5763 1.7899 0.8952 0.4476 0.2238 0.1119 0.0560 0.0280 0.0140];

if (angle<0)
   
    angle =-1*angle;
    k=2;
    
end


while (angle>360)
    
    angle=angle-360;
    
end


if (angle<=360&&angle>=0)   
    if (0<angle)&&(angle<90) % quadrant adjustment 
    z=angle;  %% desired angle 
    elseif (90<angle)&&(angle<180) 
    z=180-angle;  %% desired angle  
    elseif (180<angle)&&(angle<270)
    z=angle-180;  %% desired angle 
    elseif (270<angle)&&(angle<360)
    z=360-angle;  %% desired angle     
    elseif (angle==0)||(angle==90)||(angle==180)||(angle==270)||(angle==360)
    z=angle;
    k=1;
    end   % quadrant adjustment
end


for i=1:1:13

        if (k==1)
            i=14;
        end

        X=x-s*two_power(i)*y;
        Y=y+s*two_power(i)*x;
        Z=z-s*inv_tan(i);

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
    

    % quadrant adjustment
    if (0<angle)&&(angle<90)
    x=x;
    y=y;
    elseif (90<angle)&&(angle<180)
    x=-x;
    y=y;
    elseif (180<angle)&&(angle<270)
    x=-x;
    y=-y;
    elseif (270<angle)&&(angle<360)
    x=x;
    y=-y; 
    elseif (angle==0||angle==360)
    x=1;
    y=0;     
    elseif (angle==90)
    x=0;
    y=1;    
    elseif (angle==180)
    x=-1;
    y=0;    
    elseif (angle==270)
    x=0;
    y=-1;
    end
 
        
    
if (k==2)
    COS=x
    COS_angle=cosd(-angle)
    COS_rad=cos(-rad)
    
    SIN=-y
    SIN_angle=sind(-angle)
    SIN_rad=sin(-rad)

else
    COS=x
    COS_angle=cosd(angle)
    COS_rad=cos(rad)
    SIN=y
    SIN_angle=sind(angle)
    SIN_rad=sin(rad)

end

k=0;

