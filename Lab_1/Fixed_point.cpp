#include <bits/stdc++.h>
using namespace std;

int main() {
    // Process Constants
    double T = 250 + 273;          // Temperature in Kelvin
    double T_c = 407.5;            // Critical temperature
    double P = 10;                 // Pressure
    double P_c = 111.3;            // Critical pressure
    double R = 0.08206;            // Gas constant
    double a = 27 * R * R * T_c * T_c / (64 * P_c); 
    double b = R * T_c / (8 * P_c);

    // Initial guess
    double v_old = b + (R * T) / P;
    double v_new = 0.0;
    cout<<setprecision(10)<<"[iteration :"<<0<<"] : v = "<<v_old<<" (Initial Guess) "<<endl;

    // Iterative process constants
    int maxIteration = 25;
    double tol = 1e-6;
    
    for(int i=1 ;i<=maxIteration ; i++){
        // Fixed-point iteration formula
        // Formula 1 :-
        // v_new = (((R*T + P*b)/a)*v_old*v_old) + b - ((P*v_old*v_old*v_old)) ; 
        // Formula 2 :
        v_new = b + (R * T) / (P + (a / (v_old * v_old)));
        
        // Printing succesive values of v;
        cout<<"[iteration :"<<i<<"] : v = "<<v_new<<endl;
        
        // Check convergence
        if (abs(v_new - v_old) < tol) {
          cout << "Solution converged at " << i << "th iteration.\n";
          cout << "[ v = " << v_new <<" ]"<< endl;
          return 0;
        }
        
        // Update v_old for next iteration
        v_old = v_new;
    }

    // If it still not converged after maxIteration allowed then..
    cout << "Solution did not converge even after " << maxIteration << " iterations.\n";
}
