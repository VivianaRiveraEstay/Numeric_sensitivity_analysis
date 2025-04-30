% En este código graficamos la solución numérica de una ecuación diferencial
% y realizamos un análisis de sensibilidad respecto a theta2.

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
d1 = 0.4; % Lo dejamos fijo
d2 = 0.2; % Lo dejamos fijo
b = 0.0125; % Lo dejamos fijo
theta1 = 3;
theta2 = 0:0.1:6; % Ahora estamos variando theta2
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

m7 = length(theta2); % Longitud de theta2

% Inicializar matrices para almacenar resultados
R7 = zeros(m7, 7); % Primera columna: theta2, otras 6: valores finales de Yv
umbral = 1e-6; % Umbral para considerar valores como cero

for i = 1:m7
    P = [r0 s0 K n c d1 d2 b theta1 theta2(i) theta3 theta4 p q0 e cx cy cz G1 G2 G3];

    %% Condiciones iniciales:
    x0 = [15 9 6 0.01 0.01 0.01];

    % Definir intervalo de tiempo
    tspan = [0 10000];

    %% Simulación del Modelo
    options = odeset('RelTol', 1e-8, 'AbsTol', 1e-10);
    [tv, Yv] = ode45(@(t,Y) vivi(t,Y,P), tspan, x0, options);

    % Aplicar umbral
    valores_finales = Yv(end, :);
    valores_finales(valores_finales < umbral) = 0;

    % Guardar en R7
    R7(i, :) = [theta2(i), valores_finales];
end

%% Cálculo de métricas de variación

% 1️⃣ Rango de variación
rango_variacion = max(R7(:, 2:end)) - min(R7(:, 2:end));

% 2️⃣ Variación relativa (%)
variacion_relativa = ((max(R7(:, 2:end)) - min(R7(:, 2:end))) ./ min(R7(:, 2:end))) * 100;
variacion_relativa(isinf(variacion_relativa)) = NaN; % Evitar divisiones por 0

% 3️⃣ Sensibilidad numérica (derivada aproximada respecto a theta2)
sensibilidad = diff(R7(:, 2:end)) ./ diff(theta2');

% Mostrar métricas en consola
disp('--- Rango de variación ---');
disp(rango_variacion);

disp('--- Variación relativa (%) ---');
disp(variacion_relativa);

disp('--- Sensibilidad numérica (derivada) ---');
disp(sensibilidad);

%% Graficar la variación de Y respecto a theta2
figure(1);
hold on;
plot(theta2, R7(:, 2), '-b', 'LineWidth', 2); % Prey
plot(theta2, R7(:, 3), '-g', 'LineWidth', 2); % Native predator
plot(theta2, R7(:, 4), '-r', 'LineWidth', 2); % Exotic predator
xlabel('$\theta_{2}$', 'Interpreter', 'latex');
ylabel('Final population density', 'Interpreter', 'latex');
legend('Prey', 'Native predator', 'Exotic predator', 'Interpreter', 'latex');
set(gca, 'FontSize', 20);
hold off;

%% Graficar la sensibilidad numérica (derivadas aproximadas)
figure(4);
hold on;
plot(theta2(1:end-1), sensibilidad(:, 1), '-b', 'LineWidth', 2); % Prey
plot(theta2(1:end-1), sensibilidad(:, 2), '-g', 'LineWidth', 2); % Native predator
plot(theta2(1:end-1), sensibilidad(:, 3), '-r', 'LineWidth', 2); % Exotic predator
xlabel('$\theta_{2}$', 'Interpreter', 'latex');
ylabel('Sensitivity', 'Interpreter', 'latex');
%title('Sensibilidad numérica (dY/dTheta2)');
legend('Prey', 'Native predator', 'Exotic predator', 'Interpreter', 'latex');
set(gca, 'FontSize', 20);
hold off;

tiempo_transcurrido = toc;
