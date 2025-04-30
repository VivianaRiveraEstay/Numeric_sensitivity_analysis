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
theta1 = 3;
theta2 = 3;
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
S1_all = cell(1, length(b));  % Sensibilidades respecto a delta1 (P(6))
S2_all = cell(1, length(b));  % Sensibilidades respecto a delta2 (P(7))

delta = 1e-5;  % perturbación para cálculo de sensibilidad

for i = 1:length(b)
    %% Simulación base
    P = [r0 s0 K n c d1 d2 b(i) theta1 theta2 theta3 theta4 p q0 e cx cy cz G1 G2 G3];
    [t_base, Y_base] = ode45(@(t, Y) vivi(t, Y, P), tspan, x0, options);

    %% Sensibilidad respecto a delta1 (P(6))
    P_pert1 = P;
    P_pert1(6) = P(6) + delta;
    [~, Y_pert1] = ode45(@(t, Y) vivi(t, Y, P_pert1), tspan, x0, options);
    
    %% Sensibilidad respecto a delta2 (P(7))
    P_pert2 = P;
    P_pert2(7) = P(7) + delta;
    [~, Y_pert2] = ode45(@(t, Y) vivi(t, Y, P_pert2), tspan, x0, options);

    %% Guardar resultados
    Y_all{i} = Y_base;
    t_all{i} = t_base;
    S1_all{i} = (Y_pert1 - Y_base) / delta;
    S2_all{i} = (Y_pert2 - Y_base) / delta;
end

%% Gráficas
figure(2)
colores = {'k', 'k', [0.5 0.5 0.5]};
lineas = {'-', '--', '-'};

% --- Fila 1: Densidades
vars = {'$X$', '$Y$', '$Z$'};
for j = 1:3
    subplot(3, 3, j)
    hold on
    for i = 1:length(b)
        plot(t_all{i}, Y_all{i}(:, j), 'LineWidth', 2, 'Color', colores{i}, 'LineStyle', lineas{i});
    end
    xlabel('Time', 'Interpreter', 'latex');
    ylabel(vars{j}, 'Interpreter', 'latex');
    set(gca, 'FontSize', 14);
end

% --- Fila 2: Sensibilidad con respecto a delta1
for j = 1:3
    subplot(3, 3, j+3)
    hold on
    for i = 1:length(b)
        plot(t_all{i}, S1_all{i}(:, j), 'LineWidth', 2, 'Color', colores{i}, 'LineStyle', lineas{i});
    end
    xlabel('Time', 'Interpreter', 'latex');
    ylabel(['$S_{' vars{j}(2) '}(\delta_{1})$'], 'Interpreter', 'latex');
    set(gca, 'FontSize', 14);
end

% --- Fila 3: Sensibilidad con respecto a delta2
for j = 1:3
    subplot(3, 3, j+6)
    hold on
    for i = 1:length(b)
        plot(t_all{i}, S2_all{i}(:, j), 'LineWidth', 2, 'Color', colores{i}, 'LineStyle', lineas{i});
    end
    xlabel('Time', 'Interpreter', 'latex');
    ylabel(['$S_{' vars{j}(2) '}(\delta_{2})$'], 'Interpreter', 'latex');
    set(gca, 'FontSize', 14);
end
