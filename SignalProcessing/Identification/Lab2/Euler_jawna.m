clear all; clc; close all;

T=12;           % Time duration
dt=0.001; % Time setp
t=0:dt:T;    % Time vector
N=500;   % Number of samples
t0=0;          % Initial Time
y0=20;         % Initial condition
B=4;
A=1;
c=(B/N)
% S = 1:1:N;


%%
y=Euler_1(@(t,y) F(t,y),t0,y0,dt,T);
plot(t,y)
I = 500-y;
function dydt=F(t,y)

  dydt=-0.008*I*y+I;

end

