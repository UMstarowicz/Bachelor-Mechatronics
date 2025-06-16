function [value] = of_2D_fewminima_3(FV)
%2D_1 Summary of this function goes here
%   Detailed explanation goes here
x = FV(1);
y = FV(2);

Dist = sqrt((0.17-y)^2+(-0.32-x)^2);
m1 =  1-(1/(39+exp(Dist/0.4))+(1/(40+exp(Dist/0.6))));

Dist = sqrt((7-y)^2+(8-x)^2);
c1 =  1-(1/(39+exp(Dist/0.4))+(1/(40+exp(Dist/0.6))));

Dist = sqrt((0.1-y)^2+(-8-x)^2);
c2 =  1-(1/(39+exp(Dist/0.4))+(1/(40+exp(Dist/0.6))));


Dist = sqrt((-7-y)^2+(0.1-x)^2);
c3 =  1-(1/(39+exp(Dist/0.4))+(1/(40+exp(Dist/0.6))));

Dist = sqrt((-3.9-x)^2+(5.6-y)^2);
c4 =  1-(1/(39+exp(Dist/0.4))+(1/(40+exp(Dist/0.6))));
Dist = sqrt((-4.9-x)^2+(-5.9-y)^2);
c5 =  1-(1/(39+exp(Dist/0.4))+(1/(40+exp(Dist/0.6))));
Dist = sqrt((-1.1-y)^2+(7.6-x)^2);
c6 =  1-(1/(39+exp(Dist/0.4))+(1/(40+exp(Dist/0.6))));


value = 4*c1+3*c2+2*c4+4*c5 + 0.001*x^2+0.001*y^2 - 12 ;%+ m2 + m3 + m4;


end

