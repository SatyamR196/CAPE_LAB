% given constants
To = 100 ;
Tm = 30 ;
T_inf = 30 ;
L = 2 ;
B = 1.5 ;

% linspace(0, L, 100) creates a vector x with 100 equally spaced points starting from 0 and ending at L.

% Define mesh i.e. discritization of spatial domain.
x = 0:0.1:2 ;

% Initial guess
T = [To; 0];

% Set up the BVP
solinit = bvpinit(x,T);

% Using bvp4c to solve the fxn
sol = bvp4c(@odefxn,@bcfxn,solinit);

% plot(sol.x,sol.yp)
T = sol.y(1,:);
plot(sol.x, T,"LineWidth",1.5);hold on;
plot(sol.x, T,"r*");
xlabel('x');
ylabel('Temperature');
title('Temperature Distribution in Fin');

% T = [ 100 ; 30 ] ;
% odefxn(0,T) 

% odefxn = @(x,T) [ T(2) ; B*(T(1)-T_inf)] ;
function dT_dx = odefxn (~,T)
    B = 1.5 ;
    T_inf = 30 ;
    T1 = T(1) ;
    T2 = T(2) ;
 
    dT_dx = [ T2 ;
              B*(T1-T_inf)
            ]; 
end

% Below fxn will find out the differnce between calculated T1 at boundaries
% and given T1 values at boundaries
% Boundary conditions function
function err = bcfxn(Ta, Tb)
    To = 100;
    Tm = 30;
    
    err = [ Ta(1) - To;   % At x = 0, T = To
            Tb(1) - Tm ]; % At x = L, T = Tm
end