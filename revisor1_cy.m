% En este código graficamos la solución numérica de una ecuación diferencial
% y realizamos un análisis de sensibilidad respecto a cy.

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
theta2 = 3;
theta3 = 3;
theta4 = 3;
p = 0.1;
q0 = 0.05;
e = 0.001;
cx = 1; % Lo dejamos fijo
cy = 0:0.1:6; % Ahora estamos variando cy
cz = 1; % Lo dejamos fijo
G1 = 0.01;
G2 = 0.01;
G3 = 0.01;

m11 = length(cy); % Longitud de cy

% Inicializar matrices para almacenar resultados
R11 = zeros(m11, 7); % Primera columna: cy, otras 6: valores finales de Yv
umbral = 1e-6; % Umbral para considerar valores como cero

for i = 1:m11
    P = [r0 s0 K n c d1 d2 b theta1 theta2 theta3 theta4 p q0 e cx cy(i) cz G1 G2 G3];

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

    % Guardar en R11
    R11(i, :) = [cy(i), valores_finales];
end

%% Cálculo de métricas de variación

% 1️⃣ Rango de variación
rango_variacion = max(R11(:, 2:end)) - min(R11(:, 2:end));

% 2️⃣ Variación relativa (%)
variacion_relativa = ((max(R11(:, 2:end)) - min(R11(:, 2:end))) ./ min(R11(:, 2:end))) * 100;
variacion_relativa(isinf(variacion_relativa)) = NaN; % Evitar divisiones por 0

% 3️⃣ Sensibilidad numérica (derivada aproximada respecto a cy)
sensibilidad = diff(R11(:, 2:end)) ./ diff(cy');

% Mostrar métricas en consola
disp('--- Rango de variación ---');
disp(rango_variacion);

disp('--- Variación relativa (%) ---');
disp(variacion_relativa);

disp('--- Sensibilidad numérica (derivada) ---');
disp(sensibilidad);

%% Graficar la variación de Y respecto a cy
figure(1);
hold on;
plot(cy, R11(:, 2), '-b', 'LineWidth', 2); % Prey
plot(cy, R11(:, 3), '-g', 'LineWidth', 2); % Native predator
plot(cy, R11(:, 4), '-r', 'LineWidth', 2); % Exotic predator
xlabel('$c_y$', 'Interpreter', 'latex');
ylabel('Final population density', 'Interpreter', 'latex');
legend('Prey', 'Native predator', 'Exotic predator', 'Interpreter', 'latex');
set(gca, 'FontSize', 20);
hold off;

%% Graficar la sensibilidad numérica (derivadas aproximadas)
figure(4);
hold on;
plot(cy(1:end-1), sensibilidad(:, 1), '-b', 'LineWidth', 2); % Prey
plot(cy(1:end-1), sensibilidad(:, 2), '-g', 'LineWidth', 2); % Native predator
plot(cy(1:end-1), sensibilidad(:, 3), '-r', 'LineWidth', 2); % Exotic predator
xlabel('$c_y$', 'Interpreter', 'latex');
ylabel('Sensitivity', 'Interpreter', 'latex');
%title('Sensibilidad numérica (dY/dCy)');
legend('Prey', 'Native predator', 'Exotic predator', 'Interpreter', 'latex');
set(gca, 'FontSize', 20);
hold off;

tiempo_transcurrido = toc;
