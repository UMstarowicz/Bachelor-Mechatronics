clc; clear all;

% Parametry
m = 12; % masa pręta [kg]
r = 64; % masa na końcu pręta [kg]
l = 0.75; % długość pręta [m]
g = 9.81; % przyspieszenie ziemskie [m/s^2]
x = ((l*r)+(l/2*m))/(m+r);
% Obliczenie momentu bezwładności
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

% % Wykres kąta w funkcji czasu
% subplot(2,1,1);
% plot(t, y(:, 1));
% xlabel('Czas [s]');
% ylabel('Kąt [rad]');
% title('Ruch wahadła odwróconego');
% 
% % Wykres położenia końca pręta w funkcji czasu
% subplot(2,1,2);
% plot(t, l*sin(y(:, 3)));
% xlabel('Czas [s]');
% ylabel('Położenie [m]');
% title('Położenie końca wahadła');

[y,v]=Euler_2(@(t,x1,x2) F(t,x1,x2),t0,y0,dt,T);
plot(t,y)

function dxdt=F(t,x1, x2)
dxdt(1) = r*g*x*sin(x2);
dxdt(2) = (2*r*l*l+I+0.25*m*l*l)*x1;
end