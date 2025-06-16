% Parametry
beta = 2;
gamma = 1;
N = 500;

% Czas
t0 = 0;
dt = 0.001;
T = 12;

% Warunki początkowe
S0 = 480; % Liczba podatnych osób
I0 = 20;  % Liczba zakażonych osób
R0 = 0;   % Liczba ozdrowiałych osób

% Obliczenie rozwiązania
[S, I, R] = Runge_Kutta_S22(beta, gamma, N, t0, S0, I0, R0, dt, T);
subplot(3,1,1)
plot(t,S)
title("Podatni")
subplot(3,1,2)
plot(t,I)
title("Zakażeni")
subplot(3,1,3)
plot(t,R)
title("Ozdrowiali")