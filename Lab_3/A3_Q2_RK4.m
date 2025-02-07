%define tolerance 
tol = 1e-6;

% Define the initial conditions: [y1, y2]
Y = [2; 0]; %-SS
% define step size h
h = 0.0008;
t = 0 ;

%stores
T =[];
X_val = [];

for i=0:80000
    k1 = ODE_Q2(t,Y) ;
    k2 = ODE_Q2(t+h/2,Y+(h/2)*k1) ;
    k3 = ODE_Q2(t+h/2,Y+(h/2)*k2) ;
    k4 = ODE_Q2(t+h/2,Y+h*k3) ;
    
    X_new = Y + (h/6)*(k1+2*k2+2*k3+k4) ;
    T= [T,t] ;
    X_val = [X_val,X_new];
    t = t + h ;
    err = X_new - Y ;
    check = err < tol ;
    % if(check(1) && check(2) && t>50)
    %     break;
    % end
    
    Y = X_new;
end

% disp(T);
% disp(X_val);
fprintf("total Iterations : %d\n",i);
fprintf("final values of y1, y2 are %f, %f:\n",Y(1),Y(2));
plot(T,X_val(1,:),"r.","LineWidth",1.5);hold on;
plot(T,X_val(2,:),"g.","LineWidth",1.5);
grid on;
xlabel('Time(t)')
ylabel('y1, y2')
title('Solution of 2 ODEs using RK4')
legend('y1', 'y2')
