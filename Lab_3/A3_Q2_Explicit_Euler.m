%define tolerance 
tol = 1e-6;

% Define the initial conditions: [y1, y2]
Y = [2; 0]; %-SS
% define step size h
h = 0.0008;
t = 0 ;

%stores
T =[];
Y_val = [];

for i=0:50000
    
    Y_new = Y + (h)*(ODE_Q2(t,Y)) ;
    T= [T,t] ;
    Y_val = [Y_val,Y_new];
    t = t + h ;
    err = Y_new - Y ;
    check = err < tol ;
    % if(check(1) && check(2) && t>50)
    %     break;
    % end
    
    Y = Y_new;
end

% disp(T);
% disp(X_val);
fprintf("total Iterations : %d\n",i);
fprintf("final values of y1, y2 are %f, %f:\n",Y(1),Y(2));
plot(T,Y_val(1,:),"r--","LineWidth",1.5);hold on;
plot(T,Y_val(2,:),"g--","LineWidth",1.5);
grid on;
xlabel('Time(t)')
ylabel('y1, y2')
title('Solution of 2 ODEs using Explicit Euler')
legend('y1', 'y2')
