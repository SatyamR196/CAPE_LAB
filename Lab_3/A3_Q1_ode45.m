% Define the time span
tspan = 0:0.1:50;

% Define the initial conditions: [CA, T, Tj]
% SS1 :
% Y = [0.91;291; 234]; % SS-25%
% Y = [1.4052; 387.38; 312.93]; % Actual SS
% Y = [1.75; 484.2; 390]; % SS+25%

Y = [1.33 ; 367; 297]; % SS-5%
% Y = [1.4052 ; 387.38 ; 312.93]; % Actual SS
% Y = [1.47 ; 407 ; 327]; % SS+5%
%----------------------------------------------
% SS2 :
% Y = [4.62 ; 253 ; 228]; % SS-25%
% Y = [6.179546 ; 337.732720 ; 304.622120]; % Actual SS
% Y = [7.71 ; 422.12; 380]; % SS+25%

% Y = [5.86 ; 320.8 ; 297]; % SS-5%
% Y = [6.179546 ; 337.732720 ; 304.622120]; % Actual SS
% Y = [6.47 ; 354.58 ; 327]; % SS+5%

% Y = [6.1 ; 334.35 ; 301]; % SS-1%
% Y = [6.179546 ; 337.732720 ; 304.622120]; % Actual SS
% Y = [6.23 ; 341 ; 307]; % SS+1%
%----------------------------------------------
% SS3 :
% Y = [6.92 ; 231 ; 225]; % SS-25%
% Y = [8.963732 ; 308.777185 ; 299.796198]; % Actual SS
% Y = [11.2 ; 385; 374]; % SS+25%

% Y = [5.86 ; 293.3 ; 284.05]; % SS-5%
% Y = [8.963732 ; 308.777185 ; 299.76]; % Actual SS
% Y = [6.47 ; 324.58 ; 313.95]; % SS+5%
%----------------------------------------------

% Solve using ode45
[t, y] = ode45(@ODE, tspan, Y);
disp(y);

dy = abs(diff(y));  
threshold = 1e-3;

% Finding the first time where all variables change less than threshold
steady_index = find(all(dy < threshold, 2), 1);

% Get the corresponding steady-state time
if ~isempty(steady_index)
    steady_time = t(steady_index);
    fprintf('Steady state reached at t = %.2f\n', steady_time);
else
    fprintf('Steady state not reached within the given time span.\n');
end

% Plot the solutions
figure(2)
plot(t, y(:,1), 'r.', 'LineWidth', 1.5); hold on;
plot(t, y(:,2), 'g.', 'LineWidth', 1.5);
plot(t, y(:,3), 'b.', 'LineWidth', 1.5);


xlabel('Time(t)')
ylabel('C_A, T, T_j')
title('Solution of 3 ODEs using ode45')
legend('C_A(t)', 'T(t)', 'T_j(t)')
grid on

% Mark the steady state point
if ~isempty(steady_index)
    plot(t(steady_index), y(steady_index, :), 'ro', 'MarkerSize', 5, 'MarkerFaceColor', 'r');
    legend('C_A(t)', 'T(t)', 'T_j(t)')
end
hold off;