function [x1,x2]=Heuna2(F,t0,y0,dt,T)
% This function implements the Euler method to solve a second-order
% ordinary differential equation (ODE) y' = F(t, y) numerically.

%T=8;
%dt=0.01;
%t=0:0.01:T;
%N=length(t);
%t0=0;
%y0=[5 0];
%m=1;
%b=0;
%k=20;

%[y,v]=Euler_2(@(t,x1,x2) F(t,x1,x2),t0,y0,dt,T);

%function dydt=F(t,x1,x2)
%
%   dydt(1)=-5*x2-3*x1;
%   dydt(2)=x2;
%
%end


t=t0:dt:T;
x1=zeros(length(t),1);
x2=zeros(length(t),1);

x1(1)=y0(2);
x2(1)=y0(1);

for i=1:length(t)-1
    k1=F(t(i),x1(i),x2(i))*dt;
    k2=F(t(i)+dt*0.5,x1(i)+k1(1)*0.5,x2(i)+k1(2)*0.5)*dt;
    k3=F(t(i)+dt*0.5,x1(i)+k2(1)*0.5,x2(i)+k2(2)*0.5)*dt;
    k4=F(t(i)+dt,x1(i)+k3(1),x2(i)+k3(2))*dt;
    x1(i+1)=x1(i)+k1(1)/6+k2(1)/3+k3(1)/3+k4(1)/6;
    x2(i+1)=x2(i)+k1(2)/6+k2(2)/3+k3(2)/3+k4(2)/6;
end

end