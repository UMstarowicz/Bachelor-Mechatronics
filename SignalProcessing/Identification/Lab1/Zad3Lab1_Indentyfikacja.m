close all;
clc;
clear all;

load('EEG_SSVEP.mat')

t1 = EEG_SSVEP.time;
x = EEG_SSVEP.data;
i = x(1,:,:);

% Wczytanie danych szumu białego i różowego
white_data = readmatrix('White_noise.xlsx');
pink_data = readmatrix('Pink_noise.xlsx');

% Wyciągnięcie wektora czasu i danych szumu
white_time = white_data(:, 1); % pierwsza kolumna - czas
white_signal = white_data(:, 2); % druga kolumna - sygnał

pink_time = pink_data(:, 1); % pierwsza kolumna - czas
pink_signal = pink_data(:, 2); % druga kolumna - sygnał

% Parametry sygnału
Fs = 1000;          % Częstotliwość próbkowania
T = 1;              % Czas trwania sygnału
t = 0:1/Fs:T-1/Fs;  % Wektor czasu

% Interpolacja danych szumu na wektor czasu t
white_signal_interp = interp1(white_time, white_signal, t);
pink_signal_interp = interp1(pink_time, pink_signal, t);

% Wyświetlanie sygnału białego
figure;
plot(t, white_signal_interp);
xlabel('Czas [s]');
ylabel('Amplituda');
title('Sygnał biały');
grid on;

% Wyświetlanie sygnału różowego
figure;
plot(t1, x);
xlabel('Czas [s]');
ylabel('Amplituda');
title('Sygnał EEG');
grid on;

% Obliczenie autokorelacji sygnału
autocorr_signal_white = xcorr(white_signal_interp, 'normalized');

% Wyświetlenie wyniku
figure;
plot(autocorr_signal_white);
xlabel('Opóźnienie');
ylabel('Autokorelacja');
title('Autokorelacja sygnału');

% Obliczenie autokorelacji sygnału
autocorr_signal_pink = xcorr(pink_signal_interp, 'normalized');

% Wyświetlenie wyniku
figure;
plot(autocorr_signal_pink);
xlabel('Opóźnienie');
ylabel('Autokorelacja');
title('Autokorelacja sygnału');

% Obliczenie transformaty Fouriera sygnału
fft_signal_white = fft(white_signal_interp);

% Wektor częstotliwości
f = (0:length(fft_signal_white)-1)*Fs/length(fft_signal_white);

% Wyświetlenie wyniku
figure;
plot(f, fft_signal_white);
xlabel('Częstotliwość [Hz]');
ylabel('Gęstość mocy');
title('Widmo białego sygnału');

% Obliczenie transformaty Fouriera sygnału
fft_signal_pink = fft(pink_signal_interp);

% Wektor częstotliwości
f = (0:length(fft_signal_pink)-1)*Fs/length(fft_signal_pink);

% Wyświetlenie wyniku
figure;
plot(f, fft_signal_pink);
xlabel('Częstotliwość [Hz]');
ylabel('Gęstość mocy');
title('Widmo różowego sygnału');

x1 = interp1(white_time, white_signal, t);
x1 = interp1(pink_time, pink_signal, t);
n=[10,20,40,50,100,200,400,500,1000];
