% En este código graficamos la solución numérica de una ecuación diferencial
% y realizamos un análisis de sensibilidad respecto a G2.

clc 
close all
clear all
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
G2 = 0:0.01:1; % Ahora variamos G2
G3 = 0.01;

m14 = length(G2); % Longitud del vector G2

% Inicializar matrices para almacenar resultados
R14 = zeros(m14, 7); % Primera columna: G2, otras 6: valores finales de Yv
umbral = 1e-6;

for i = 1:m14
    P = [r0 s0 K n c d1 d2 b theta1 theta2 theta3 theta4 ...
         p q0 e cx cy cz G1 G2(i) G3];

    %% Condiciones iniciales:
    x0 = [15 9 6 0.01 0.01 0.01];

    % Intervalo de tiempo
    tspan = [0 10000];

    %% Simulación del Modelo
    options = odeset('RelTol', 1e-8, 'AbsTol', 1e-10);
    [tv, Yv] = ode45(@(t,Y) vivi(t,Y,P), tspan, x0, options);

    % Aplicar umbral
    valores_finales = Yv(end, :);
    valores_finales(valores_finales < umbral) = 0;

    % Guardar resultados
    R14(i, :) = [G2(i), valores_finales];
end

%% Métricas de variación

rango_variacion = max(R14(:, 2:end)) - min(R14(:, 2:end));
variacion_relativa = ((max(R14(:, 2:end)) - min(R14(:, 2:end))) ./ min(R14(:, 2:end))) * 100;
variacion_relativa(isinf(variacion_relativa)) = NaN;

% Sensibilidad numérica (derivada aprox. respecto a G2)
sensibilidad = diff(R14(:, 2:end)) ./ diff(G2');

% Mostrar métricas
disp('--- Rango de variación ---');
disp(rango_variacion);
disp('--- Variación relativa (%) ---');
disp(variacion_relativa);
disp('--- Sensibilidad numérica (derivada) ---');
disp(sensibilidad);

%% Gráfica de poblaciones finales vs G2
figure(1);
hold on;
plot(G2, R14(:, 2), '-b', 'LineWidth', 2); % Prey
plot(G2, R14(:, 3), '-g', 'LineWidth', 2); % Native predator
plot(G2, R14(:, 4), '-r', 'LineWidth', 2); % Exotic predator
xlabel('$G_{Y}$', 'Interpreter', 'latex');
ylabel('Final population density', 'Interpreter', 'latex');
legend('Prey', 'Native predator', 'Exotic predator', 'Interpreter', 'latex');
set(gca, 'FontSize', 20);
hold off;

%% Gráfica de sensibilidad numérica
figure(4);
hold on;
plot(G2(1:end-1), sensibilidad(:, 1), '-b', 'LineWidth', 2); % Prey
plot(G2(1:end-1), sensibilidad(:, 2), '-g', 'LineWidth', 2); % Native predator
plot(G2(1:end-1), sensibilidad(:, 3), '-r', 'LineWidth', 2); % Exotic predator
xlabel('$G_{Y}$', 'Interpreter', 'latex');
ylabel('Sensitivity', 'Interpreter', 'latex');
legend('Prey', 'Native predator', 'Exotic predator', 'Interpreter', 'latex');
set(gca, 'FontSize', 20);
hold off;

tiempo_transcurrido = toc;
