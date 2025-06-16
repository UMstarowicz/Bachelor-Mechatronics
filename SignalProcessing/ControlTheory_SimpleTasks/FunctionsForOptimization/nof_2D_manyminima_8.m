function [value] = of_2D_manyminima_8(FV)
%2D_1 Summary of this function goes here
%   Detailed explanation goes here
x = FV(1);
y = FV(2);
x = (x-28.1)/42;

valx = 0.1*x.^2 + 2*sin(x) + 2.4*sin(4*x)+0.5*sin(9*x) + 1.9*sin(48*x) + 1.7*sin(70*x) +  1.2*sin(543*x);
valy = 0.1*y.^2 + 2*sin(y) + 2.4*sin(4*y)+0.5*sin(9*y) + 1.9*sin(48*y) + 1.7*sin(70*y) +  1.2*sin(543*y);
tempvalue1 = valx + valy;


Dist = sqrt((-2.7-x)^2+(-1-y)^2);
c1 =  1-(1/(39+exp(Dist/0.3))+(1/(40+exp(Dist/0.69))));
Dist = sqrt((6.1-x)^2+(-1.9-y)^2);
c2 =  1-(1/(39+exp(Dist/0.37))+(1/(40+exp(Dist/0.62))));
Dist = sqrt((-4-x)^2+(0.14-y)^2);
c3 =  1-(1/(39+exp(Dist/0.21))+(1/(40+exp(Dist/0.69))));
Dist = sqrt((-6-x)^2+(1-y)^2);
c4 =  1-(1/(39+exp(Dist/0.3))+(1/(40+exp(Dist/0.65))));
Dist = sqrt((-3.7-x)^2+(-7.2-y)^2);
c5 =  1-(1/(39+exp(Dist/0.15))+(1/(40+exp(Dist/0.38))));
Dist = sqrt((2.1-x)^2+(2.5-y)^2);
c6 =  1-(1/(39+exp(Dist/0.27))+(1/(40+exp(Dist/0.22))));
Dist = sqrt((-2.8-x)^2+(5-y)^2);
c8 =  1-(1/(39+exp(Dist/0.07))+(1/(40+exp(Dist/0.4))));

Dist = sqrt((-1.17-x)^2+(-5.13-y)^2);
c7 = (1-(1/(39+exp(Dist/2))+(1/(40+exp(Dist/3.1)))));

tempvalue = 0.1*(c1+c2+c3+c4+c5+c6+c8)+c7;

value = 17*tempvalue + 0.02*tempvalue1 +  0.3*sin(x*7)*sin(y*5);



% close all
% x = [-10:0.001:10];
% y = 0.1*x.^2 + 2*sin(x) + 1*sin(4*x)+0.5*sin(9*x) + 0.2*sin(48*x) + 0.07*sin(70*x) + + 0.03*sin(543*x);
% plot(x,y)


end

