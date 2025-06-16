function y=Euler_1(F,t0,y0,dt,T)
% This function implements the Euler method to solve a first-order
% ordinary differential equation (ODE) y' = F(t, y) numerically.

% T=8;           % Time duration
% dt=0.01;       % Time setp
% t=0:0.01:T;    % Time vector
% N=length(t);   % Number of samples
% t0=0;          % Initial Time
% y0=0;         % Initial condition

% y=Euler_1(@(t,y) F(t,y),t0,y0,dt,T);
% plot(t,y)
% function dydt=F(t,y)
% 
%    dydt=(2*t+3)*(y^2-4);
% 
% end

t=t0:dt:T;
y=zeros(length(t),1);
y(1)=y0;

for i=1:length(t)-1
    k1=F(t(i),y(i))*dt;
    k2 = F(t(i)+dt*0.5,y(i)+k1*0.5)*dt;
    k3 = F(t(i)+dt*0.5,y(i)+k2*0.5)*dt;
    k4 = F(t(i)+dt,y(i)+k3)
    y(i+1)=y(i)+(k2/3)+(k1/6)+(k3/3)+(k4/6);
end

end
% 
% function dydt=F(t,y)
% 
%   dydt=-2*y+8;
% 
% end

