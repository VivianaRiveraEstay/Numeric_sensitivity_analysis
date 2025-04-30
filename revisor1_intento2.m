% En este código graficamos la solución numérica de una ecuación
% diferencial, utilizando la función ODE45, con distintas condiciones iniciales.
% Solución vivi

clc;
close all;
clear all;
tic;

%% Parámetros
format long
r0 = 1.2;
s0 = 0.2;
K = 100;
n = 10;
c = 5;
d1 = 0.4;
d2 = 0.2;
b = 0.0125;
theta1 = 3;  % Este es el parámetro de interés
theta2 = 2;
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

P = [r0 s0 K n c d1 d2 b theta1 theta2 theta3 theta4 p q0 e cx cy cz G1 G2 G3];

%% Condiciones iniciales:
x1 = 15;
x2 = 9;
x3 = 6;
x4 = 0.01;
x5 = 0.01;
x6 = 0.01;

x0 = [x1 x2 x3 x4 x5 x6];

% Definir intervalo de tiempo
tspan = [0:0.1: 10000];

%% Simulación del Modelo
options = odeset('RelTol', 1e-8, 'AbsTol', 1e-10);
[tv, Yv] = ode45(@(t, Y) vivi(t, Y, P), tspan, x0, options);

% Inicializamos la matriz de sensibilidades para cada variable respecto a theta1
S_theta1 = zeros(length(tv), 6);  % Sensibilidad para 6 variables

% Cálculo de la sensibilidad con respecto a theta1:
dP = P;
dP(9) = P(9) + 1e-5;  % Perturbar el parámetro theta1 (posición 9 en el vector P)

% Resolver el sistema con el parámetro perturbado
[~, Yv_new] = ode45(@(t, Y) vivi(t, Y, dP), tspan, x0, options);

% Calcular la sensibilidad en el tiempo para cada variable
for j = 1:6
    S_theta1(:, j) = (Yv_new(:, j) - Yv(:, j)) / 1e-5;
end

% Graficar las sensibilidades con respecto a theta1
% figure(4)
% for j = 1:6
%     subplot(2, 3, j)
%     plot(tv, S_theta1(:, j), 'LineWidth', 2);
%     xlabel('Time');
%     ylabel(['Sensitivity of Y' num2str(j) ' wrt \theta_1']);
%     set(gca, 'FontSize', 12);
% end

figure(2)

subplot(3, 2, 1)
plot(tv, Yv(:, 1), 'LineWidth', 2);
xlabel('Time', 'Interpreter', 'latex');
ylabel('$X$', 'Interpreter', 'latex');
set(gca, 'FontSize', 12);

subplot(3, 2, 3)
plot(tv, Yv(:, 2), 'LineWidth', 2);
xlabel('Time', 'Interpreter', 'latex');
ylabel('$Y$', 'Interpreter', 'latex');
set(gca, 'FontSize', 12);

subplot(3, 2, 5)
plot(tv, Yv(:, 3), 'LineWidth', 2);
xlabel('Time', 'Interpreter', 'latex');
ylabel('$Z$', 'Interpreter', 'latex');
set(gca, 'FontSize', 12);

subplot(3, 2, 2)
plot(tv, S_theta1(:, 1), 'LineWidth', 2);
xlabel('Time', 'Interpreter', 'latex');
ylabel('$S_{X}(\theta_{1})$', 'Interpreter', 'latex');
set(gca, 'FontSize', 12);

subplot(3, 2, 4)
plot(tv, S_theta1(:, 2), 'LineWidth', 2);
xlabel('Time', 'Interpreter', 'latex');
ylabel('$S_{Y}(\theta_{1})$', 'Interpreter', 'latex');
set(gca, 'FontSize', 12);

subplot(3, 2, 6)
plot(tv, S_theta1(:, 3), 'LineWidth', 2);
xlabel('Time', 'Interpreter', 'latex');
ylabel('$S_{Z}(\theta_{1})$', 'Interpreter', 'latex');
set(gca, 'FontSize', 12);





% % Graficar la solución original para referencia
% figure(1)
% subplot(2,1,1), plot(tv, Yv(:,1), 'LineWidth', 2), xlabel('Time'), ylabel('Density');
% hold on
% plot(tv, Yv(:,2), 'LineWidth', 2), xlabel('Time'), ylabel('Density');
% hold on
% plot(tv, Yv(:,3), 'LineWidth', 2), xlabel('Time'), ylabel('Density');
% set(gca, 'FontSize', 20);
% legend('Prey','Native predator' , 'Exotic depredator')
% 
% subplot(2,1,2), plot(tv, Yv(:,4), 'LineWidth', 2), xlabel('Time'), ylabel('Trait value');
% hold on
% plot(tv, Yv(:,5), 'LineWidth', 2), xlabel('Time'), ylabel('Trait value');
% hold on
% plot(tv, Yv(:,6), 'LineWidth', 2), xlabel('Time'), ylabel('Trait value');
% legend('trait u','trait v', 'trait w')
% set(gca, 'FontSize', 20);


tiempo_transcurrido = toc;


