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
k = 0.0001;      % Mesh size in time
m = (tn - to) / k; % Number of time steps
A = (k * a) / (h * h); % Stability parameter

% Initialize solution matrix
sol = zeros(m+1, n+2);  % n+2 to account for boundary points

% Initial conditions
sol(1, :) = T_0; % At t = 0, all points have initial temperature

% Boundary conditions
sol(:, 1) = To;   % At x = 0
sol(:, end) = Tn; % At x = L

% Construct coefficient matrix for implicit method
main_diag = (1 + 2*A) * ones(n, 1);
lower_diag = -A * ones(n-1, 1);
upper_diag = -A * ones(n-1, 1);
M = diag(main_diag) + diag(upper_diag, 1) + diag(lower_diag, -1);

% Time-stepping loop (Implicit method)
for j = 1:m
    % Right-hand side vector (previous time step)
    b = sol(j, 2:end-1)';  % Excluding boundary points
    
    % Apply boundary conditions correctly
    b(1) = b(1) + A * To;
    b(end) = b(end) + A * Tn;

    % Solve system using matrix inversion
    x = M \ b; % More numerically stable than inv(M) * b

    % Store solution at next time step
    sol(j+1, 2:end-1) = x';
end

% Define x-axis values (spatial positions)
x = linspace(0, L, n+2);

% Animation setup
figure;
hold on;
title('Temperature Distribution Over Time');
xlabel('Position x (m)');
ylabel('Temperature T (K)');
grid on;
axis([0, L, min(To, T_0)-10, max(Tn, T_0)+10]); % Set axis limits
hLine = plot(x, sol(1, :), 'b', 'LineWidth', 2); % Ensure this is created before updating

legend('Temperature Profile');

% Animate the temperature profile
for j = 1:10:m  % Skip some frames for efficiency
    if isvalid(hLine)  % Check if the plot handle is valid before updating
        set(hLine, 'YData', sol(j, :)); % Update plot
        title(sprintf('Temperature Distribution at t = %.2f s', j * k));
        pause(0.09); % Pause to control animation speed
    else
        break; % Exit the loop if the plot object is invalid
    end
end

hold off;
