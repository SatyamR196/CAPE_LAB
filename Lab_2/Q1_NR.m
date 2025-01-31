% Defining Parameters (constant)
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
e = 2.718;
R = 1.987 ;               % Universal Gas constant in Cal/mol*K

%%

% defining symbolic function and derivatives
syms CA T Tj

f = F*CAf - F*CA - (k0 * CA * e^(-E/(R*T)))*V ;
disp(f);
double(subs(f,[CA,T],[1.405435,387.38348]))
df_dCA = diff(f,CA) ;
df_dT = diff(f,T) ;
df_dTj = diff(f,Tj) ;

g = pCp*F*(Tf-T)+(-DeltaH)*V*(k0 * CA * e^(-E/(R*T))) - UA*(T-Tj) ;
dg_dCA = diff(g,CA) ;
dg_dT = diff(g,T) ;
dg_dTj = diff(g,Tj) ;

h = pjCj*Fj*(Tj0-Tj)+UA*(T-Tj) ;
dh_dCA = diff(h,CA) ;
dh_dT = diff(h,T) ;
dh_dTj = diff(h,Tj) ;

J = [
    df_dCA, df_dT, df_dTj ;
    dg_dCA, dg_dT, dg_dTj ;
    dh_dCA ,dh_dT, dh_dTj ;
    ];

%%
%initial Guess, take T in K, CA in mol/m3 
% X = [C_a; T ;T_j;] ;

% for initial guess 1 On T = 300K
% X = [8.963732, 308.777185, 299.796198] ; 

% for initial guess 2 On T= ___ K
% X = [6.1795, 337.7327, 304.6221] ; NOT Found 

% for initial guess 3 On T = 370 K
% X = [1.405435,387.38348, 312.897247] ; 

% Initial guess matrix
X = [0; 370; 100];

max_itr=100;
tol = [1e-6; 1e-6; 1e-6] ;

%%

for i=1:max_itr
    fprintf("\nIteration : %d\n",i);
    J = double(subs(J,[CA,T,Tj],X')) ;
    % X_new = X - inv(J) * Equation1(X)
    X_new = X - J\Equation1(X);
    fval = Equation1(X_new);
    fprintf('X_new : %.6f\n', X_new);
    fprintf('X     : %.6f\n', X);
    fprintf('F     : %.6f\n', fval);

    check = X_new-X < tol ;
    if(check(1) && check(2) && check(3))
        break;
    end

    X = X_new ;
end
