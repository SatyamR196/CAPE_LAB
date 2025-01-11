%Bisection Method
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

%initial guess such that f2>0 and f1<0
maxItr = 100;
v1 = 1 ;
v2 = 8;
fprintf("(f1,v1)=(%f,%f) and (f2,v2)=(%f,%f) \n",fxn(v1),v1,fxn(v2),v2);
% 
% v = (v1+v2)/2 ;

for i=0:maxItr
    v = (v1+v2)/2 ;
    if(fxn(v)>=0)
        v2 = v;
    else
        v1 = v;
    end
    err = (v2-v1) ;

    fprintf("%d: %5f, err=%f \n",i,v,err);

    if(abs(err)<tol)
        break;
    end

end
toc