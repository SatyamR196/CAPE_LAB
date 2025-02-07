% Define the ODE function
function dydt = myODE(t, y)
    dydt = -2 * y;
end

% Define time span and initial condition
%tspan = [0,5];
tspan = 0:0.01:5 ;
y0 = 1; % y at t=0;

% Solve ODE using ode45
[t, y] = ode45(@myODE, tspan, y0);
disp(t);
% Plot the solution
plot(t, y, 'b.', 'LineWidth', 2)
xlabel('Time t')
ylabel('y(t)')
title('Solution of dy/dt = -2y using ode45')
grid on
