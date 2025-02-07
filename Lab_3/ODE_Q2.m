function val = ODE_Q2(t,Y)
    y1 = Y(1) ;
    y2 = Y(2) ;
    val = [ y2 ;
            1000*(1-y1^2)*y2 - y1 ;
        ];
end