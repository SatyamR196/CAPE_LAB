%% Additional code for finding run time.
totalRuns = 111 ;
timeTaken = 0;
%% Main Section :
for run = 1:totalRuns
    tic
    % Start of Main code :-
    % Matlab Inbuilt fxn fzero
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
    v = 10 ;
    v_new = fzero(fxn,v) ;
    fprintf("Solution of given equation, v = %5f \n",v_new);
    % End of Main code :-
    timeTaken = timeTaken + toc ;
    toc
end
%% For calculation of avg run time
fprintf("The total time taken = %f for %d runs \n",timeTaken,totalRuns);
fprintf("The Avg. time taken = %f sec\n",timeTaken/totalRuns);
%%
% Main script
% x = 3;
% b = 5;
% y = squareSum(x,b);
% disp(y); % Output: 9
%
% % Local function
% function [result] = squareSum(x,y)
%     result = x^2+y^2;
% end




