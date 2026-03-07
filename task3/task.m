%% Лабораторная работа №3: Частотный алгоритм свертки
clear; clc; close all;

%% Параметры
N = 256;
L = 4; sigma = 0.5;
x = linspace(-3, 3, N);

%% Исходные функции
rect = @(x) double(abs(x) <= L/2);
gauss = @(x) exp(-x.^2/sigma^2);

U1 = rect(x);   % rect(x)
U2 = gauss(x);  % Гаусс

%% Функция частотной свертки
conv_freq = @(a, b) ifft(fft([a, zeros(1,N)]) .* fft([b, zeros(1,N)]));

%% === Случай 1: rect * rect ===
W1 = conv_freq(U1, U1);
x_conv = linspace(-6, 6, 2*N);

figure('Position', [50, 550, 1200, 300]);
plot(x_conv, real(W1), 'b-', 'LineWidth', 1.5); grid on;
title('Свертка: rect(x) * rect(x)');
xlabel('x'); ylabel('W(x)');

%% === Случай 2: rect * Гаусс ===
W2 = conv_freq(U1, U2);

figure('Position', [50, 300, 1200, 300]);
plot(x_conv, real(W2), 'r-', 'LineWidth', 1.5); grid on;
title('Свертка: rect(x) * Гаусс(x)');
xlabel('x'); ylabel('W(x)');

%% === Случай 3: Гаусс * Гаусс ===
W3 = conv_freq(U2, U2);

figure('Position', [50, 50, 1200, 300]);
plot(x_conv, real(W3), 'g-', 'LineWidth', 1.5); grid on;
title('Свертка: Гаусс(x) * Гаусс(x)');
xlabel('x'); ylabel('W(x)');