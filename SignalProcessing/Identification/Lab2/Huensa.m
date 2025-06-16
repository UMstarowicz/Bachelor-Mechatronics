
function y=Euler_1(F,t0,y0,dt,T)
T=8;           % Time duration
dt=0.01; % Time setp
t=0:dt:T;    % Time vector
N=length(t);   % Number of samples
t0=0;          % Initial Time
y0=0;         % Initial condition


%%
y=Euler_1(@(t,y) F(t,y),t0,y0,dt,T);
plot(t,y)

t=t0:dt:T;
y=zeros(length(t),1);
y(1)=y0;

for i=1:length(t)-1
    k1=F(t(i),y(i))*dt;
    k2 = F(t(i)+dt,y(i)+k1)*dt;
    y(i+1)=y(i)+(k2*0.5)+(k1*0.5);
end


end


function dydt=F(t,y)

  dydt=-2*y+8;

end
