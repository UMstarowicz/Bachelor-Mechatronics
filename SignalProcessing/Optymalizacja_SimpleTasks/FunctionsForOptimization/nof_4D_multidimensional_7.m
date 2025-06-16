function [value] = nof_4D_multidimensional_7(FV)
%2D_1 Summary of this function goes here
%   Detailed explanation goes here
x = FV(1);
y = FV(2);
z = FV(3);
v = FV(4);

BG = sin(x*12)*sin(y*1.76)+sin(x*4)+sin(z*5)*cos(v*5.67);

Dist = sqrt((3-x)^2+(1-y)^2+(3-z)^2+(-0.35-v)^2);
c1 =  1-(1/(39+exp(Dist/0.4))+(1/(40+exp(Dist/0.6))));

Dist = sqrt((7-x)^2);
u = 1-(1/(39+exp(Dist/0.4))+(1/(40+exp(Dist/0.6))));

value = 0.03*BG+74*c1 + 4*u;

% figure;
% plot(valx1); hold on
% plot(valx2); hold on
% plot(valx3); hold on
% plot(valx4); hold on
end

