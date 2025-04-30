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
d1 = 0.95; 
d2 = 0.24; 
%b = 0.0125;
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
b = [0.01, 0.015, 0.02];

%% Inicializar celdas
Y_all = cell(1, length(b));
t_all = cell(1, length(b));
S_all = cell(1, length(b));  % Sensibilidades respecto a theta1

delta = 1e-5;  % perturbación para cálculo de sensibilidad

for i = 1:length(b)
    %% Simulación base
    P = [r0 s0 K n c d1 d2 b(i) theta1 theta2 theta3 theta4 p q0 e cx cy cz G1 G2 G3];
    [t_base, Y_base] = ode45(@(t, Y) vivi(t, Y, P), tspan, x0, options);
    
    %% Simulación con theta1 + delta
    P_pert = P;
    P_pert(6) = P(6) + delta;
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
subplot(2, 3, 1)
hold on
for i = 1:length(b)
    plot(t_all{i}, Y_all{i}(:, 1), 'LineWidth', 2, 'Color', colores{i}, 'LineStyle', lineas{i});
end
xlabel('Time', 'Interpreter', 'latex');
ylabel('$X$', 'Interpreter', 'latex');
set(gca, 'FontSize', 14);

% Y
subplot(2, 3, 2)
hold on
for i = 1:length(b)
    plot(t_all{i}, Y_all{i}(:, 2), 'LineWidth', 2, 'Color', colores{i}, 'LineStyle', lineas{i});
end
xlabel('Time', 'Interpreter', 'latex');
ylabel('$Y$', 'Interpreter', 'latex');
set(gca, 'FontSize', 14);
%legend('$\beta=0.01$', '$\beta=0.015$', '$\beta=0.02$', 'Interpreter', 'latex', 'Orientation', 'horizontal', 'FontSize', 10)

% Z
subplot(2, 3, 3)
hold on
for i = 1:length(b)
    plot(t_all{i}, Y_all{i}(:, 3), 'LineWidth', 2, 'Color', colores{i}, 'LineStyle', lineas{i});
end
xlabel('Time', 'Interpreter', 'latex');
ylabel('$Z$', 'Interpreter', 'latex');
set(gca, 'FontSize', 14);

% S_X(theta1)
subplot(2, 3, 4)
hold on
for i = 1:length(b)
    plot(t_all{i}, S_all{i}(:, 1), 'LineWidth', 2, 'Color', colores{i}, 'LineStyle', lineas{i});
end
xlabel('Time', 'Interpreter', 'latex');
ylabel('$S_{X}(\delta_{1})$', 'Interpreter', 'latex');
set(gca, 'FontSize', 14);


% S_Y(theta1)
subplot(2, 3, 5)
hold on
for i = 1:length(b)
    plot(t_all{i}, S_all{i}(:, 2), 'LineWidth', 2, 'Color', colores{i}, 'LineStyle', lineas{i});
end
xlabel('Time', 'Interpreter', 'latex');
ylabel('$S_{Y}(\delta_{1})$', 'Interpreter', 'latex');
set(gca, 'FontSize', 14);

% S_Z(theta1)
subplot(2, 3, 6)
hold on
for i = 1:length(b)
    plot(t_all{i}, S_all{i}(:, 3), 'LineWidth', 2, 'Color', colores{i}, 'LineStyle', lineas{i});
end
xlabel('Time', 'Interpreter', 'latex');
ylabel('$S_{Z}(\delta_{1})$', 'Interpreter', 'latex');
set(gca, 'FontSize',14);


