    %given constants
    % i -->> x , i= 0, 1, 2 ... n
    To = 300 ;
    Tn = 400 ;
    T_0 = 350 ; % at t=0
    % j -->> t , j= 0, 1, 2 ... m
    to = 0 ;
    tn = 100 ;
    L = 1 ;
    a = 1 ; % Value of alpha, 
    
    % derived constans
    % h = 0.2 ; % mesh size in x-space
    h = 0.1 ; % mesh size in x-space
    n = (L-0)/ h ;
    % k = 0.01 ; % mesh size in time
    k = 0.005 ; % mesh size in time
    m = (tn-to)/k ;
    A = (k*a)/(h*h)  % mesh parameter
    % A = 0.1

    sol = zeros(m+1,n+1) ;

    for i=1:n+1
        sol(1,i) = T_0;
    end

    for j=1:m+1
        sol(j,1) = To;
        sol(j,n+1) = Tn;
    end
    
    sol(1,n+1) = (T_0+Tn)/2 ; 
    sol(1,1) = (T_0+To)/2 ; 
    sol
    
    for j=1:m
        % if(j==1) 
        %     continue ;
        % end
        for i=2:n
            sol(j+1,i) = A*sol(j,i-1) + (1-2*A)*sol(j,i) + A*sol(j,i+1) ; 
        end
    end

    % disp(sol(2,10));  

    for j=1:m+1
        for i=1:n+1
            fprintf("%d ",sol(j,i));
        end
        fprintf("\n");
    end
    figure(1)
    plot(sol(2,:)); hold on;
    plot(sol(3,:))
    plot(sol(4,:))
    plot(sol(6,:))
    plot(sol(8,:))
    plot(sol(10,:))
    plot(sol(11,:)) ;
    plot(sol(21,:)) ;
