%% Лабораторная работа №2: ДПФ и БПФ
clear; clc; close all;

%% Параметры
N = 64;
L = 2; sigma = 1.5;
x = linspace(-5, 5, N);
n = 0:N-1; k = 0:N-1;

%% === Функция ДПФ ===
dft = @(U) arrayfun(@(ki) sum(U .* exp(-2j*pi*n*ki/N)), k);

%% === ПРЯМОУГОЛЬНЫЙ ИМПУЛЬС ===
U_rect = double(abs(x) <= L/2);

% Замер времени ДПФ
tic;
V_rect_dft = dft(U_rect);
time_rect_dft = toc;

% Замер времени БПФ
tic;
V_rect_fft = fft(U_rect);
time_rect_fft = toc;

% С устранением близнецов
U_rect_mod = (-1).^n .* U_rect;
V_rect_fft_mod = fft(U_rect_mod);

% Восстановление
U_rect_rest = ifft(V_rect_fft);
U_rect_rest_mod = ifft(V_rect_fft_mod);
U_rect_rest_mod = (-1).^n .* U_rect_rest_mod;

% Графики
figure('Position', [50, 50, 1400, 400]);
subplot(2,3,1); plot(x, U_rect, 'b-', 'LineWidth', 1.5); grid on; title('Исходный');
subplot(2,3,2); plot(abs(V_rect_dft), 'm-', 'LineWidth', 1.5); grid on; 
title(sprintf('ДПФ (%.4f сек)', time_rect_dft));
subplot(2,3,3); plot(abs(V_rect_fft), 'r-', 'LineWidth', 1.5); grid on;
title(sprintf('БПФ (%.6f сек)', time_rect_fft));
subplot(2,3,4); plot(abs(V_rect_fft_mod), 'g-', 'LineWidth', 1.5); grid on; title('БПФ без близнецов');
subplot(2,3,5); plot(x, real(U_rect_rest), 'r--', 'LineWidth', 1.5); hold on;
plot(x, U_rect, 'b-', 'LineWidth', 0.8); grid on; title('Восстановленный (с близнецами)');
subplot(2,3,6); plot(x, real(U_rect_rest_mod), 'g--', 'LineWidth', 1.5); hold on;
plot(x, U_rect, 'b-', 'LineWidth', 0.8); grid on; title('Восстановленный (без близнецов)');
sgtitle(sprintf('Прямоугольный импульс (N=%d)', N));

%% === СИГНАЛ ГАУССА ===
U_gauss = exp(-x.^2/sigma^2);

% Замер времени ДПФ
tic;
V_gauss_dft = dft(U_gauss);
time_gauss_dft = toc;

% Замер времени БПФ
tic;
V_gauss_fft = fft(U_gauss);
time_gauss_fft = toc;

% С устранением близнецов
U_gauss_mod = (-1).^n .* U_gauss;
V_gauss_fft_mod = fft(U_gauss_mod);

% Восстановление
U_gauss_rest = ifft(V_gauss_fft);
U_gauss_rest_mod = ifft(V_gauss_fft_mod);
U_gauss_rest_mod = (-1).^n .* U_gauss_rest_mod;

% Графики
figure('Position', [50, 500, 1400, 400]);
subplot(2,3,1); plot(x, U_gauss, 'b-', 'LineWidth', 1.5); grid on; title('Исходный');
subplot(2,3,2); plot(abs(V_gauss_dft), 'm-', 'LineWidth', 1.5); grid on;
title(sprintf('ДПФ (%.4f сек)', time_gauss_dft));
subplot(2,3,3); plot(abs(V_gauss_fft), 'r-', 'LineWidth', 1.5); grid on;
title(sprintf('БПФ (%.6f сек)', time_gauss_fft));
subplot(2,3,4); plot(abs(V_gauss_fft_mod), 'g-', 'LineWidth', 1.5); grid on; title('БПФ без близнецов');
subplot(2,3,5); plot(x, real(U_gauss_rest), 'r--', 'LineWidth', 1.5); hold on;
plot(x, U_gauss, 'b-', 'LineWidth', 0.8); grid on; title('Восстановленный (с близнецами)');
subplot(2,3,6); plot(x, real(U_gauss_rest_mod), 'g--', 'LineWidth', 1.5); hold on;
plot(x, U_gauss, 'b-', 'LineWidth', 0.8); grid on; title('Восстановленный (без близнецов)');
sgtitle(sprintf('Сигнал Гаусса (N=%d)', N));

%% Вывод в командное окно
fprintf('=== Прямоугольный импульс ===\n');
fprintf('Время ДПФ:  %.4f сек\n', time_rect_dft);
fprintf('Время БПФ:  %.6f сек\n', time_rect_fft);
fprintf('Ускорение:  %.1f раз\n\n', time_rect_dft/time_rect_fft);

fprintf('=== Сигнал Гаусса ===\n');
fprintf('Время ДПФ:  %.4f сек\n', time_gauss_dft);
fprintf('Время БПФ:  %.6f сек\n', time_gauss_fft);
fprintf('Ускорение:  %.1f раз\n', time_gauss_dft/time_gauss_fft);