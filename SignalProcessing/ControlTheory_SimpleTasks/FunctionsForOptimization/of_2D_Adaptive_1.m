function [value] = of_2D_Adaptive1(x,y,TimePercent)
% A switching function - environment does not change gradually but switches
% from one state to another.



% valx = 0.1*x.^2 + 2*sin(x) + 2.4*sin(4*x)+0.5*sin(9*x) + 1.9*sin(48*x) + 1.7*sin(70*x) +  1.2*sin(543*x);
% valy = 0.1*y.^2 + 2*sin(y) + 2.4*sin(4*y)+0.5*sin(9*y) + 1.9*sin(48*y) + 1.7*sin(70*y) +  1.2*sin(543*y);
% Function1 = valx + valy;
% Function2 = valx - valy;

ind = 1;



Function1 = sin(0.3*(x+1))+sin(0.028*(x+5)) - cos(0.5*(y+2))-cos(0.4*(y+15));
Function2 = sin(0.3*(x+7))+sin(0.028*(x-5)) - cos(0.5*(y+8))-cos(0.4*(y+1));
Function3 = sin(0.3*(x-8))+sin(0.028*(x-5)) - cos(0.5*(y+12))-cos(0.4*(y+3));
Function4 = sin(0.3*(x+9))+sin(0.028*(x+7)) - cos(0.5*(y-7))-cos(0.4*(y+5));
Function5 = sin(0.3*(x+3))+sin(0.028*(x+2)) - cos(0.5*(y-3))-cos(0.4*(y-5));

if((TimePercent >= 0 && TimePercent < 0.1) || (TimePercent >= 0.5 && TimePercent < 0.6))
value = Function1;
else end

if((TimePercent >= 0.1 && TimePercent < 0.2) || (TimePercent >= 0.6 && TimePercent < 0.7))
value = Function2;
else end

if((TimePercent >= 0.2 && TimePercent < 0.3) || (TimePercent >= 0.7 && TimePercent < 0.8))
value = Function3;
else end

if((TimePercent >= 0.3 && TimePercent < 0.4) || (TimePercent >= 0.8 && TimePercent < 0.9))
value = Function4;
else end

if((TimePercent >= 0.4 && TimePercent < 0.5) || (TimePercent >= 0.9 && TimePercent <= 1))
value = Function5;
else end



% close all
% x = [-10:0.001:10];
% y = 0.1*x.^2 + 2*sin(x) + 1*sin(4*x)+0.5*sin(9*x) + 0.2*sin(48*x) + 0.07*sin(70*x) + + 0.03*sin(543*x);
% plot(x,y)


end

