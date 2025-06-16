function [x1,x2]=Euler_2(F,t0,y0,dt,T)
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
    k2=F(t(i)+dt,x1(i)+k1,x2(i)+k1)*dt;
    x1(i+1)=x1(i)+k1(1)*0+k2(1);
    x2(i+1)=x2(i)+k1(2)*0+k2(2);
end

end