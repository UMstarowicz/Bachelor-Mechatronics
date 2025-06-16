function [StepResponse,System] = ObjectForIdentification_4P_03(timeVector,iteration)
Coeff1 = 0.05+0.4*abs(sin(iteration/70-1.7));

Sys = zpk([],[-0.1, -Coeff1+0.7*i,-Coeff1-0.7*i],1);
% Sys = zpk([],[-3, -0.3+3i,-0.3-3i],1);
% Sys = zpk([],[-3, -0.3+3i,-0.3-3i,-1+7i,-1-7i],1);
StepResponse = step(Sys,timeVector);
System = tf(Sys);
end

