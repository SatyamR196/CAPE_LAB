    %given constants
    T0 = 100 ;
    Tm = 30 ;
    T_inf = 30 ;
    L = 2 ;
    B = 1.5 ;
    
    % derived constans
    h = 0.1 % mesh size
    n = (L-0)/ h ;
    % m = 0, 1, 2 ... n ;
    
    b1 = -B*h*h*T_inf ;
    % creation of matrix b
    b = zeros(n+1,1) ;
    b(1) = 100 ;
    b(n+1) = 30 ;
    
    for i = 2:n
        b(i) = b1;
    end

    % creation of matrix A
     A = zeros(n+1) ;
     A(1,1) = 1;
     A(n+1,n+1) = 1;
     
     for i = 1:n-1
         A(i+1,i) =  1;
         A(i+1,i+1) =  -(2+B*h*h) ;
         A(i+1,i+2) =  1;
     end
     
     T = A\b ;
     X = 0:h:2 ;
     plot(X,T,"b","LineWidth",1.5);hold on;
     plot(X,T,"r*","LineWidth",0.5);
     xlabel("x"),ylabel("T(C)");
     title("Temperature of Rod vs x");
     grid on;