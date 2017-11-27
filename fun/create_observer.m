function [observer] = create_observer.m(ss, L, pars)
%% CREATES SS MODEL FOR OBSERVER
    A = tf(ss.A);
    B = tf(ss.B);
    C = tf(ss.C);
    L = tf(L);

    y_nl_in = icsignal(1); 
    u_nl_in = icsignal(2); 
    x_hat = icsignal(12); 
    y_hat = icsignal(1)
    x_hat_dot = icsignal(12);
    
    s = tf('s'); 

    M  = iconnect(); 
    M.Input = [u_nl_in, y_nl_in]; 
    M.Output = [x_hat, y_hat]; 
    M.Equation{1} = equate(x_hat_dot, B*u_nl_in + A*x_hat + L*(y_nl_in - y_hat));
    M.Equation{2} = equate(x_hat, s*x_hat_dot);
    M.Equation{3} = equate(y_hat, C*x_hat);
    
    observer = ss(M.System);
