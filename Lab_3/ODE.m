function val = ODE(t,Y)
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
e = 2.718;
R = 1.987 ;
%%
CA = Y(1) ; 
T = Y(2) ;
Tj = Y(3) ;
r = (k0 * CA * e^(-E/(R*T))) ;

% fprintf("value of r = %f",r);
val = [ (F*CAf - F*CA - r*V)/V ;
        (pCp*F*(Tf-T)+(-DeltaH)*V*r - UA*(T-Tj))/(pCp*V) ;
        (pjCj*Fj*(Tj0-Tj)+UA*(T-Tj))/(pjCj*Vj) ;
    ];
end