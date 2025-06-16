function [StepResponse,System] = SystemTest(timeVector,iteration)
Coeff1 = sin(iteration/70);

Sys = zpk([],[-1, -0.4+2*Coeff1*i,-0.4-2*Coeff1*i],1);
% Sys = zpk([],[-3, -0.3+3i,-0.3-3i],1);
% Sys = zpk([],[-3, -0.3+3i,-0.3-3i,-1+7i,-1-7i],1);
StepResponse = step(Sys,timeVector);
System = tf(Sys);
end

