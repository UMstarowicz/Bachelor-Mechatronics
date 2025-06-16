function [value] = of_2D_fewminima_1(FV)
%2D_1 Summary of this function goes here
%   Detailed explanation goes here
x = FV(1);
y = FV(2);
c1 =  ((1+(x-3.21)^4))/10000000 + ((y+1.312)^4)/10000000 - 1/(1+(x-3.21)^2) - 1/(1+(y+1.312)^2) ;
c2 = -1/(1+(sqrt(5*(x+5)^2 + 6*(y+3)^2)));
c3 = -1/(1+(sqrt(5*(x+1.42)^2 + 6*(y+3.1)^2)));
c4 = -1/(1+(sqrt(5*(x-3)^2 + 6*(y-3.3)^2)));
value = c1 + c2+1.2*c3+0.4*c4;
value = value + 2.5;

end

