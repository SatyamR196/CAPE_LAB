#include <bits/stdc++.h>
using namespace std;
   // Process Variables:
    double T = (250 + 273);  // Temperature in Kelvin
    double T_c = (407.5);    // Critical temperature
    double P = (10);         // Pressure
    double P_c = (111.3);    // Critical pressure
    double R = 0.08206;      // Gas constant

    double a = 27 * R * R * T_c * T_c / (64 * P_c);  // Van der Waals 'a' constant
    double b = R * T_c / (8 * P_c);  // Van der Waals 'b' constant


double fxn(double v){
  return (P + (a / (v * v))) * (v - b) - R * T ;
}

double fxn_prime(double v){
    return (P + (a / (v * v))) - (2 * (a * (v - b)) / (v * v * v));
}

int main() {
 
    // Equation : (P + (a / v^2)) * (v - b) = R * T
    int T_itr = 20; // Maximum number of iterations
    // Tolerance limit
    double tol = 1e-6;
    // Unknown Variable (initial guess for v)
    double v = 10;
    cout<<fixed<<setprecision(8)<<"[iteration :"<<0<<"] : v = "<<v<<" (Initial Guess) "<<endl;
    // Iterative 
    for(int i=1 ;i<=T_itr ; i++){
        // Update v using Newton's method
        double v_new = v - (fxn(v) / fxn_prime(v));
        
        // Output the current iteration and the new value of v
        cout<<"[iteration :"<<i<<"] : v = "<<v_new<<endl;

        // Check if the change in v is small enough to stop
        if (abs(v_new - v) < tol) {
            cout << "Solution converged at " << i << "th iteration.\n";
            cout << "[ v = " << v_new <<" ]"<< endl;
            return 0;
        }
        v = v_new;  // Update v for the next iteration
    }

    // If it still not converged after maxIteration allowed then...
    cout << "Solution did not converge even after " << T_itr << " iterations.\n";
}
