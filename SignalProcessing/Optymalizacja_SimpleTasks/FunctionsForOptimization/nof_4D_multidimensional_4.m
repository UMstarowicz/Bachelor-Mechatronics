function [value] = of_4D_manyminima_0(FV,Time)
%2D_1 Summary of this function goes here
%   Detailed explanation goes here
x1 = FV(1); x2 = FV(2); x3 = FV(3); x4 = FV(4);
valx1 = 0.1*x1.^2 + 1.8*sin(x1) + 2.4*sin(4.2*x1)+0.5*sin(9*x1) + 1.1*sin(48*x1) + 1.8*sin(70*x1) +  1.3*sin(543*x1);
valx2 = 0.1*x2.^2 + 1.9*sin(x2) + 2.1*sin(3.9*x2)+0.5*sin(10*x2) + 1.9*sin(22*x2) + 1.9*sin(78*x2) +  1.2*sin(589*x2);
valx3 = 0.1*x3.^2 + 2.3*sin(x3) + 2.4*sin(3.1*x3)+0.5*sin(7*x3) + 1.3*sin(49*x3) + 1.4*sin(95*x3) +  1.5*sin(513*x3);
valx4 = 0.1*x4.^2 + 2.1*sin(x4) + 2.2*sin(3.7*x4)+0.5*sin(8*x4) + 1.6*sin(42*x4) + 1.3*sin(83*x4) +  1.1*sin(523*x4);
value = valx1 + valx2 + valx3 + valx4;

end

