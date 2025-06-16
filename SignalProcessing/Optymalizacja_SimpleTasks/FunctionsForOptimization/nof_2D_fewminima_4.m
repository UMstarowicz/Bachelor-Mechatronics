function [value] = of_2D_fewminima_4(FV)
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


end

