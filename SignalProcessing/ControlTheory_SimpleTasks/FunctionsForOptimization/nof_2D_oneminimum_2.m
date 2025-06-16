function [value] = of_2D_1(FV,Time)
%2D_1 Summary of this function goes here
%   Detailed explanation goes here
x = FV(1); y = FV(2);
value = (x^8)/100000000+(y^8)/100000000 - 1/(0.1+sqrt(4*x^2 + 4*y^2));


end

