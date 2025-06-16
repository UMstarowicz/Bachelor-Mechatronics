function [S, I, R] = Runge_Kutta_S22(beta, gamma, N, t0, S0, I0, R0, dt, T)
    % Funkcja implementująca metodę Rungego-Kutty dla modelu SIR

    t = t0:dt:T;
    N_steps = length(t);

    S = zeros(N_steps, 1);
    I = zeros(N_steps, 1);
    R = zeros(N_steps, 1);

    S(1) = S0;
    I(1) = I0;
    R(1) = R0;

    for i = 1:N_steps-1
        k1_S = (-beta/N) * S(i) * I(i);
        k1_I = (beta/N) * S(i) * I(i) - gamma * I(i);
        k1_R = gamma * I(i);

        k2_S = (-beta/N) * (S(i) + 0.5*dt*k1_S) * (I(i) + 0.5*dt*k1_I);
        k2_I = (beta/N) * (S(i) + 0.5*dt*k1_S) * (I(i) + 0.5*dt*k1_I) - gamma * (I(i) + 0.5*dt*k1_I);
        k2_R = gamma * (I(i) + 0.5*dt*k1_I);

        k3_S = (-beta/N) * (S(i) + 0.5*dt*k2_S) * (I(i) + 0.5*dt*k2_I);
        k3_I = (beta/N) * (S(i) + 0.5*dt*k2_S) * (I(i) + 0.5*dt*k2_I) - gamma * (I(i) + 0.5*dt*k2_I);
        k3_R = gamma * (I(i) + 0.5*dt*k2_I);

        k4_S = (-beta/N) * (S(i) + dt*k3_S) * (I(i) + dt*k3_I);
        k4_I = (beta/N) * (S(i) + dt*k3_S) * (I(i) + dt*k3_I) - gamma * (I(i) + dt*k3_I);
        k4_R = gamma * (I(i) + dt*k3_I);

        S(i+1) = S(i) + (1/6)*(k1_S + 2*k2_S + 2*k3_S + k4_S) * dt;
        I(i+1) = I(i) + (1/6)*(k1_I + 2*k2_I + 2*k3_I + k4_I) * dt;
        R(i+1) = R(i) + (1/6)*(k1_R + 2*k2_R + 2*k3_R + k4_R) * dt;
    end
end
