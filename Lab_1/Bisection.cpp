#include <bits/stdc++.h>
using namespace std;
// #define double long double
// Tolerance limit
double tol = 1e-6 ;
// Process Variables:
double T = (250 + 273) ;
double T_c = (407.5) ;
double P = (10) ;
double P_c = (111.3) ;
double R = 0.08206 ;
double a = 27*R*R*T_c*T_c/(64*P_c);
double b = R*T_c/(8*P_c);
// Unknown Variable
double v;
// Given Function 
double fxn(double v){
  return ( ( P + (a/(v*v)) ) *  (v-b) ) - ( R * T );
}

int main() 
{
  double v1 = 1; // inital guess 1
  double v2 = 8; // inital guess 1
  double f1,f2,f ;
  f1 = fxn(v1);
  f2 = fxn(v2);
  double v = (v1+v2)/2 ;
  f = fxn(v) ;
  cout<<setprecision(10)<<"f1( at initial guess = "<<v1<<" ) : "<<f1<<" ;  "<<"f2( at initial guess = "<<v2<<" ) : "<<f2<<endl;
  
  int i=0;
  double e=1;
  // cout<<(long double)(2.0/3)<<endl;
  // cout<<"[iteration :"<<i++<<"] : v = "<<v<<endl;
  while(abs(e)>=tol){
    f1 = fxn(v1);
    f2 = fxn(v2);
    v = (v1+v2)/2 ;
    f = fxn(v) ;

    cout<<"[iteration :"<<i++<<"] : v1 = "<<v1<<" : v2 = "<<v2<<" : v = "<<v<<endl;
    if(f >= 0){
      v2 = v;
      e=v-v1;
    } 
    else{
      v1 = v;
      e=v-v2;
    }
  }
  cout<<"Final value of f = "<<f<<" "<<"at [ v = "<<v<<" ]"<<endl;
}