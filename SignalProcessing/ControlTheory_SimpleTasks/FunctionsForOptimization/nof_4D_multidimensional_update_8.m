function [value] = nof_4D_multidimensional_8(FV)
%2D_1 Summary of this function goes here
%   Detailed explanation goes here
x = FV(1);
y = FV(2);
z = FV(3);
v = FV(4);

BG = sin(x*2)*sin(y*1.76)+sin(x*1.76)+sin(z*1.54)*cos(v*2.67);

Dist = sqrt((3-x)^2+(1-y)^2+(3-z)^2+(-0.35-v)^2);
c1 =  1-(1/(39+exp(Dist/0.4))+(1/(40+exp(Dist/0.6))));

Dist = sqrt((7-x)^2);
u = 1-(1/(39+exp(Dist/0.4))+(1/(40+exp(Dist/0.6))));

Dist = sqrt((3.12-v)^2);
u2 = 1-(1/(39+exp(Dist/0.4))+(1/(40+exp(Dist/0.6))));

Dist = sqrt((2.12-z)^2);
u3 = 1-(1/(39+exp(Dist/0.4))+(1/(40+exp(Dist/0.6))));

value = 0.03*BG+74*c1 + 4*u + 3*u2 + 3*u3;

valx = 0.02*(0.1*x.^2 + 2*sin(x) + 2.4*sin(4*x)+0.5*sin(9*x) + 1.9*sin(48*x) + 1.7*sin(70*x) +  1.2*sin(543*x));
valy = 0.04*(0.1*y.^2 + 2*sin(y) + 2.4*sin(4*y)+0.5*sin(9*y) + 1.9*sin(48*y) + 1.7*sin(70*y) +  1.2*sin(543*y));

value = 0.1*(value + valx + valy) - 7;



% figure;
% plot(valx1); hold on
% plot(valx2); hold on
% plot(valx3); hold on
% plot(valx4); hold on
end

