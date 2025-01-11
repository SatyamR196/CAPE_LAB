% Fixed point Iteration
clc
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
maxItr = 100;
%initial guess for v
v = 10 ;
fprintf("0: %5f \n",v);
for(i=1:maxItr)
    v_new = b + (R*T)/(P+a/v^2) ;
    fprintf("%d: %5f \n",i,v_new);
    if(abs(v_new-v)<tol)
        break;
    end
    v= v_new ;
end




