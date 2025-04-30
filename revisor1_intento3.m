clc; clear; close all;

% Definir parámetros
r0 = 0.5;
s0 = 0.3;
K = 10;
n = 2;
c = 1.5;
d1 = 0.2;
d2 = 0.15;
b = 0.1;
theta1 = 0.8;
theta2 = 0.9;
theta3 = 1.0;
theta4 = 1.1;
p = 0.5;
q0 = 0.25;
e = 0.05;
cx = 0.02;
cy = 0.03;
cz = 0.04;
G1 = 0.1;
G2 = 0.15;
G3 = 0.2;

% Vector de parámetros
P = [r0, s0, K, n, c, d1, d2, b, theta1, theta2, theta3, theta4, p, q0, e, cx, cy, cz, G1, G2, G3];

% Definir el intervalo de tiempo y condiciones iniciales
tspan = [0 100];
Y0 = [15 9 6 0.01 0.01 0.01 0.1 0.1 0.1 0.1 0.1 0.1];

% Resolver el sistema
[t, Y] = ode45(@(t, Y) vivi_sensibility(t, Y, P), tspan, Y0);

% Graficar las ecuaciones de sensibilidad
figure;
hold on;
plot(t, Y(:,7), 'r', 'LineWidth', 2);
plot(t, Y(:,8), 'g', 'LineWidth', 2);
plot(t, Y(:,9), 'b', 'LineWidth', 2);
plot(t, Y(:,10), 'm', 'LineWidth', 2);
plot(t, Y(:,11), 'c', 'LineWidth', 2);
plot(t, Y(:,12), 'k', 'LineWidth', 2);
hold off;

xlabel('Tiempo');
ylabel('Sensibilidad');
legend('S_{r0}', 'S_{s0}', 'S_{K}', 'S_{otro1}', 'S_{otro2}', 'S_{otro3}');
title('Evolución de las sensibilidades en el tiempo');
grid on;

