function [StepResponse,System] = ObjectForIdentification_4P_03(timeVector,iteration)
Coeff1 = 0.05+0.2*abs(sin(iteration/40-1.7));

Sys = zpk([],[-0.15, -Coeff1+1*i,-Coeff1-1*i],1);
% Sys = zpk([],[-3, -0.3+3i,-0.3-3i],1);
% Sys = zpk([],[-3, -0.3+3i,-0.3-3i,-1+7i,-1-7i],1);
StepResponse = step(Sys,timeVector);
System = tf(Sys);
end

