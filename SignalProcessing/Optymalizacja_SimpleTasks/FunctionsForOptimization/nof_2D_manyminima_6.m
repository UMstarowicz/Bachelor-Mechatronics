function [value] = of_2D_manyminima_0(FV)
%2D_1 Summary of this function goes here
%   Detailed explanation goes here
x = FV(1);
y = FV(2);
valx = 0.1*x.^2 + 2*sin(x) + 2.4*sin(4*x)+0.5*sin(9*x) + 1.9*sin(48*x) + 1.7*sin(36*x) +  1.2*sin(32*x);
valy = 0.1*y.^2 + 2*sin(y) + 2.4*sin(4*y)+0.5*sin(9*y) + 1.9*sin(44*y) + 1.7*sin(78*y) +  1.2*sin(58*y);
x = x+0.4213;
y = y-1.2315;
valx = valx + 0.1*x.^2 + 2*sin(x) + 2.4*sin(4*x)+0.5*sin(9*x) + 1.9*sin(73*x) + 1.7*sin(34*x) +  1.2*sin(23*x);
valy = valy + 0.1*y.^2 + 2*sin(y) + 2.4*sin(4*y)+0.5*sin(9*y) + 1.9*sin(35*y) + 1.7*sin(56*y) +  1.2*sin(24*y);
tempvalue = valx + valy;


Dist = sqrt((-4-x)^2+(-9-y)^2);
c1 =  1-(1/(39+exp(Dist/0.4))+(1/(40+exp(Dist/0.6))));
Dist = sqrt((3.1-x)^2+(-2-y)^2);
c2 =  1-(1/(39+exp(Dist/0.4))+(1/(40+exp(Dist/0.6))));
Dist = sqrt((-4-x)^2+(0.14-y)^2);
c3 =  1-(1/(39+exp(Dist/0.4))+(1/(40+exp(Dist/0.6))));
Dist = sqrt((-9-x)^2+(6-y)^2);
c4 =  1-(1/(39+exp(Dist/0.4))+(1/(40+exp(Dist/0.6))));
Dist = sqrt((-5.7-x)^2+(3.2-y)^2);
c5 =  1-(1/(39+exp(Dist/0.4))+(1/(40+exp(Dist/0.6))));
Dist = sqrt((6.6-x)^2+(8.5-y)^2);
c6 =  1-(1/(39+exp(Dist/0.4))+(1/(40+exp(Dist/0.6))));
Dist = sqrt((-7.8-x)^2+(-2-y)^2);
c8 =  1-(1/(39+exp(Dist/0.4))+(1/(40+exp(Dist/0.6))));

Dist = sqrt((-1.17-x)^2+(0.63-y)^2);
c7 = (1-(1/(39+exp(Dist/4))+(1/(40+exp(Dist/5)))));

tempvalue = 0.2*(c1+c2+c3+c4+c5+c6+c8)+c7;


value = tempvalue + 0.001*sin(x*3) + 0.0012*sin(y*2.4) +  0.0005*sin(x*17)*sin(y*14);



% close all
% x = [-10:0.001:10];
% y = 0.1*x.^2 + 2*sin(x) + 1*sin(4*x)+0.5*sin(9*x) + 0.2*sin(48*x) + 0.07*sin(70*x) + + 0.03*sin(543*x);
% plot(x,y)


end

