function [StepResponse,System] = ObjectForIdentification_4P_03(timeVector,iteration)
Coeff1 = 0.03+0.1*abs(sin(iteration/40-1.7));

Sys = zpk([],[-0.15, -Coeff1+0.6*i,-Coeff1-0.6*i],1);
% Sys = zpk([],[-3, -0.3+3i,-0.3-3i],1);
% Sys = zpk([],[-3, -0.3+3i,-0.3-3i,-1+7i,-1-7i],1);
StepResponse = step(Sys,timeVector);
System = tf(Sys);
end

