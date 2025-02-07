% Define the time span
tspan = 0:1:3000;

% Define the initial conditions: [y1, y2]
Y = [2; 0]; %-SS
options = odeset('RelTol', 1e-8, 'AbsTol', 1e-10);
% Solve using ode45
[t, y] = ode15s(@ODE_Q2, tspan, Y,options);
disp(y);

% Plot the solutions
figure
plot(t, y(:,1), 'r.', 'LineWidth', 1.5); hold on;
plot(t, y(:,2), 'g.', 'LineWidth', 1.5);

xlabel('Time(t)')
ylabel('y1, y2')
title('Solution of 2 ODEs using ode15s')
legend('y1', 'y2')
grid on
