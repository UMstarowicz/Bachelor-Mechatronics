function [value] = of_2D_manyminima_2(FV)
%2D_1 Summary of this function goes here
%   Detailed explanation goes here
x = FV(1);
y = FV(2);
valx = 0.1*x.^2 + 2*sin(x) + 2.4*sin(4*x)+0.5*sin(9*x) + 1.9*sin(48*x) + 1.7*sin(70*x) +  1.2*sin(543*x);
valy = 0.1*y.^2 + 2*sin(y) + 2.4*sin(4*y)+0.5*sin(9*y) + 1.9*sin(48*y) + 1.7*sin(70*y) +  1.2*sin(543*y);
tempvalue = valx + valy;

value = tempvalue + 0.2*x.^2 + 0.2*y.^2 + 10*sin(x*0.2)*sin(y*0.4);



% close all
% x = [-10:0.001:10];
% y = 0.1*x.^2 + 2*sin(x) + 1*sin(4*x)+0.5*sin(9*x) + 0.2*sin(48*x) + 0.07*sin(70*x) + + 0.03*sin(543*x);
% plot(x,y)


end

