function [value1,value2] = of_2D_ParetoFront_0(x1,x2,Time)
%2D_1 Summary of this function goes here
%   Detailed explanation goes here
% x1 = FV(1); x2 = FV(2);
valx1 = 0.1*x1.^2 + 1.8*sin(x1) + 2.4*sin(1.1*x1)+0.5*sin(1.2*x1) + 1.1*sin(48*x1) + 1.8*sin(49*x1) +  0.4*sin(243*x1);
valx2 = 0.1*x2.^2 + 1.9*sin(x2) + 2.1*sin(1.3*x2)+0.5*sin(1.2*x2) + 1.9*sin(22*x2) + 1.9*sin(24*x2) +  0.6*sin(489*x2);
value1 = valx1 + valx2;

valx1 = 0.2*(x1-1).^2 + 1.8*sin(x1-2) + 2.3*sin(1.0*x1+2)+0.8*sin(1.2*x1+1) + 1.9*sin(41*x1-2) + 1.2*sin(42*x1+1) +  0.4*sin(203*x1-6);
valx2 = 0.1*x2.^2 + 1.9*sin(x2-3) + 2.1*sin(1.3*x2-3)+0.5*sin(1.2*(x2-4)) + 1.9*sin(22*x2-1) + 1.9*sin(24*x2-5) +  0.3*sin(259*x2-2);
value2 = valx1 + valx2;
% figure;
% plot(valx1); hold on
% plot(valx2); hold on
% plot(valx3); hold on
% plot(valx4); hold on
end

