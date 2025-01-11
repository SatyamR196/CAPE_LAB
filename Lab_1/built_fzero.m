% Matlab Inbuilt fxn fzero
clc,clearvars,tic
% Tolerance limit
tol = 1e-6 ;
% Process Variables:
T = (250 + 273) ;
T_c = (407.5) ;
P = (10) ;
P_c = (111.3) ;
R = 0.08206 ;
a = 27*R*R*T_c*T_c/(64*P_c);
b = R*T_c/(8*P_c);
% functions Required
fxn = @(v) (P + a/v^2) * (v - b) - R * T ;
% initial guess
v = 101 ;
v_new = fzero(fxn,v) ;
fprintf("Solution of given equation, v = %5f \n",v_new);
toc