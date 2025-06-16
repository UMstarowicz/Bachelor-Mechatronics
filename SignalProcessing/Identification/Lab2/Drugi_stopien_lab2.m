% T=8;           % Time duration
% dt=0.01; % Time setp
% t=0:dt:T;    % Time vector
% N=length(t);   % Number of samples
%t0=0;          % Initial Time
%y0=[5, 0];         % Initial condition
m = 12; % masa pręta [kg]
r = 64; % masa na końcu pręta [kg]
l = 0.75; % długość pręta [m]
g = 9.81; % przyspieszenie ziemskie [m/s^2]
x = ((l*r)+(l/2*m))/(m+r);
I = 5.14;
T=0.6;
dt=0.01;
t0=0;
t=t0:dt:T;
N=length(t);
% Warunki początkowe
theta0 = 0.35; % początkowy kąt [rad]
omega0 = 3.5; % początkowa prędkość kątowa [rad/s]
y0 = [theta0; omega0]; % cztery elementy
s1= r*g*l;
s2=2*r*l*l+I+0.25*m*l*l;

% Obliczenie położenia na podstawie kąta
pos = l*sin(y(:,1));

% Wykres kąta i położenia w funkcji czasu
subplot(2,1,1);
plot(t, pos)
xlabel('Czas [s]')
ylabel('Położenie [m]')
title('Położenie wahadła')

subplot(2,1,2);
[y,v]=Euler_2(@(t,x1,x2) F(t,x1,x2),t0,y0,dt,T);
plot(t,y)
xlabel('Czas [s]')
ylabel('Kąt [rad]')
title('Ruch wahadła odwróconego')

function dxdt=F(t,x1, x2)
dxdt(1) = 470.88*sin(x2);
dxdt(2) = 5.14*x1;
 % dydt=-2*y+8;

end


