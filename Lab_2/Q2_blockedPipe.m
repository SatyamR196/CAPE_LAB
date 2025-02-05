% Define known parameters (k values)
f = 0.005 ;%friction factor
p = 1000 ;% density
D = 0.154 ;
L01 = 100;
% L12 = L23 = L45 = 300;
% L13 = L24 = L34 = 1200;
% pre-calculated
k_01 = 122.43; 
k_12 = 367.29;
k_23 = 367.29;  
k_13 = 1469.17;
k_24 = 1469.17;
k_34 = 1469.17;
k_45 = 367.29;

% k = @(i,j) 2*
  %  q(2) - (q(3) + q(5));                                  % Node 2: q12 = q23 + q24
% Define the equations
equations = @(q) [
    q(1) - (q(2) + q(4));                                  % Node 1: q01 = q12 + q13
    q(2) - q(3) ;                                          % Nofr 3: q12 - q23 = 0
    q(4) + q(3) - q(5);                                    % Node 3: q13 + q23 = q34
    q(5) - q(6);                                           % Node 4: q34 - q45 = 0 ;
    k_12*q(2)^2 + k_23*q(3)^2 - k_13*q(4)^2;               % Loop I: ΔP12 + ΔP23 = ΔP13
    q(1) - q(6)  ;                                         % Flow consistency: q01 = q45
];

% Initial guess for the flow rates
% initial_guess = [q01; q12; q23; q13; q34; q45];
initial_guess = [1; 1; 1; 1; 1; 1];

% Solve the equations using fsolve
options = optimoptions('fsolve','Display','iter','MaxIter',1000,'MaxFunctionEvaluations',10000); % Adjust tolerances if needed
[Q, fval, exitflag] = fsolve(equations, initial_guess, options);

fprintf("CASE 2 : Pipe 24 is blocked");
% Display the solution
if exitflag > 0
    fprintf('The solution for the flow rates (m^3/s) is:\n');
    fprintf('q01 = %.6f\n', Q(1));
    fprintf('q12 = %.6f\n', Q(2));
    fprintf('q23 = %.6f\n', Q(3));
    fprintf('q13 = %.6f\n', Q(4));
    fprintf('q24 = %.6f\n', 0);
    fprintf('q34 = %.6f\n', Q(5));
    fprintf('q45 = %.6f\n', Q(6));
    fprintf('The solution for Pressure drops (bar) is:\n');
    fprintf('dP01 = %.6f\n', k_01*Q(1)^2);
    fprintf('dP12 = %.6f\n', k_12*Q(2)^2);
    fprintf('dP23 = %.6f\n', k_23*Q(3)^2);
    fprintf('dP13 = %.6f\n', k_13*Q(4)^2);
    fprintf('dP24 = %.6f\n', 0);
    fprintf('dP34 = %.6f\n', k_34*Q(5)^2);
    fprintf('dP45 = %.6f\n', k_45*Q(6)^2);
    
    % disp(fval);
else
    fprintf('The solver did not converge. Check your equations or initial guess.\n');
end
