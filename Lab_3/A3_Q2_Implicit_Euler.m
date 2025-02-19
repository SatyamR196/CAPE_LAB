clc;
clear;
close all;

% Define time parameters
T_final = 3000;
dt = 0.0001; % Time step
N = T_final / dt; % Number of time steps

% Initial conditions
y1 = zeros(N,1);
y2 = zeros(N,1);
y1(1) = 2;
y2(1) = 0;

% Newton-Raphson parameters
tol = 1e-6;
max_iter = 50;

% Time stepping with Implicit Euler
for n = 1:N-1
    % Initial guess: Use previous values
    y1_new = y1(n);
    y2_new = y2(n);
    
    for iter = 1:max_iter
        % Function values (F)
        F1 = y1_new - y1(n) - dt * y2_new;
        F2 = y2_new - y2(n) - dt * (1000*(1 - y1_new^2) * y2_new - y1_new);
        
        % Jacobian Matrix (J)
        J11 = 1 - dt * 0; % Partial of F1 w.r.t y1_new
        J12 = -dt;        % Partial of F1 w.r.t y2_new
        J21 = -dt * (-2000 * y1_new * y2_new - 1);
        J22 = 1 - dt * (1000 * (1 - y1_new^2));
        
        % Solve linear system J * [delta_y1; delta_y2] = -F
        J = [J11, J12; J21, J22];
        F = [-F1; -F2];
        delta_y = J \ F;
        
        % Update guesses
        y1_new = y1_new + delta_y(1);
        y2_new = y2_new + delta_y(2);
        
        % Check convergence
        if norm(delta_y, inf) < tol
            break;
        end
    end
    
    % Store updated values
    y1(n+1) = y1_new;
    y2(n+1) = y2_new;
end

% Plot the results
t = 0:dt:T_final-dt;
figure;
plot(t, y1, 'r', 'LineWidth', 1.5);
hold on;
plot(t, y2, 'g', 'LineWidth', 1.5);
xlabel('Time t');
ylabel('y1 and y2');
legend('y1', 'y2');
title('Solution of the System using Implicit Euler with Newton-Raphson');
grid on;
