function [StepResponse,System] = ObjectForIdentification_4P_03(timeVector,iteration)
Coeff1 = 0.05+0.4*abs(sin(iteration/40-1.7));

Sys = zpk([],[-0.5, -Coeff1+2*i,-Coeff1-2*i],1);
% Sys = zpk([],[-3, -0.3+3i,-0.3-3i],1);
% Sys = zpk([],[-3, -0.3+3i,-0.3-3i,-1+7i,-1-7i],1);
StepResponse = step(Sys,timeVector);
System = tf(Sys);
end

