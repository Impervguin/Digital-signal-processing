%% Лабораторная работа №4-5
% Фильтры Гаусса и Баттеруорта

clear; clc; close all;

%% Параметры
N = 512;
x = linspace(-5,5,N);
dx = x(2)-x(1);

%% Полезный сигнал (Гаусс)
sigma = 0.8;
signal = exp(-x.^2/(2*sigma^2));

%% === Импульсная помеха ===
imp_noise = zeros(1,N);

k = randi([1 N]);                     % случайная позиция
imp_noise(k) = rand*0.5*max(signal);  % случайная амплитуда

%% === Гауссова помеха ===
noise = rand(1,N)-0.5;

f = (-N/2:N/2-1)/(N*dx);
H = exp(-(f/0.5).^2);

NoiseSpec = fftshift(fft(noise));
NoiseSpec = NoiseSpec .* H;

gauss_noise = real(ifft(ifftshift(NoiseSpec)));

%% Итоговый сигнал
y = signal + imp_noise + gauss_noise;

%% Частотная ось
df = 1/(N*dx);
f = (-N/2:N/2-1)*df;

%% FFT сигнала
Y = fftshift(fft(y));

%% === НЧ фильтр Гаусса ===
fc = 1;
H_gauss_LP = exp(-(f/fc).^2);

Y1 = Y .* H_gauss_LP;
y_gauss_LP = real(ifft(ifftshift(Y1)));

%% === НЧ фильтр Баттеруорта ===
n = 4;
H_butt_LP = 1 ./ (1 + (f/fc).^(2*n));

Y2 = Y .* H_butt_LP;
y_butt_LP = real(ifft(ifftshift(Y2)));

%% === ВЧ фильтр Гаусса ===
H_gauss_HP = 1 - H_gauss_LP;

Y3 = Y .* H_gauss_HP;
y_gauss_HP = real(ifft(ifftshift(Y3)));

%% === ВЧ фильтр Баттеруорта ===
H_butt_HP = 1 - H_butt_LP;

Y4 = Y .* H_butt_HP;
y_butt_HP = real(ifft(ifftshift(Y4)));

%% ===== ГРАФИКИ В ОДНОМ ОКНЕ =====

figure('Position',[100 100 1200 700]);

subplot(3,2,1)
plot(x,signal,'b','LineWidth',1.5); grid on
title('Полезный сигнал (Гаусс)')
xlabel('x'); ylabel('A')

subplot(3,2,2)
plot(x,y,'r','LineWidth',1.5); grid on
title('Сигнал с помехами')
xlabel('x'); ylabel('A')

subplot(3,2,3)
plot(x,y_gauss_LP,'g','LineWidth',1.5); grid on
title('НЧ фильтр Гаусса')
xlabel('x'); ylabel('A')

subplot(3,2,4)
plot(x,y_butt_LP,'m','LineWidth',1.5); grid on
title('НЧ фильтр Баттеруорта')
xlabel('x'); ylabel('A')

subplot(3,2,5)
plot(x,y_gauss_HP,'k','LineWidth',1.5); grid on
title('ВЧ фильтр Гаусса')
xlabel('x'); ylabel('A')

subplot(3,2,6)
plot(x,y_butt_HP,'c','LineWidth',1.5); grid on
title('ВЧ фильтр Баттеруорта')
xlabel('x'); ylabel('A')