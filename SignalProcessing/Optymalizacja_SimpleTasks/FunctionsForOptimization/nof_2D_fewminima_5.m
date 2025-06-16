function [value] = of_2D_fewminima_5(FV)
%2D_1 Summary of this function goes here
%   Detailed explanation goes here
x = FV(1);
y = FV(2);

Dist = sqrt((3-x)^2+(1-y)^2);
c1 =  1-(1/(39+exp(Dist/0.4))+(1/(40+exp(Dist/0.6))));
Dist = sqrt((1-x)^2+(-6-y)^2);
c2 =  1-(1/(39+exp(Dist/0.4))+(1/(40+exp(Dist/0.6))));
Dist = sqrt((-4-x)^2+(5-y)^2);
c3 =  1-(1/(39+exp(Dist/0.4))+(1/(40+exp(Dist/0.6))));
Dist = sqrt((-6-x)^2+(1-y)^2);
c4 =  1-(1/(39+exp(Dist/0.4))+(1/(40+exp(Dist/0.6))));
Dist = sqrt((-6-x)^2+(-7-y)^2);
c5 =  1-(1/(39+exp(Dist/0.4))+(1/(40+exp(Dist/0.6))));
Dist = sqrt((7-x)^2+(6-y)^2);
c6 =  1-(1/(39+exp(Dist/0.4))+(1/(40+exp(Dist/0.6))));

Dist = sqrt((-0.17-x)^2+(0.13-y)^2);
c7 = (1-(1/(39+exp(Dist/4))+(1/(40+exp(Dist/5)))));

% c2 = -1/(1+(sqrt(5*(x+1.98)^2 + 6*(y+0.3)^2)));
% c3 = -1/(1+(sqrt(5*(x+1.12)^2 + 6*(y+3.1)^2)));
% c4 = -1/(1+(sqrt(5*(x-2)^2 + 6*(y-2.3)^2)));
% c5 = -1/(1+(sqrt(5*(x-1)^2 + 6*(y+2.3)^2)));
% c6 = -1/(1+(sqrt(5*(x-0.83)^2 + 6*(y+0.73)^2)));
% value = c1 + c2+1.2*c3+0.4*c4+c5+c6;

value = 0.1*(c1+c2+c3+c4+c5+c6)+c7;

value =value * 100 - 154;
end

