%given constants
To = 100 ;
Tm = 30 ;
T_inf = 30 ;
L = 2 ;
B = 1.5 ;

%shooting guess initial
s = -154 ;

% Define mesh i.e. discritization of spatial domain.
x = 0:0.1:2 ;

correct_sVal = fzero(@errorVal,0) ;

[e,T] = errorVal(correct_sVal) ;
figure(1)
plot(x,T,"r","LineWidth",1.5);
hold on;
plot(x,T,"b*");
xlabel('x');
ylabel('Temperature');
title('Temperature Distribution using Shooting Method');

%%
function [e,T] = errorVal(s)
    To = 100 ;Tm = 30 ;
    x = 0:0.1:2 ;
    
    % Initial guess
    Ti = [To; s];
    
    [x,T] = ode45(@odefxn, x, Ti) ;
    
    x
    Tb = T(end,1)
    T = T(:,1)
    e = Tm - Tb 
end


%%

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

