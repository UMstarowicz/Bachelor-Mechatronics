function [value] = of_2D_fewminima_7(FV)
%2D_1 Summary of this function goes here
%   Detailed explanation goes here
x = FV(1);
y = FV(2);

BG = 0.002*(sin(x*0.26)+sin(y*0.37)+sin((x-0.71)*0.29)+sin((y+0.4)*0.41));

Dist = sqrt((1.1-x)^2+(1.3-y)^2);
c1 =  1-(1/(39+exp(Dist/0.2))+(1/(40+exp(Dist/0.36))));



value = 20*(c1+BG)-19;
end

