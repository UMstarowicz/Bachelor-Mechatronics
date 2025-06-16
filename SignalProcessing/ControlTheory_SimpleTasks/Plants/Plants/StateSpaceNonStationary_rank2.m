function [A,B,C,D] = StateSpaceNonStationary_rank2_Test(Coefficients)

if(Coefficients == 0)
    Coefficients = [0,0,0,0];
end


p1 = [-0.5+0.17*cos(Coefficients(2)/4) + 2*sin(Coefficients(1)/6)*i,...
    -0.5+0.17*cos(Coefficients(2)/4) - 2*sin(Coefficients(1)/6)*i];
    
z1 = [];
% p2 = [-0.2 + 7*i, -0.2 - 7*i, -0.3 + 4*i, -0.3 - 4*i,];
% z2 = [-8];

[A b1 c1 D] = zp2ss(z1,p1,1);

B = [b1,[0,1]'];
C = [c1];


end

