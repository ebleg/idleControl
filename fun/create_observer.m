function [L] = create_observer(system,pars)
%% CREATES SS MODEL FOR OBSERVER
% Determine observer gain
B_in = system.ext.B*system.ext.B';
L  = (lqr(system.ext.A', system.ext.C', B_in, pars.des.q))';
% 
% % Build observer system
% % Convert matrices to transfer functions
A = system.ext.A;
B = system.ext.B;
C = system.ext.C;
integrate = tf([1],[1 0]);
% 
% % Create signals for iconnect
y_nl_in = icsignal(1); % normalized output signal from nonlinear plant
u_nl_in = icsignal(2); % normalized input signal for nonlinear plant
x_hat = icsignal(11); % states as predicted by the observer
y_hat = icsignal(1); % output as predicted by the observer
x_hat_dot = icsignal(11); % intermediate signal; time-derivative of x_hat
% 
% % Connect observer blocks and signals
M = iconnect;
M.Input = [u_nl_in; y_nl_in];
M.Output = [x_hat; y_hat];
% Equation 1: everything before integrator
M.Equation{1} = equate(x_hat_dot, B*u_nl_in + A*x_hat + L*(y_nl_in - y_hat));
% Equation 2: integrate time derivatives of states
M.Equation{2} = equate(x_hat, integrate*x_hat_dot);
% Equation 3: multiply with C to get output from the states
M.Equation{3} = equate(y_hat, C*x_hat);
observer_tf = minreal(tf(M.System));

% % Create state-space representation for the observer system
observer = minreal(ss(observer_tf));

end

