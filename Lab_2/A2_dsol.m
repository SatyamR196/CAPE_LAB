% Define the constants
F = 1;
CA_prime = 10;
V = 1;
UA = 150;
k0 = 36e6;
Tj0 = 298;
delta_H = -6500;
rho_Cp = 500;
rhoj_Cj = 600;
Fj = 1.25;
Vj = 0.25;
Tf = 298;
E = 12000;
R = 1.987;  % Gas constant in kcal/(kgmol·K)

% Define the system of equations
equations = @(vars) [
    F * CA_prime - F * vars(1) - k0 * exp(-E / (R * vars(2))) * vars(1) * V;
    rho_Cp * F * (Tf - vars(2)) + (-delta_H) * V * k0 * exp(-E / (R * vars(2))) * vars(1) - UA * (vars(2) - vars(3));
    rhoj_Cj * Fj * (Tj0 - vars(3)) + UA * (vars(2) - vars(3))
];

% Initial guesses for CA, T, and Tj
initial_guesses = [10; 298; 298];
disp(equations(initial_guesses));
% Solve the system of equations
options = optimoptions('fsolve', 'Display', 'iter');  % Display iteration information
[solution, fval, exitflag] = fsolve(equations, initial_guesses, options);

% Display the solution
if exitflag > 0
    fprintf('Solution found:\n');
    fprintf('CA = %.4f kgmol/m^3\n', solution(1));
    fprintf('T = %.4f K\n', solution(2));
    fprintf('Tj = %.4f K\n', solution(3));
    disp(fval);
else
    fprintf('Failed to converge to a solution.\n');
end
%%
% Solution found:
% CA = 1.4094 kgmol/m^3
% T = 387.3423 K
% Tj = 312.8904 K

% Solution found:
% CA = 8.9686 kgmol/m^3
% T = 308.7270 K
% Tj = 299.7878 K