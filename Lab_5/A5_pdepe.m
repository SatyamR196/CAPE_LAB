function heat_equation_pdepe()
    clear; clc; close all;

    % Define spatial domain
    L = 1;                % Length of the slab (m)
    Nx = 50;              % Number of spatial points
    x = linspace(0, L, Nx); % Spatial grid
    x = 0:0.1:L

    % Define fine time domain for better resolution
    % t_fine = linspace(0, 100, 10000); % More time steps for accuracy
    t_fine = 0:0.001:100
    t_out = [0 ,0.001, 0.01, 0.1, 100]; % Specific output time stamps

    % Thermal diffusivity values
    alpha_vals = [1, 10, 100]; % m^2/s

    % Solve for each alpha value
    for a = 1:length(alpha_vals)
        alpha = alpha_vals(a);

        % Solve PDE using pdepe
        sol = pdepe(0, @(x,t,T,dTdx) heat_pde(x,t,T,dTdx,alpha), ...
                       @heat_ic, ...
                       @heat_bc, x, t_fine);

        % Find nearest time indices in t_fine for t_out
        time_indices = arrayfun(@(t) findClosestIndex(t_fine, t), t_out);

        % Plot results
        figure;
        hold on;
        for j = 1:length(time_indices)
            plot(x, sol(time_indices(j), :), 'LineWidth', 2, 'DisplayName', ['t = ' num2str(t_out(j)) ' s']);
        end
        hold off;

        % Plot settings
        title(['Temperature Distribution (\alpha = ', num2str(alpha), ' m^2/s)']);
        xlabel('Position x (m)');
        ylabel('Temperature (K)');
        legend show;
        grid on;
    end
end

% Define the PDE function
function [c, f, s] = heat_pde(x, t, T, dTdx, alpha)
    c = 1;          % Time coefficient (standard form)
    f = alpha * dTdx; % Flux term with diffusivity
    s = 0;          % No source term
end

% Define the initial condition
function T0 = heat_ic(x)
    T0 = 350; % Initial temperature (K)
end

% Define the boundary conditions
function [pl, ql, pr, qr] = heat_bc(xl, Tl, xr, Tr, t)
    pl = Tl - 300; % Left boundary: T(0, t) = 300 K
    ql = 0;
    pr = Tr - 400; % Right boundary: T(1, t) = 400 K
    qr = 0;
end

% Helper function to find closest index
function idx = findClosestIndex(time_array, target_time)
    [~, idx] = min(abs(time_array - target_time));
end
