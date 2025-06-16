function [value] = of_2D_1(x,y,Time)
%2D_1 Summary of this function goes here
%   Detailed explanation goes here

m1 = -2/(1+(sqrt(2*(x)^2 + 2*(y)^2)));
m2 = -1/(1+(sqrt(1*(x+7)^2 + 1*(y+1)^2)));
m3 = -1/(1+(sqrt(1*(x-6)^2 + 1*(y+7)^2)));
m4 = -1/(1+(sqrt(1*(x-6)^2 + 1*(y-7)^2)));


value = m1 + m2 + m3 + m4+0.2*rand();


end

