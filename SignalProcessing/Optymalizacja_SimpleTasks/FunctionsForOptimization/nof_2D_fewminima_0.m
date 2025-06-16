function [value] = nof_2D_fewminima_0(FV)
%2D_1 Summary of this function goes here
%   Detailed explanation goes here
x = FV(1);
y = FV(2);

m1 = -2/(0.5+(sqrt(2*(x+0.00185)^2 + 2*(y+0.00522)^2)));
m2 = -1/(1+(sqrt(1*(x+7)^2 + 1*(y+1)^2)));
m3 = -1/(1+(sqrt(1*(x-6)^2 + 1*(y+7)^2)));
m4 = -1/(1+(sqrt(1*(x-6)^2 + 1*(y-7)^2)));


value = m1 + m2 + m3 + m4 +5;


end

