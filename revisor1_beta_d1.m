clc;
close all;
clear all;
tic;

%% Parámetros base
format long
r0 = 1.2; 
s0 = 0.2; 
K = 100; 
n = 10; 
c = 5;
%d1 = 0.4; 
d2 = 0.2; 
b = 0.0125;
theta1 =3;
theta2=3;
theta3 = 3; 
theta4 = 3;
p = 0.1; 
q0 = 0.05; 
e = 0.001;
cx = 1; 
cy = 1; 
cz = 1;
G1 = 0.01; 
G2 = 0.01; 
G3 = 0.01;

%% Condiciones iniciales:
x0 = [15 9 6 0.01 0.01 0.01];
tspan = 0:0.1:10000;
options = odeset('RelTol', 1e-8, 'AbsTol', 1e-10);

%% Valores de theta2
d1 = [0.2 0.4, 0.8];

%% Inicializar celdas
Y_all = cell(1, length(d1));
t_all = cell(1, length(d1));
S_all = cell(1, length(d1));  % Sensibilidades respecto a theta1

delta = 1e-5;  % perturbación para cálculo de sensibilidad

for i = 1:length(d1)
    %% Simulación base
    P = [r0 s0 K n c d1(i) d2 b theta1 theta2 theta3 theta4 p q0 e cx cy cz G1 G2 G3];
    [t_base, Y_base] = ode45(@(t, Y) vivi(t, Y, P), tspan, x0, options);
    
    %% Simulación con theta1 + delta
    P_pert = P;
    P_pert(7) = P(7) + delta;
    [~, Y_pert] = ode45(@(t, Y) vivi(t, Y, P_pert), tspan, x0, options);

    %% Guardar resultados
    Y_all{i} = Y_base;
    t_all{i} = t_base;
    S_all{i} = (Y_pert - Y_base) / delta;
end


figure(2)
colores = {'k', 'k', [0.5 0.5 0.5]};
lineas = {'-', '--', '-'};

% X
subplot(3, 2, 1)
hold on
for i = 1:length(d1)
    plot(t_all{i}, Y_all{i}(:, 1), 'LineWidth', 2, 'Color', colores{i}, 'LineStyle', lineas{i});
end
xlabel('Time', 'Interpreter', 'latex');
ylabel('$X$', 'Interpreter', 'latex');
set(gca, 'FontSize', 20);

% Y
subplot(3, 2, 3)
hold on
for i = 1:length(d1)
    plot(t_all{i}, Y_all{i}(:, 2), 'LineWidth', 2, 'Color', colores{i}, 'LineStyle', lineas{i});
end
xlabel('Time', 'Interpreter', 'latex');
ylabel('$Y$', 'Interpreter', 'latex');
set(gca, 'FontSize', 20);

% Z
subplot(3, 2, 5)
hold on
for i = 1:length(d1)
    plot(t_all{i}, Y_all{i}(:, 3), 'LineWidth', 2, 'Color', colores{i}, 'LineStyle', lineas{i});
end
xlabel('Time', 'Interpreter', 'latex');
ylabel('$Z$', 'Interpreter', 'latex');
set(gca, 'FontSize', 20);

% S_X(theta1)
subplot(3, 2, 2)
hold on
for i = 1:length(d1)
    plot(t_all{i}, S_all{i}(:, 1), 'LineWidth', 2, 'Color', colores{i}, 'LineStyle', lineas{i});
end
xlabel('Time', 'Interpreter', 'latex');
ylabel('$S_{X}(\beta)$', 'Interpreter', 'latex');
set(gca, 'FontSize', 20);


% S_Y(theta1)
subplot(3, 2, 4)
hold on
for i = 1:length(d1)
    plot(t_all{i}, S_all{i}(:, 2), 'LineWidth', 2, 'Color', colores{i}, 'LineStyle', lineas{i});
end
xlabel('Time', 'Interpreter', 'latex');
ylabel('$S_{Y}(\beta)$', 'Interpreter', 'latex');
set(gca, 'FontSize', 20);

% S_Z(theta1)
subplot(3, 2, 6)
hold on
for i = 1:length(d1)
    plot(t_all{i}, S_all{i}(:, 3), 'LineWidth', 2, 'Color', colores{i}, 'LineStyle', lineas{i});
end
xlabel('Time', 'Interpreter', 'latex');
ylabel('$S_{Z}(\beta)$', 'Interpreter', 'latex');
set(gca, 'FontSize', 20);


