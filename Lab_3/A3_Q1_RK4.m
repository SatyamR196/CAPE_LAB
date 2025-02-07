%define tolerance 
tol = 1e-6;

% Define the initial conditions: [CA, T, Tj]
% X = [0; 370; 300]; %-SS
X = [1.33 ; 367; 297];
% define step size h
h = 0.01
t = 0 ;

%stores
T =[];
X_val = [];

for i=0:1000
    k1 = ODE(t,X) ;
    k2 = ODE(t+h/2,X+(h/2)*k1) ;
    k3 = ODE(t+h/2,X+(h/2)*k2) ;
    k4 = ODE(t+h/2,X+h*k3) ;
    
    X_new = X + (h/6)*(k1+2*k2+2*k3+k4) ;
    T= [T,t] ;
    X_val = [X_val,X_new];
    t = t + h ;
    % err = X_new - X ;
    % check = err < tol ;
    % if(check(1) && check(2) && check(3) && t>50)
    %     break;
    % end
    
    X = X_new;
end
X_val_tr = X_val';
fprintf("total Iterations : %d\n",i);
fprintf("final values of CA, T, Tj are %f, %f, %f:\n",X(1),X(2),X(3));
figure (1);
hold on;
plot(T,X_val(1,:),"r.","LineWidth",1.5);
plot(T,X_val(2,:),"g.","LineWidth",1.5);
plot(T,X_val(3,:),"b.","LineWidth",1.5);
grid on;
xlabel('Time(t)')
ylabel('CA, T, Tj')
title('Solution of 3 ODEs using ode45')
legend('CA(t)', 'T(t)', 'Tj(t)')
