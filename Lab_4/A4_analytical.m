% Given parameters
L = 2;          % Length of the fin
m = sqrt(1.5);  % Given beta (β) = 1.5, so m = sqrt(β)
T_inf = 30;     % Ambient temperature
T0 = 100;       % Temperature at x = 0
TL = 30;        % Temperature at x = L

% Define x as a range of values
x = 0:0.1:2;

% Compute the temperature distribution in terms of T
T = T_inf + ((TL - T_inf) * sinh(m*x) + (T0 - T_inf) * sinh(m*(L-x))) ./ sinh(m*L);

% Plot the result
figure(1)
plot(x, T, 'g-', 'LineWidth', 1.5);hold on;
xlabel('x');
ylabel('Temperature T(x)');
title('Temperature Distribution (Analytical Solution)');
grid on;
