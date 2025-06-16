function [value] = of_2D_manyminima_6(FV)
%2D_1 Summary of this function goes here
%   Detailed explanation goes here
x = FV(1);
y = FV(2);
valx = 0.2*x.^2 + 2*sin(x) + 2*sin(4*x)+0.63*sin(9*x) + 0.4*sin(48*x) + 0.17*sin(70*x) + 0.04*sin(543*x);
valy = 0.3*y.^2 + 4.5*sin(y) + 3*sin(4*y)+0.59*sin(9*y) + 0.45*sin(48*y) + 0.17*sin(70*y) + 0.12*sin(543*y);
c = valx + valy;

m1 = -2/(0.3+(sqrt(2*(x-0.1)^2 + 2*(y-5)^2)));
m2 = -1/(1+(sqrt(1*(x+4.1)^2 + 1*(y+1.3)^2)));
m3 = -1/(1+(sqrt(1*(x-4.6)^2 + 1*(y+7.2)^2)));
m4 = -1/(1+(sqrt(1*(x-1.6)^2 + 1*(y-3.7)^2)));


value = 0.05*c + m1 + m2 + m3 + m4;

value = value + 8;
% close all
% x = [-10:0.001:10];
% y = 0.1*x.^2 + 2*sin(x) + 1*sin(4*x)+0.5*sin(9*x) + 0.2*sin(48*x) + 0.07*sin(70*x) + + 0.03*sin(543*x);
% plot(x,y)


end

