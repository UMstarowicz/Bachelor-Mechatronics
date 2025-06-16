function [StepResponse,System] = SystemTest(timeVector,iteration)
Coeff1 = 0.1+0.3*abs(sin(iteration/70-1.7));

Sys = zpk([],[-0.9, -Coeff1+1*i,-Coeff1-1*i],1);
% Sys = zpk([],[-3, -0.3+3i,-0.3-3i],1);
% Sys = zpk([],[-3, -0.3+3i,-0.3-3i,-1+7i,-1-7i],1);
StepResponse = step(Sys,timeVector);
System = tf(Sys);
end

