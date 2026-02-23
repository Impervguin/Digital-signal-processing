%% ЛР №1: Изучение дискретизации сигналов
clear; clc; close all;

%% Параметры
L = 2;          % Ширина прямоугольного импульса
A = 1;          % Амплитуда сигнала Гаусса
sigma = 1.5;    % Параметр сигнала Гаусса 

dx = 0.2;       % Шаг дискретизации
F = 1/(2*dx);   % Частота

x_min = -5;
x_max = 5;
x = x_min:0.001:x_max;

%% Прямоугольный импульс

U_rect = zeros(size(x));
U_rect(abs(x) <= L/2) = 1;

% Дискретизация
x_discr = x_min:dx:x_max; 
U_rect_discr = zeros(size(x_discr));
U_rect_discr(abs(x_discr) <= L/2) = 1;

% Восстановление по формуле Котельникова
U_rect_restored = zeros(size(x));
for k = 1:length(x_discr)
    U_rect_restored = U_rect_restored + U_rect_discr(k) * sinc(2*F*(x - x_discr(k)));
end

figure('Name', 'Прямоугольный импульс', 'Position', [100, 100, 1200, 400]);

subplot(1, 3, 1);
plot(x, U_rect, 'b-', 'LineWidth', 1.5);
grid on;
xlabel('x');
ylabel('U(x)');
title('Исходный сигнал');
ylim([-0.2, 1.2]);
xlim([x_min, x_max]);

subplot(1, 3, 2);
stem(x_discr, U_rect_discr, 'r', 'LineWidth', 1.5, 'MarkerSize', 6);
hold on;
plot(x, U_rect, 'b--', 'LineWidth', 0.8);
grid on;
xlabel('x');
ylabel('U(k\Delta x)');
title('Дискретный сигнал');
ylim([-0.2, 1.2]);
xlim([x_min, x_max]);
legend('Отсчеты', 'Исходный', 'Location', 'best');

subplot(1, 3, 3);
plot(x, U_rect, 'r--', 'LineWidth', 1.5, 'DisplayName', 'Исходный');
hold on;
plot(x, U_rect_restored, 'b-', 'LineWidth', 1.5, 'DisplayName', 'Восстановленный');
grid on;
xlabel('x');
ylabel('U(x)');
title('Восстановление по Котельникову');
ylim([-0.2, 1.2]);
xlim([x_min, x_max]);
legend('Location', 'best');

sgtitle(sprintf('Прямоугольный импульс (L = %.1f, \\Delta x = %.2f)', L, dx));

%% Сигнал Гаусса

U_gauss = A * exp(-x.^2 / sigma^2);

U_gauss_discr = A * exp(-x_discr.^2 / sigma^2);

U_gauss_restored = zeros(size(x));
for k = 1:length(x_discr)
    U_gauss_restored = U_gauss_restored + U_gauss_discr(k) * sinc(2*F*(x - x_discr(k)));
end

figure('Name', 'Сигнал Гаусса', 'Position', [100, 550, 1200, 400]);

subplot(1, 3, 1);
plot(x, U_gauss, 'b-', 'LineWidth', 1.5);
grid on;
xlabel('x');
ylabel('U(x)');
title('Исходный сигнал');
ylim([-0.1, 1.1]);
xlim([x_min, x_max]);

subplot(1, 3, 2);
stem(x_discr, U_gauss_discr, 'r', 'LineWidth', 1.5, 'MarkerSize', 6);
hold on;
plot(x, U_gauss, 'b--', 'LineWidth', 0.8);
grid on;
xlabel('x');
ylabel('U(k\Delta x)');
title('Дискретный сигнал');
ylim([-0.1, 1.1]);
xlim([x_min, x_max]);
legend('Отсчеты', 'Исходный', 'Location', 'best');

subplot(1, 3, 3);
plot(x, U_gauss, 'r--', 'LineWidth', 1.5, 'DisplayName', 'Исходный');
hold on;
plot(x, U_gauss_restored, 'b-', 'LineWidth', 1.5, 'DisplayName', 'Восстановленный');
grid on;
xlabel('x');
ylabel('U(x)');
title('Восстановление по Котельникову');
ylim([-0.1, 1.1]);
xlim([x_min, x_max]);
legend('Location', 'best');