function [value] = of_2D_1(x,y,Time)
%2D_1 Summary of this function goes here
%   Detailed explanation goes here

value =  ((x)^8)/10000000 + ((y)^8)/10000000 - 1/(1+x^2) - 1/(1+y^2) +0.1*randn();


end

