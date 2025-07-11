function [value] = of_4D_manyminima_0(FV,Time)
%2D_1 Summary of this function goes here
%   Detailed explanation goes here
x = FV(1);
y = FV(2);
c1 =  ((1+((x-2.21)/1.4)^8))/10000000 + (((y+1.312)/1.5)^8)/10000000 - 1/(1+(x+3.21)^2) - 1/(1+(y+1.312)^2) ;
c2 = -1/(1+(sqrt(5*(x+1.98)^2 + 6*(y+0.3)^2)));
c3 = -1/(1+(sqrt(5*(x+1.12)^2 + 6*(y+3.1)^2)));
c4 = -1/(1+(sqrt(5*(x-2)^2 + 6*(y-2.3)^2)));
c5 = -1/(1+(sqrt(5*(x-1)^2 + 6*(y+2.3)^2)));
c6 = -1/(1+(sqrt(5*(x-0.83)^2 + 6*(y+0.73)^2)));
value = 0.8*c1 + c2+1.2*c3+0.4*c4+c5+c6+2.5;

x = FV(3);
y = FV(4);
valx = 0.1*x.^2 + 2*sin(x) + 1*sin(4*x)+0.5*sin(9*x) + 0.2*sin(48*x) + 0.07*sin(70*x) + + 0.03*sin(543*x);
valy = 0.1*y.^2 + 2*sin(y) + 1*sin(4*y)+0.5*sin(9*y) + 0.2*sin(48*y) + 0.07*sin(70*y) + + 0.03*sin(543*y);
valuet = valx + valy;

c1 =  ((1+(x-1.21)^4))/10000000 + ((y+5.312)^4)/10000000 - 1/(1+(x-1.21)^2) - 1/(1+(y+5.812)^2) ;
c2 = -1/(1+(sqrt(5*(x+2)^2 + 6*(y+8)^2)));
c3 = -1/(1+(sqrt(5*(x+5.42)^2 + 6*(y+3.2)^2)));
c4 = -1/(1+(sqrt(5*(x+3)^2 + 6*(y+3.8)^2)));
value = value + 0.05*valuet + c1 + c2+1.2*c3+0.4*c4;
value = value+2;

% figure;
% plot(valx1); hold on
% plot(valx2); hold on
% plot(valx3); hold on
% plot(valx4); hold on
end

