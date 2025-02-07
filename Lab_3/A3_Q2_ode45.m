% Define the time span
tspan = 0:0.1:3000;

% Define the initial conditions: [y1, y2]
Y = [2; 0]; %-SS

% Solve using ode45
[t, y] = ode45(@ODE_Q2, tspan, Y);
disp(y);

% Plot the solutions
figure
plot(t, y(:,1), 'r.', 'LineWidth', 1.5); hold on;
plot(t, y(:,2), 'g.', 'LineWidth', 1.5);

xlabel('Time(t)')
ylabel('y1, y2')
title('Solution of Stiff ODEs using ode45')
legend('y1', 'y2')
grid on
