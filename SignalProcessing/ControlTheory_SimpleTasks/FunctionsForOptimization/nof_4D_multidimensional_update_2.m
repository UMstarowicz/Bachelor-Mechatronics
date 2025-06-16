function [value] = of_4D_multidimensional_temporary(FV)
%2D_1 Summary of this function goes here
%   Detailed explanation goes here
x = FV(1);
y = FV(2);
m1 = -2/(1+(sqrt(19*(x-0.13)^2 + 12*(y+1.23)^2)));
m2 = -1/(1+(sqrt(2*(x+7)^2 + 1*(y+2)^2)));
m3 = -1/(1+(sqrt(1*(x+2)^2 + 7*(y+1)^2)));
m4 = -1/(1+(sqrt(2*(x+1)^2 + 3*(y-9)^2)));
m5 = -1/(1+(sqrt(5*(x-5)^2 + 6*(y+2)^2)));
m6 = -1/(1+(sqrt(3*(x-9)^2 + 5*(y-5)^2)));
m7 = -1/(1+(sqrt(4*(x+3)^2 + 3*(y-4)^2)));
m8 = -1/(1+(sqrt(1*(x+1)^2 + 2*(y+8)^2)));
m9 = -1/(1+(sqrt(6*(x)^2 + 3*(y+7)^2)));
m10 = -1/(1+(sqrt(2*(x-7)^2 + 12*(y+5)^2)));
m11 = -1/(1+(sqrt(10*(x+8)^2 + 1*(y-4)^2)));




value = m1 + m2 + m3 + m4 + m5 + m6 + m7+m8+m9+m10+m11;

x = FV(3);
y = FV(4);
valx = 0.07*(0.1*x.^2 + 2*sin(x) + 2.4*sin(4*x)+0.5*sin(9*x) + 1.9*sin(48*x) + 1.7*sin(70*x) +  1.2*sin(543*x));
valy = 0.15*(0.1*y.^2 + 2*sin(y) + 2.4*sin(4*y)+0.5*sin(9*y) + 1.9*sin(48*y) + 1.7*sin(70*y) +  1.2*sin(543*y));
value = value + valx + valy;


end

