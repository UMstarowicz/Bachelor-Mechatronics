function [value] = of_4D_manyminima_0(FV,Time)
%2D_1 Summary of this function goes here
%   Detailed explanation goes here
x1 = FV(1); x2 = FV(2); x3 = FV(3); x4 = FV(4);
valx1 = 0.1*x1.^2 + 1.8*sin(x1) + 2.4*sin(1.1*x1)+0.5*sin(1.2*x1) + 1.1*sin(48*x1) + 1.8*sin(49*x1) +  1.3*sin(243*x1);
valx2 = 0.1*x2.^2 + 1.9*sin(x2) + 2.1*sin(1.3*x2)+0.5*sin(1.2*x2) + 1.9*sin(22*x2) + 1.9*sin(24*x2) +  1.2*sin(689*x2);
valx3 = 0.1*x3.^2 + 2.3*sin(x3) + 2.4*sin(1.2*x3)+0.5*sin(1.3*x3) + 1.3*sin(49*x3) + 1.4*sin(52*x3) +  1.5*sin(313*x3);
valx4 = 0.1*x4.^2 + 2.1*sin(x4-2) + 2.2*sin(1.1*(x4-2))+0.5*sin(1.3*x4) + 1.6*sin(42*x4) + 1.3*sin(41*x4) +  1.1*sin(551*x4);
value = valx1 + valx2 + valx3 + valx4;
% figure;
% plot(valx1); hold on
% plot(valx2); hold on
% plot(valx3); hold on
% plot(valx4); hold on
end

