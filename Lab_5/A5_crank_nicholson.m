% Given constants
To = 300;       % Left boundary temperature (x = 0)
Tn = 400;       % Right boundary temperature (x = L)
T_0 = 350;      % Initial temperature for all x (t=0)
to = 0;         % Initial time
tn = 100;       % Final time
L = 1;          % Length of the slab
a = 1;          % Thermal diffusivity alpha

% Derived constants
h = 0.1;        % Mesh size in x-space
n = (L - 0) / h - 1; % Number of spatial points excluding boundaries
k = 0.5;      % Mesh size in time
m = (tn - to) / k; % Number of time steps
A = (k * a) / (h^2); % Crank-Nicolson coefficient
fprintf("value of A is %d ", A);
% Initialize solution matrix
sol = zeros(m+1, n+2);  % n+2 to account for boundary points

% Initial conditions
sol(1, :) = T_0; % Initialize to T_0 everywhere

% Boundary conditions
sol(:, 1) = To;   % Fixed boundary at x = 0
sol(:, end) = Tn; % Fixed boundary at x = L
sol(1,n+1) = (T_0+Tn)/2 ; 
sol(1,1) = (T_0+To)/2 ;
% Construct coefficient matrices for Crank-Nicolson
main_diag_L = (2 + 2*A) * ones(n, 1);
lower_diag_L = -A * ones(n-1, 1);
upper_diag_L = -A * ones(n-1, 1);
M_L = diag(main_diag_L) + diag(upper_diag_L, 1) + diag(lower_diag_L, -1);

main_diag_R = (2 - 2*A) * ones(n, 1);
lower_diag_R = A * ones(n-1, 1);
upper_diag_R = A * ones(n-1, 1);
M_R = diag(main_diag_R) + diag(upper_diag_R, 1) + diag(lower_diag_R, -1);
M_L
% Time-stepping loop (Crank-Nicolson method)
for j = 1:m
    % Right-hand side vector
    u = sol(j, 2:end-1)';
    b = M_R * u; % Compute RHS using explicit part

    % Apply boundary conditions
    b(1) = b(1) + A * To;
    b(end) = b(end) + A * Tn;

    % Solve system using matrix inversion
    x = M_L \ b; % More numerically stable than inv(M_L) * b

    % Store solution at next time step
    sol(j+1, 2:end-1) = x';
end
M_L
% Define x-axis values (spatial positions)
x = linspace(0, L, n+2);

% Select time stamps for plotting
time_stamps = [0, 0.001, 0.01, 0.1, 1]; % Time values in seconds
time_indices = round(time_stamps / k) + 1; % Convert to index

% Plot temperature distribution at selected time stamps
figure;
hold on;
colors = ['b', 'r', 'g', 'm', 'k']; % Colors for different time stamps

for idx = 1:length(time_stamps)
    plot(x, sol(time_indices(idx), :), 'Color', colors(idx), 'LineWidth', 2);
end

xlabel('Position x (m)');
ylabel('Temperature T (K)');
title('Temperature Distribution at Different Time Stamps');
legend(arrayfun(@(t) sprintf('t = %d s', t), time_stamps, 'UniformOutput', false));
grid on;
hold off;
