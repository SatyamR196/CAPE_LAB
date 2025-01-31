% Assignment_2 Q1
% Parameters (constant)
F = 1;                    % Flow rate (m^3/h)
V = 1;                    % Reactor volume (m^3)
k0 = 36e6;                % Reaction rate constant (h^-1)
DeltaH = -6500;           % Heat of reaction (kcal/kgmol)
E = 12000;                % Activation energy (kcal/kgmol)
pCp = 500;                % Heat capacity of the fluid (kcal/m^3°C)
Tf = 298;                 % Feed temperature (K)
CAf = 10;                 % Feed concentration (kgmol/m^3)
UA = 150;                 % Heat transfer coefficient (kcal/°C·h)
Tj0 = 298;                % Initial jacket temperature (K)
pjCj = 600;               % Heat capacity of the jacket fluid (kcal/m^3°C)
Fj = 1.25;                % Jacket fluid flow rate (m^3/h)
Vj = 0.25;                % Jacket volume (m^3)

% Display the parameters
disp('Parameters have been set.');
%initial Guess, take T in K, CA in mol/m3 
% X = [C_a; T ;T_j;] ;

% for initial guess 1 On T = 340K
% X = [8.963732, 308.777185, 299.796198] ; 

% for initial guess 2 On T= 370 K
% X = [6.1795, 337.7327, 304.6221] ; 

% for initial guess 3 On T = 400 K
% X = [1.405435,387.38348, 312.897247] ; 

X = [0;400;100] ;
Equation1(X);
options = optimoptions('fsolve','Display','iter','MaxIter',1000,'MaxFunctionEvaluations',500);
[x,fval] = fsolve(@Equation1,X,options);
fprintf('X : %.6f\n', x);
fprintf('F : %.6f\n', fval);

% function [Fxn] = Equation1 (X)
% CA = X(1) ; 
% T = X(2) ;
% Tj = X(3) ;
% r = k0 * CA * e^(-E/R*T) ;
% Fxn = [F*CAf - F*CA - r*V ;
%     pCp*F*(Tf-T)+(-DeltaH)*V*r - UA*(T-Tj);
%     pjCj*Fj*(Tj0-Tj)+UA*(T-Tj);
%     ];
% end

