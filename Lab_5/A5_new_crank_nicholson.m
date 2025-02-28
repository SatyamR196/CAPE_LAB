% Numerical Solution of 1D Heat Conduction using Crank-Nicholson Method

% Problem Parameters
L = 1;                          % Length of the slab (m)
alpha_values = [1, 10, 100];    % Thermal diffusivity values (m^2/s)
t_values = [0, 0.001, 0.01, 0.1, 1]; % Time values to evaluate (s)
Nx = 11;                        % Number of spatial grid points
dx = L / (Nx - 1);              % Spatial step size
x = linspace(0, L, Nx);         % Spatial grid

% Boundary and Initial Conditions
T0 = 350;                       % Initial temperature (K)
T_left = 300;                   % Left boundary temperature (K)
T_right = 400;                  % Right boundary temperature (K)

% Crank-Nicholson Parameter
theta = 0.5;                    % Crank-Nicholson weighting factor

% Loop over each thermal diffusivity value
for k = 1:length(alpha_values)
    alpha = alpha_values(k);    % Current thermal diffusivity value
    fprintf('Solving for alpha = %.2f m^2/s\n', alpha);
    
    % Time step size based on stability considerations
    dt = 0.0001;                 % Time step size (s) - small for accuracy
    Nt = ceil(max(t_values) / dt); % Number of time steps
    time = linspace(0, Nt * dt, Nt + 1); % Time grid
    
    % Initialize Temperature Matrix
    T = zeros(Nx, Nt + 1);
    T(:, 1) = T0;               % Apply initial condition
    T(1, :) = T_left;           % Apply left boundary condition
    T(end, :) = T_right;        % Apply right boundary condition
    
    % Crank-Nicholson Coefficients
    r = alpha * dt / (2 * dx^2);
    a_diag = -r * ones(Nx - 2, 1);       % Lower diagonal coefficients
    b_diag = (1 + 2 * r) * ones(Nx - 2, 1); % Main diagonal coefficients
    c_diag = -r * ones(Nx - 2, 1);       % Upper diagonal coefficients
    
    A = diag(a_diag(2:end), -1) + diag(b_diag) + diag(c_diag(1:end-1), 1); % Tridiagonal matrix
    
    % Time-stepping loop using Crank-Nicholson scheme
    for n = 1:Nt
        rhs = r * T(3:Nx, n) + (1 - 2 * r) * T(2:Nx-1, n) + r * T(1:Nx-2, n); % Right-hand side vector
        
        % Apply boundary conditions to RHS
        rhs(1) = rhs(1) + r * T_left;
        rhs(end) = rhs(end) + r * T_right;
        
        % Solve the tridiagonal system A*T_new = rhs
        T(2:Nx-1, n+1) = A \ rhs;
        
        % Boundary conditions already applied in T(:, n+1)
    end
    
    % Extract and plot results at specified times
    figure;
    hold on;
    for t_idx = 1:length(t_values)
        [~, time_index] = min(abs(time - t_values(t_idx)));   % Find closest time index
        plot(x, T(:, time_index), 'DisplayName', sprintf('t = %f s', t_values(t_idx)));
    end
    
    hold off;
    xlabel('Position x (m)');
    ylabel('Temperature T(x,t) (K)');
    title(sprintf('Temperature Distribution for \\alpha = %.0f m^2/s', alpha));
    legend('Location', 'best');
    grid on;
end

