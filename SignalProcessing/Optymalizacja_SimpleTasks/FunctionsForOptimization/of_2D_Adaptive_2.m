function [value] = of_2D_Adaptive2(x,y,TimePercent)
% A standard (gradual) change of objective function


% valx = 0.1*x.^2 + 2*sin(x) + 2.4*sin(4*x)+0.5*sin(9*x) + 1.9*sin(48*x) + 1.7*sin(70*x) +  1.2*sin(543*x);
% valy = 0.1*y.^2 + 2*sin(y) + 2.4*sin(4*y)+0.5*sin(9*y) + 1.9*sin(48*y) + 1.7*sin(70*y) +  1.2*sin(543*y);
% Function1 = valx + valy;
% Function2 = valx - valy;


Function1 = sin(0.3*x)+sin(0.028*(x+5)) - cos(0.5*(y+2))-cos(0.4*(y+5));
Function2 = -cos(0.3*x)-sin(x)*cos(0.29*(x+5)) - sin(x)*cos(0.9*(y+2))-cos(0.89*(y-7));

value = Function1*(1-TimePercent) + Function2*TimePercent;

% close all
% x = [-10:0.001:10];
% y = 0.1*x.^2 + 2*sin(x) + 1*sin(4*x)+0.5*sin(9*x) + 0.2*sin(48*x) + 0.07*sin(70*x) + + 0.03*sin(543*x);
% plot(x,y)


end

